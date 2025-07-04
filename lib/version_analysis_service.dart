import 'package:console/database.dart';
import 'package:console/package_data_service.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:pub_semver/pub_semver.dart';

/// Service for analyzing version compatibility between target packages and their dependents
class VersionAnalysisService {
  final PackageDataService _packageDataService;
  final PubClient _pubClient;

  VersionAnalysisService(this._packageDataService, this._pubClient);

  /// Fetches and stores target package versions from pub.dev
  Future<void> fetchTargetPackageVersions(String targetPackage) async {
    print('Fetching versions for $targetPackage...');
    
    try {
      final packageInfo = await _pubClient.packageInfo(targetPackage);
      final versions = packageInfo.versions;
      
      print('Found ${versions.length} versions for $targetPackage');
      
      for (final version in versions) {
        final versionObj = Version.parse(version.version);
        
        await _packageDataService.storeTargetPackageVersion(
          targetPackage: targetPackage,
          version: version.version,
          majorVersion: versionObj.major,
          minorVersion: versionObj.minor,
          patchVersion: versionObj.patch,
          publishedDate: version.published,
        );
      }
      
      print('Stored ${versions.length} versions for $targetPackage');
    } catch (e) {
      print('Error fetching versions for $targetPackage: $e');
      rethrow;
    }
  }

  /// Analyzes version constraints and stores supported versions for each dependent
  Future<void> analyzeVersionConstraints(String targetPackage) async {
    print('Analyzing version constraints for $targetPackage...');
    
    final dependents = await _packageDataService.getAllPackageDataForTarget(targetPackage);
    final targetVersions = await _packageDataService.getTargetPackageVersions(targetPackage);
    
    print('Found ${dependents.length} dependents and ${targetVersions.length} target versions');
    
    int processedCount = 0;
    
    for (final dependent in dependents) {
      final constraintString = dependent.devTargetPackageVersion;
      
      if (constraintString == null || constraintString.isEmpty) {
        print('Skipping ${dependent.packageName} - no constraint string');
        continue;
      }
      
      final constraint = _parseConstraint(constraintString);
      if (constraint == null) {
        print('Skipping ${dependent.packageName} - invalid constraint: $constraintString');
        continue;
      }
      
      // Check which target versions are supported by this constraint
      for (final targetVersion in targetVersions) {
        try {
          final version = Version.parse(targetVersion.version);
          
          if (constraint.allows(version)) {
            await _packageDataService.storeDependentSupportedVersion(
              dependentPackage: dependent.packageName,
              targetPackage: targetPackage,
              supportedVersion: targetVersion.version,
              constraintString: constraintString,
            );
          }
        } catch (e) {
          print('Error parsing version ${targetVersion.version}: $e');
        }
      }
      
      processedCount++;
      if (processedCount % 10 == 0) {
        print('Processed $processedCount/${dependents.length} dependents');
      }
    }
    
    print('Completed constraint analysis for $targetPackage');
  }

  /// Generates version compatibility report for the last n minor versions
  Future<void> generateVersionCompatibilityReport(String targetPackage, int lastNMinorVersions) async {
    print('Generating version compatibility report for $targetPackage (last $lastNMinorVersions minor versions)...');
    
    final allVersions = await _packageDataService.getTargetPackageVersions(targetPackage);
    final dependents = await _packageDataService.getAllPackageDataForTarget(targetPackage);
    
    // Group versions by major.minor
    final Map<String, List<TargetPackageVersionTableData>> versionsByMinor = {};
    
    for (final version in allVersions) {
      final minorKey = '${version.majorVersion}.${version.minorVersion}';
      versionsByMinor.putIfAbsent(minorKey, () => []).add(version);
    }
    
    // Sort minor versions by version descending
    final sortedMinorVersions = versionsByMinor.keys.toList()
      ..sort((a, b) {
        final aParts = a.split('.').map(int.parse).toList();
        final bParts = b.split('.').map(int.parse).toList();
        
        final majorComp = bParts[0].compareTo(aParts[0]);
        if (majorComp != 0) return majorComp;
        
        return bParts[1].compareTo(aParts[1]);
      });
    
    // Take the last n minor versions
    final targetMinorVersions = sortedMinorVersions.take(lastNMinorVersions).toList();
    
    print('Analyzing ${targetMinorVersions.length} minor versions: ${targetMinorVersions.join(', ')}');
    
    // Clear existing reports
    await _packageDataService.clearVersionCompatibilityReports(targetPackage);
    
    // Generate report for each minor version (using the latest patch version)
    for (final minorVersion in targetMinorVersions) {
      final versionsInMinor = versionsByMinor[minorVersion]!;
      
      // Find the latest patch version in this minor version
      versionsInMinor.sort((a, b) => b.patchVersion.compareTo(a.patchVersion));
      final latestPatchVersion = versionsInMinor.first;
      
      // Count how many dependents support this version
      final supportedDependents = await _packageDataService.getDependentsSupportingVersion(
        targetPackage,
        latestPatchVersion.version,
      );
      
      final supportedCount = supportedDependents.length;
      final totalCount = dependents.length;
      final supportPercentage = totalCount > 0 ? (supportedCount / totalCount) * 100 : 0.0;
      
      await _packageDataService.storeVersionCompatibilityReport(
        targetPackage: targetPackage,
        targetVersion: latestPatchVersion.version,
        supportedDependentsCount: supportedCount,
        totalDependentsCount: totalCount,
        supportPercentage: supportPercentage,
      );
      
      print('${latestPatchVersion.version}: $supportedCount/$totalCount dependents (${supportPercentage.toStringAsFixed(1)}%)');
    }
    
    print('Report generation completed for $targetPackage');
  }

  /// Parses constraint string and returns VersionConstraint
  VersionConstraint? _parseConstraint(String constraintString) {
    try {
      // Remove common prefixes that might be in the constraint string
      final cleanConstraint = constraintString
          .replaceAll(RegExp(r'^HostedDependency:\s*'), '')
          .trim();
      
      return VersionConstraint.parse(cleanConstraint);
    } catch (e) {
      return null;
    }
  }
}

/// Extension methods for PackageDataService to support version analysis
extension VersionAnalysisExtension on PackageDataService {
  /// Stores target package version information
  Future<void> storeTargetPackageVersion({
    required String targetPackage,
    required String version,
    required int majorVersion,
    required int minorVersion,
    required int patchVersion,
    required DateTime publishedDate,
  }) async {
    final database = PackageDatabase();
    await database.storeTargetPackageVersion(
      targetPackage: targetPackage,
      version: version,
      majorVersion: majorVersion,
      minorVersion: minorVersion,
      patchVersion: patchVersion,
      publishedDate: publishedDate,
    );
    await database.close();
  }

  /// Retrieves target package versions
  Future<List<TargetPackageVersionTableData>> getTargetPackageVersions(String targetPackage) async {
    final database = PackageDatabase();
    final result = await database.getTargetPackageVersions(targetPackage);
    await database.close();
    return result;
  }

  /// Stores supported version information for a dependent
  Future<void> storeDependentSupportedVersion({
    required String dependentPackage,
    required String targetPackage,
    required String supportedVersion,
    required String constraintString,
  }) async {
    final database = PackageDatabase();
    await database.storeDependentSupportedVersion(
      dependentPackage: dependentPackage,
      targetPackage: targetPackage,
      supportedVersion: supportedVersion,
      constraintString: constraintString,
    );
    await database.close();
  }

  /// Retrieves dependents that support a specific version
  Future<List<String>> getDependentsSupportingVersion(String targetPackage, String version) async {
    final database = PackageDatabase();
    final results = await database.getDependentsSupportingVersion(targetPackage, version);
    await database.close();
    return results.map((r) => r.dependentPackage).toList();
  }

  /// Stores version compatibility report
  Future<void> storeVersionCompatibilityReport({
    required String targetPackage,
    required String targetVersion,
    required int supportedDependentsCount,
    required int totalDependentsCount,
    required double supportPercentage,
  }) async {
    final database = PackageDatabase();
    await database.storeVersionCompatibilityReport(
      targetPackage: targetPackage,
      targetVersion: targetVersion,
      supportedDependentsCount: supportedDependentsCount,
      totalDependentsCount: totalDependentsCount,
      supportPercentage: supportPercentage,
    );
    await database.close();
  }

  /// Retrieves version compatibility reports
  Future<List<VersionCompatibilityReportTableData>> getVersionCompatibilityReports(String targetPackage) async {
    final database = PackageDatabase();
    final result = await database.getVersionCompatibilityReports(targetPackage);
    await database.close();
    return result;
  }

  /// Clears version compatibility reports
  Future<void> clearVersionCompatibilityReports(String targetPackage) async {
    final database = PackageDatabase();
    await database.clearVersionCompatibilityReports(targetPackage);
    await database.close();
  }
}
