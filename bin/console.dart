import 'package:console/console.dart';
import 'package:console/package_data_service.dart';
import 'package:pub_api_client/pub_api_client.dart';

void main(List<String> arguments) async {
  final client = PubClient();

  print('Searching for packages with analyzer dependency...');
  
  // Fetch all pages of search results
  final allPackages = await fetchAllPackagesWithPagination(client);
  
  print('Found ${allPackages.length} packages total across all pages');

  // Create a service instance to reuse across operations for better performance
  final service = PackageDataService.create();

  try {
    int processedCount = 0;
    int alreadyStoredCount = 0;
    int newlyFetchedCount = 0;

    for (final package in allPackages) {
      processedCount++;
      print(
        '\n[$processedCount/${allPackages.length}] Processing: ${package.package}',
      );

      // Check if we already have this package stored
      final existingData = await service.getPackageData(package.package);

      if (existingData != null) {
        alreadyStoredCount++;
        print('  ✓ Already stored (last updated: ${existingData.updatedAt})');
      } else {
        try {
          print('  → Fetching package data...');
          final packageData = await fetchAndStorePackageData(
            client,
            package.package,
            service: service, // Reuse the service instance
          );

          if (packageData != null) {
            newlyFetchedCount++;
            print('  ✓ Stored: ${package.package}');
            print(
              '    Analyzer version: ${packageData.devAnalyzerVersion ?? 'Not found'}',
            );
            print('    Repository: ${packageData.repoUrl ?? 'Not found'}');
          } else {
            print('  ✗ Failed to fetch data for: ${package.package}');
          }
        } catch (e) {
          print('  ✗ Error processing ${package.package}: $e');
        }
      }

      // Add a small delay to be respectful to the API
      if (processedCount % 5 == 0) {
        print('  (Pausing briefly to be respectful to the API...)');
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    print('\n--- Summary ---');
    print('Total packages processed: $processedCount');
    print('Already stored: $alreadyStoredCount');
    print('Newly fetched and stored: $newlyFetchedCount');

    // Show a sample of stored packages
    print('\n--- Sample of stored packages ---');
    final allStored = await service.getAllPackageData();
    final sampleSize = allStored.length > 5 ? 5 : allStored.length;

    for (int i = 0; i < sampleSize; i++) {
      final pkg = allStored[i];
      print('${i + 1}. ${pkg.packageName}');
      print('   Analyzer: ${pkg.devAnalyzerVersion ?? 'N/A'}');
      print('   Updated: ${pkg.updatedAt}');
    }

    if (allStored.length > sampleSize) {
      print('   ... and ${allStored.length - sampleSize} more packages');
    }
  } finally {
    await service.close();
  }
}

Future<SearchResults> listPackages(PubClient client) async {
  return await client.search(
    'query',
    tags: [PackageTag.dependency('analyzer')],
  );
}

/// Fetches all packages with analyzer dependency using pagination
///
/// Iterates through all pages of search results to get the complete list
/// of packages that depend on the analyzer package.
Future<List<PackageResult>> fetchAllPackagesWithPagination(PubClient client) async {
  final allPackages = <PackageResult>[];
  SearchResults? currentResults;
  int pageCount = 0;

  // Get first page
  currentResults = await listPackages(client);
  allPackages.addAll(currentResults.packages);
  pageCount++;

  print('Page $pageCount: Found ${currentResults.packages.length} packages');

  // Continue fetching while there are more pages
  while (currentResults?.next != null) {
    try {
      currentResults = await client.nextPage(currentResults!.next!);
      allPackages.addAll(currentResults.packages);
      pageCount++;

      print('Page $pageCount: Found ${currentResults.packages.length} packages (total: ${allPackages.length})');

      // Small delay between page requests to be respectful to the API
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      print('Error fetching page $pageCount: $e');
      break;
    }
  }

  print('Completed pagination: $pageCount pages, ${allPackages.length} total packages');
  return allPackages;
}
