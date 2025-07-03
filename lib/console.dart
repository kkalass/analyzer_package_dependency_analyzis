import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

/// Downloads pubspec.yaml from the repository URL and extracts the analyzer package version
/// 
/// Handles both GitHub and GitLab repositories by converting the repo URL to raw file URL.
/// Searches for analyzer package in both dependencies and dev_dependencies sections.
Future<void> downloadAndExtractAnalyzerVersion(String repoUrl) async {
  try {
    final pubspecUrl = convertToPubspecRawUrl(repoUrl);
    print('Downloading pubspec.yaml from: $pubspecUrl');
    
    final response = await http.get(Uri.parse(pubspecUrl));
    
    if (response.statusCode == 200) {
      final yamlContent = response.body;
      final analyzerVersion = extractAnalyzerVersion(yamlContent);
      
      if (analyzerVersion != null) {
        print('Analyzer version found: $analyzerVersion');
      } else {
        print('Analyzer package not found in dependencies or dev_dependencies');
      }
    } else {
      print('Failed to download pubspec.yaml. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error downloading or parsing pubspec.yaml: $e');
  }
}

/// Converts repository URL to raw pubspec.yaml URL
/// 
/// Supports GitHub and GitLab repositories by transforming the URL format
/// to point directly to the raw pubspec.yaml file.
String convertToPubspecRawUrl(String repoUrl) {
  // Remove trailing slash if present
  final cleanUrl = repoUrl.endsWith('/') ? repoUrl.substring(0, repoUrl.length - 1) : repoUrl;
  
  if (cleanUrl.contains('github.com')) {
    // Convert GitHub URL: https://github.com/user/repo -> https://raw.githubusercontent.com/user/repo/main/pubspec.yaml
    final githubRawUrl = cleanUrl
        .replaceFirst('https://github.com/', 'https://raw.githubusercontent.com/')
        .replaceFirst('http://github.com/', 'https://raw.githubusercontent.com/');
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
String? extractAnalyzerVersion(String yamlContent) {
  try {
    final dynamic yamlDoc = loadYaml(yamlContent);
    
    if (yamlDoc is! Map) {
      return null;
    }
    
    final yamlMap = yamlDoc;
    
    // Check dependencies section
    final dependencies = yamlMap['dependencies'] as Map<dynamic, dynamic>?;
    if (dependencies?.containsKey('analyzer') == true) {
      return dependencies!['analyzer'].toString();
    }
    
    // Check dev_dependencies section
    final devDependencies = yamlMap['dev_dependencies'] as Map<dynamic, dynamic>?;
    if (devDependencies?.containsKey('analyzer') == true) {
      return devDependencies!['analyzer'].toString();
    }
    
    return null;
  } catch (e) {
    print('Error parsing YAML: $e');
    return null;
  }
}
