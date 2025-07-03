import 'package:console/database.dart';
import 'package:console/package_data_service.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

class PackageData {
  final String packageName;
  final String? devAnalyzerVersion;
  final String? devVersion;
  final DateTime devDate;
  final DateTime? publishedDate;
  final String? publishedVersion;
  final String? repoUrl;

  PackageData({
    required this.packageName,
    required this.devAnalyzerVersion,
    required this.devVersion,
    required this.devDate,
    required this.publishedDate,
    required this.repoUrl,
    required this.publishedVersion,
  });
}

class PubspecInfo {
  final String version;
  final String? analyzerVersion;

  PubspecInfo({required this.version, required this.analyzerVersion});
}

Future<PackageData?> fetchPackageData(client, String packageName) async {
  final details = await client.packageInfo(packageName);
  final publishedDate = details.latest.published;
  final publishedVersion = details.latest.version;
  final info = await client.packageMetrics(packageName);
  var repoUrl = info?.scorecard.panaReport?.result?.repositoryUrl;

  final pubspecInfo =
      repoUrl == null ? null : await downloadAndExtractAnalyzerVersion(repoUrl);
  return PackageData(
    packageName: packageName,
    devAnalyzerVersion: pubspecInfo?.analyzerVersion,
    devVersion: pubspecInfo?.version,
    devDate: DateTime.now(),
    publishedDate: publishedDate,
    publishedVersion: publishedVersion,
    repoUrl: repoUrl,
  );
}

/// Downloads pubspec.yaml from the repository URL and extracts the analyzer package version
///
/// Handles both GitHub and GitLab repositories by converting the repo URL to raw file URL.
/// Searches for analyzer package in both dependencies and dev_dependencies sections.
/// Attempts multiple strategies for finding the pubspec.yaml file.
Future<PubspecInfo?> downloadAndExtractAnalyzerVersion(String repoUrl) async {
  try {
    final pubspecUrl = convertToPubspecRawUrl(repoUrl);
    print('Downloading pubspec.yaml from: $pubspecUrl');

    var response = await http.get(Uri.parse(pubspecUrl));

    // If main branch fails and it's a GitHub repo, try master branch
    if (response.statusCode == 404 && repoUrl.contains('github.com')) {
      final masterUrl = pubspecUrl.replaceAll('/main/', '/master/');
      if (masterUrl != pubspecUrl) {
        print('Trying master branch: $masterUrl');
        response = await http.get(Uri.parse(masterUrl));
      }
    }

    if (response.statusCode == 200) {
      final yamlContent = response.body;
      return readPubspec(yamlContent);
    } else {
      print(
        'Failed to download pubspec.yaml. Status code: ${response.statusCode}',
      );
    }
  } catch (e) {
    print('Error downloading or parsing pubspec.yaml: $e');
  }
  return null;
}

/// Converts repository URL to raw pubspec.yaml URL
///
/// Supports GitHub and GitLab repositories by transforming the URL format
/// to point directly to the raw pubspec.yaml file. Handles various repository
/// structures including monorepos with subdirectories.
String convertToPubspecRawUrl(String repoUrl) {
  // Remove trailing slash if present
  final cleanUrl =
      repoUrl.endsWith('/')
          ? repoUrl.substring(0, repoUrl.length - 1)
          : repoUrl;

  if (cleanUrl.contains('github.com')) {
    // Handle special GitHub URL patterns that include subdirectories or specific paths
    if (cleanUrl.contains('/tree/')) {
      // Extract base repo URL and try to construct proper raw URL
      final parts = cleanUrl.split('/tree/');
      if (parts.length >= 2) {
        final baseRepo = parts[0];
        final pathParts = parts[1].split('/');
        if (pathParts.isNotEmpty) {
          final branch = pathParts[0];
          final subPath =
              pathParts.length > 1 ? '/${pathParts.skip(1).join('/')}' : '';
          final githubRawUrl = baseRepo
              .replaceFirst(
                'https://github.com/',
                'https://raw.githubusercontent.com/',
              )
              .replaceFirst(
                'http://github.com/',
                'https://raw.githubusercontent.com/',
              );
          return '$githubRawUrl/$branch$subPath/pubspec.yaml';
        }
      }
    }

    // Standard GitHub conversion
    final githubRawUrl = cleanUrl
        .replaceFirst(
          'https://github.com/',
          'https://raw.githubusercontent.com/',
        )
        .replaceFirst(
          'http://github.com/',
          'https://raw.githubusercontent.com/',
        );

    // Try both main and master branches
    return '$githubRawUrl/main/pubspec.yaml';
  } else if (cleanUrl.contains('gitlab.com')) {
    // Convert GitLab URL: https://gitlab.com/user/repo -> https://gitlab.com/user/repo/-/raw/main/pubspec.yaml
    return '$cleanUrl/-/raw/main/pubspec.yaml';
  } else {
    // Fallback: assume it's a direct URL or try to append pubspec.yaml
    return '$cleanUrl/pubspec.yaml';
  }
}

/// Extracts analyzer package version from YAML content
///
/// Parses the YAML and searches for analyzer package in both dependencies
/// and dev_dependencies sections. Returns the version constraint if found.
PubspecInfo? readPubspec(String yamlContent) {
  try {
    final dynamic yamlDoc = loadYaml(yamlContent);

    if (yamlDoc is! Map) {
      return null;
    }

    final yamlMap = yamlDoc;

    // Check dependencies section
    String? analyzerVersion;
    final dependencies = yamlMap['dependencies'] as Map<dynamic, dynamic>?;
    if (dependencies?.containsKey('analyzer') == true) {
      analyzerVersion = dependencies!['analyzer'].toString();
    }

    // Check dev_dependencies section
    if (analyzerVersion == null) {
      final devDependencies =
          yamlMap['dev_dependencies'] as Map<dynamic, dynamic>?;
      if (devDependencies?.containsKey('analyzer') == true) {
        analyzerVersion = devDependencies!['analyzer'].toString();
      }
    }
    final version = yamlMap['version']?.toString() ?? 'unknown';
    return PubspecInfo(version: version, analyzerVersion: analyzerVersion);
  } catch (e) {
    print('Error parsing YAML: $e');
    return null;
  }
}

/// Fetches package data and stores it in the database
///
/// This function combines fetching package data from the API with storing
/// it in the local database for persistence and caching.
Future<PackageData?> fetchAndStorePackageData(
  client,
  String packageName, {
  PackageDataService? service,
}) async {
  final packageDataService = service ?? PackageDataService.create();

  try {
    // Fetch the package data
    final packageData = await fetchPackageData(client, packageName);

    if (packageData != null) {
      // Store the data in the database
      await packageDataService.storePackageData(
        packageName: packageData.packageName,
        devAnalyzerVersion: packageData.devAnalyzerVersion,
        devVersion: packageData.devVersion,
        devDate: packageData.devDate,
        publishedDate: packageData.publishedDate,
        publishedVersion: packageData.publishedVersion,
        repoUrl: packageData.repoUrl,
      );

      print('Package data stored in database for: ${packageData.packageName}');
    }

    return packageData;
  } finally {
    // Close the service if we created it locally
    if (service == null) {
      await packageDataService.close();
    }
  }
}

/// Retrieves package data from database by package name
///
/// Provides a convenient way to access stored package data without
/// needing to create a service instance.
Future<PackageDataTableData?> getStoredPackageData(String packageName) async {
  final service = PackageDataService.create();
  try {
    return await service.getPackageData(packageName);
  } finally {
    await service.close();
  }
}

/// Lists all stored package data from the database
///
/// Returns all package data entries ordered by creation date.
Future<List<PackageDataTableData>> listAllStoredPackages() async {
  final service = PackageDataService.create();
  try {
    return await service.getAllPackageData();
  } finally {
    await service.close();
  }
}
