import 'package:console/database.dart';
import 'package:console/package_data_service.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

/// Simple model for serializing package names for persistence
class SerializablePackage {
  final String package;

  SerializablePackage(this.package);

  /// Convert to JSON-serializable map
  Map<String, dynamic> toJson() => {'package': package};

  /// Create from JSON map
  factory SerializablePackage.fromJson(Map<String, dynamic> json) =>
      SerializablePackage(json['package'] as String);
}

class PackageData {
  final String packageName;
  final String targetPackage;
  final String? devTargetPackageVersion;
  final String? devVersion;
  final DateTime devDate;
  final DateTime? publishedDate;
  final String? publishedVersion;
  final String? repoUrl;
  final int? downloadCount30Days;
  final int? likeCount;
  final int? grantedPoints;
  final double? popularityScore;
  final int? maxPoints;

  PackageData({
    required this.packageName,
    required this.targetPackage,
    required this.devTargetPackageVersion,
    required this.devVersion,
    required this.devDate,
    required this.publishedDate,
    required this.repoUrl,
    required this.publishedVersion,
    required this.downloadCount30Days,
    required this.likeCount,
    required this.grantedPoints,
    required this.popularityScore,
    required this.maxPoints,
  });
}

class PubspecInfo {
  final String version;
  final String? targetPackageVersion;

  PubspecInfo({required this.version, this.targetPackageVersion});
}

Future<PackageData?> fetchPackageData(
  PubClient client,
  String packageName,
  String targetPackage,
) async {
  final details = await client.packageInfo(packageName);
  final publishedDate = details.latest.published;
  final publishedVersion = details.latest.version;
  final info = await client.packageMetrics(packageName);
  var repoUrl = info?.scorecard.panaReport?.result?.repositoryUrl;

  // Extract target package version and package version from latestPubspec
  final pubspecInfo = extractPubspecInfo(details.latestPubspec, targetPackage);

  // Extract additional metrics from the API response
  final downloadCount30Days = info?.score.downloadCount30Days;
  final likeCount = info?.score.likeCount;
  final grantedPoints = info?.score.grantedPoints;
  final popularityScore = info?.score.popularityScore;
  final maxPoints = info?.score.maxPoints;

  // Use published date as devDate since it represents when the package was last updated
  final devDate = details.latest.published;

  return PackageData(
    packageName: packageName,
    targetPackage: targetPackage,
    devTargetPackageVersion: pubspecInfo?.targetPackageVersion,
    devVersion: pubspecInfo?.version,
    devDate: devDate,
    publishedDate: publishedDate,
    publishedVersion: publishedVersion,
    repoUrl: repoUrl,
    downloadCount30Days: downloadCount30Days,
    likeCount: likeCount,
    grantedPoints: grantedPoints,
    popularityScore: popularityScore,
    maxPoints: maxPoints,
  );
}

/// Extracts target package version and package version from pubspec data
///
/// Parses the pubspec data from the pub.dev API response to extract
/// the target package version from dependencies or dev_dependencies.
PubspecInfo? extractPubspecInfo(dynamic pubspecData, String targetPackage) {
  if (pubspecData == null) return null;

  try {
    // Handle different types of pubspec data
    Map<String, dynamic>? pubspecMap;

    if (pubspecData is Map<String, dynamic>) {
      pubspecMap = pubspecData;
    } else if (pubspecData is Map<dynamic, dynamic>) {
      pubspecMap = Map<String, dynamic>.from(pubspecData);
    } else if (pubspecData is Pubspec) {
      // If it's a Pubspec object, try to access its properties
      final version = pubspecData.version?.toString() ?? 'unknown';

      // Try to access dependency_overrides first (highest priority)
      String? targetPackageVersion;
      try {
        final dependencyOverrides = pubspecData.dependencyOverrides;
        if (dependencyOverrides.containsKey(targetPackage)) {
          targetPackageVersion = dependencyOverrides[targetPackage].toString();
        }
      } catch (e) {
        // Ignore error and try dependencies
      }

      // Try dependencies if not found in dependency_overrides
      if (targetPackageVersion == null) {
        try {
          final dependencies = pubspecData.dependencies;
          if (dependencies.containsKey(targetPackage)) {
            targetPackageVersion = dependencies[targetPackage].toString();
          }
        } catch (e) {
          // Ignore error and try dev_dependencies
        }
      }

      // Try dev_dependencies if not found in dependencies
      if (targetPackageVersion == null) {
        try {
          final devDependencies = pubspecData.devDependencies;
          if (devDependencies.containsKey(targetPackage)) {
            targetPackageVersion = devDependencies[targetPackage].toString();
          }
        } catch (e) {
          // Ignore error
        }
      }

      return PubspecInfo(
        version: version,
        targetPackageVersion: targetPackageVersion,
      );
    }

    if (pubspecMap == null) return null;

    // Check dependency_overrides section first (highest priority)
    String? targetPackageVersion;
    final dependencyOverrides = pubspecMap['dependency_overrides'] as Map<String, dynamic>?;
    if (dependencyOverrides?.containsKey(targetPackage) == true) {
      targetPackageVersion = dependencyOverrides![targetPackage].toString();
    }

    // Check dependencies section if not found in dependency_overrides
    if (targetPackageVersion == null) {
      final dependencies = pubspecMap['dependencies'] as Map<String, dynamic>?;
      if (dependencies?.containsKey(targetPackage) == true) {
        targetPackageVersion = dependencies![targetPackage].toString();
      }
    }

    // Check dev_dependencies section if not found in dependencies
    if (targetPackageVersion == null) {
      final devDependencies =
          pubspecMap['dev_dependencies'] as Map<String, dynamic>?;
      if (devDependencies?.containsKey(targetPackage) == true) {
        targetPackageVersion = devDependencies![targetPackage].toString();
      }
    }

    // Extract version from pubspec
    final version = pubspecMap['version']?.toString() ?? 'unknown';

    return PubspecInfo(
      version: version,
      targetPackageVersion: targetPackageVersion,
    );
  } catch (e) {
    print('Error parsing pubspec data: $e');
    return null;
  }
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

/// Fetches package data and stores it in the database
///
/// This function combines fetching package data from the API with storing
/// it in the local database for persistence and caching.
Future<PackageData?> fetchAndStorePackageData(
  client,
  String packageName,
  String targetPackage, {
  PackageDataService? service,
}) async {
  final packageDataService = service ?? PackageDataService.create();

  try {
    // Fetch the package data
    final packageData = await fetchPackageData(
      client,
      packageName,
      targetPackage,
    );

    if (packageData != null) {
      // Store the data in the database
      await packageDataService.storePackageData(
        packageName: packageData.packageName,
        targetPackage: packageData.targetPackage,
        devTargetPackageVersion: packageData.devTargetPackageVersion,
        devVersion: packageData.devVersion,
        devDate: packageData.devDate,
        publishedDate: packageData.publishedDate,
        publishedVersion: packageData.publishedVersion,
        repoUrl: packageData.repoUrl,
        downloadCount30Days: packageData.downloadCount30Days,
        likeCount: packageData.likeCount,
        grantedPoints: packageData.grantedPoints,
        popularityScore: packageData.popularityScore,
        maxPoints: packageData.maxPoints,
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

/// Retrieves package data from database by package name and target package
///
/// Provides a convenient way to access stored package data without
/// needing to create a service instance.
Future<PackageDataTableData?> getStoredPackageData(
  String packageName,
  String targetPackage,
) async {
  final service = PackageDataService.create();
  try {
    return await service.getPackageData(packageName, targetPackage);
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

/// Lists all stored package data for a specific target package
///
/// Returns all package data entries for the given target package.
Future<List<PackageDataTableData>> listAllStoredPackagesForTarget(
  String targetPackage,
) async {
  final service = PackageDataService.create();
  try {
    return await service.getAllPackageDataForTarget(targetPackage);
  } finally {
    await service.close();
  }
}
