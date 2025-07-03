import 'package:console/console.dart';
import 'package:console/package_data_service.dart';
import 'package:test/test.dart';

void main() {
  group('Database integration tests', () {
    test('should store and retrieve package data through service functions', () async {
      const packageName = 'test_package_integration';
      
      // Create a mock PackageData object
      final packageData = PackageData(
        packageName: packageName,
        devAnalyzerVersion: '^7.0.0',
        devVersion: '2.0.0',
        devDate: DateTime.now(),
        publishedDate: DateTime.now().subtract(const Duration(days: 1)),
        publishedVersion: '1.9.0',
        repoUrl: 'https://github.com/test/repo',
      );
      
      // Create service and store data
      final service = PackageDataService.create();
      
      try {
        await service.storePackageData(
          packageName: packageData.packageName,
          devAnalyzerVersion: packageData.devAnalyzerVersion,
          devVersion: packageData.devVersion,
          devDate: packageData.devDate,
          publishedDate: packageData.publishedDate,
          publishedVersion: packageData.publishedVersion,
          repoUrl: packageData.repoUrl,
        );
        
        // Retrieve data using convenience function
        final retrieved = await getStoredPackageData(packageName);
        
        expect(retrieved, isNotNull);
        expect(retrieved!.packageName, equals(packageName));
        expect(retrieved.devAnalyzerVersion, equals('^7.0.0'));
        expect(retrieved.devVersion, equals('2.0.0'));
        expect(retrieved.publishedVersion, equals('1.9.0'));
        expect(retrieved.repoUrl, equals('https://github.com/test/repo'));
        
        // Test existence check
        final exists = await service.hasPackageData(packageName);
        expect(exists, isTrue);
        
        // Test deletion
        final deleteCount = await service.deletePackageData(packageName);
        expect(deleteCount, equals(1));
        
        // Verify deletion
        final afterDeletion = await service.hasPackageData(packageName);
        expect(afterDeletion, isFalse);
        
      } finally {
        await service.close();
      }
    });
    
    test('should handle multiple packages storage and retrieval', () async {
      final service = PackageDataService.create();
      final now = DateTime.now();
      
      try {
        // Store multiple packages
        final packages = ['pkg1', 'pkg2', 'pkg3'];
        
        for (int i = 0; i < packages.length; i++) {
          await service.storePackageData(
            packageName: packages[i],
            devAnalyzerVersion: '^${i + 6}.0.0',
            devVersion: '1.${i}.0',
            devDate: now.add(Duration(minutes: i)),
            publishedVersion: '1.${i}.0',
          );
        }
        
        // Retrieve all packages
        final allPackages = await listAllStoredPackages();
        
        expect(allPackages.length, greaterThanOrEqualTo(3));
        
        final storedNames = allPackages.map((p) => p.packageName).toList();
        expect(storedNames, containsAll(packages));
        
        // Clean up test data
        for (final pkg in packages) {
          await service.deletePackageData(pkg);
        }
        
      } finally {
        await service.close();
      }
    });
    
    test('should handle package data update (upsert)', () async {
      const packageName = 'update_test_package';
      final service = PackageDataService.create();
      
      try {
        // Initial storage
        await service.storePackageData(
          packageName: packageName,
          devAnalyzerVersion: '^6.0.0',
          devVersion: '1.0.0',
          devDate: DateTime.now(),
        );
        
        final initial = await service.getPackageData(packageName);
        expect(initial, isNotNull);
        expect(initial!.devAnalyzerVersion, equals('^6.0.0'));
        
        // Update the same package
        await service.storePackageData(
          packageName: packageName,
          devAnalyzerVersion: '^7.0.0',
          devVersion: '2.0.0',
          devDate: DateTime.now(),
        );
        
        final updated = await service.getPackageData(packageName);
        expect(updated, isNotNull);
        expect(updated!.devAnalyzerVersion, equals('^7.0.0'));
        expect(updated.devVersion, equals('2.0.0'));
        
        // The created and updated timestamps should be different
        expect(updated.updatedAt.isAfter(updated.createdAt) || 
               updated.updatedAt.isAtSameMomentAs(updated.createdAt), isTrue);
        
        // Clean up
        await service.deletePackageData(packageName);
        
      } finally {
        await service.close();
      }
    });
  });
}
