import 'dart:io';

import 'package:console/console.dart';
import 'package:console/package_data_service.dart';
import 'package:pub_api_client/pub_api_client.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    printUsage();
    return;
  }

  final command = arguments[0].toLowerCase();

  switch (command) {
    case 'fetch':
      await performFetch();
      break;
    case 'list':
      await listStoredPackages();
      break;
    case 'csv':
      await exportToCSV();
      break;
    case 'help':
    case '--help':
    case '-h':
      printUsage();
      break;
    default:
      print('Unknown command: $command');
      printUsage();
  }
}

/// Prints usage information for the application
void printUsage() {
  print('Package Analyzer Tool');
  print('');
  print('Usage: dart run bin/console.dart <command>');
  print('');
  print('Commands:');
  print('  fetch    Fetch and store all packages with analyzer dependency');
  print('  list     List all packages currently stored in the database');
  print('  csv      Export all package data to a CSV file');
  print('  help     Show this help message');
  print('');
  print('Examples:');
  print('  dart run bin/console.dart fetch');
  print('  dart run bin/console.dart list');
  print('  dart run bin/console.dart csv');
}

/// Performs the fetch operation to get all packages with analyzer dependency
Future<void> performFetch() async {
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

/// Lists all packages currently stored in the database
Future<void> listStoredPackages() async {
  final service = PackageDataService.create();

  try {
    final allStored = await service.getAllPackageData();

    if (allStored.isEmpty) {
      print('No packages found in database.');
      print('Run "dart run bin/console.dart fetch" to fetch package data.');
      return;
    }

    print('Found ${allStored.length} packages in database:');
    print('');

    for (int i = 0; i < allStored.length; i++) {
      final pkg = allStored[i];
      print('${i + 1}. ${pkg.packageName}');
      print('   Analyzer version: ${pkg.devAnalyzerVersion ?? 'Not found'}');
      print('   Dev version: ${pkg.devVersion ?? 'N/A'}');
      print('   Published version: ${pkg.publishedVersion ?? 'N/A'}');
      print('   Repository: ${pkg.repoUrl ?? 'Not found'}');
      print('   Last updated: ${pkg.updatedAt}');
      print('');
    }

    // Summary statistics
    final withAnalyzer =
        allStored.where((p) => p.devAnalyzerVersion != null).length;
    final withRepo = allStored.where((p) => p.repoUrl != null).length;

    print('--- Statistics ---');
    print('Total packages: ${allStored.length}');
    print(
      'Packages with analyzer dependency: $withAnalyzer (${(withAnalyzer / allStored.length * 100).toStringAsFixed(1)}%)',
    );
    print(
      'Packages with repository URL: $withRepo (${(withRepo / allStored.length * 100).toStringAsFixed(1)}%)',
    );
  } finally {
    await service.close();
  }
}

/// Exports all package data to a CSV file
Future<void> exportToCSV() async {
  final service = PackageDataService.create();

  try {
    final allStored = await service.getAllPackageData();

    if (allStored.isEmpty) {
      print('No packages found in database.');
      print(
        'Run "dart run bin/console.dart fetch" to fetch package data first.',
      );
      return;
    }

    // Generate filename with timestamp
    final timestamp =
        DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];
    final filename = 'packages_export_$timestamp.csv';

    // Prepare CSV content
    final csvLines = <String>[];

    // Add header
    csvLines.add(
      'Package Name,Analyzer Version,Dev Version,Dev Date,Published Date,Published Version,Repository URL,Created At,Updated At',
    );

    // Add data rows
    for (final pkg in allStored) {
      final row = [
        _escapeCsvField(pkg.packageName),
        _escapeCsvField(pkg.devAnalyzerVersion ?? ''),
        _escapeCsvField(pkg.devVersion ?? ''),
        _escapeCsvField(pkg.devDate.toIso8601String()),
        _escapeCsvField(pkg.publishedDate?.toIso8601String() ?? ''),
        _escapeCsvField(pkg.publishedVersion ?? ''),
        _escapeCsvField(pkg.repoUrl ?? ''),
        _escapeCsvField(pkg.createdAt.toIso8601String()),
        _escapeCsvField(pkg.updatedAt.toIso8601String()),
      ].join(',');

      csvLines.add(row);
    }

    // Write to file
    final csvContent = csvLines.join('\n');
    final file = File(filename);
    await file.writeAsString(csvContent);

    print('✓ Exported ${allStored.length} packages to: $filename');

    // Show summary statistics
    final withAnalyzer =
        allStored.where((p) => p.devAnalyzerVersion != null).length;
    final withRepo = allStored.where((p) => p.repoUrl != null).length;

    print('');
    print('Export summary:');
    print('  Total packages: ${allStored.length}');
    print('  With analyzer dependency: $withAnalyzer');
    print('  With repository URL: $withRepo');
    print('  File size: ${(await file.length() / 1024).toStringAsFixed(1)} KB');
  } catch (e) {
    print('Error exporting to CSV: $e');
  } finally {
    await service.close();
  }
}

/// Escapes a field for CSV format by wrapping in quotes if it contains special characters
String _escapeCsvField(String field) {
  // If field contains comma, quote, or newline, wrap in quotes and escape internal quotes
  if (field.contains(',') ||
      field.contains('"') ||
      field.contains('\n') ||
      field.contains('\r')) {
    return '"${field.replaceAll('"', '""')}"';
  }
  return field;
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
Future<List<PackageResult>> fetchAllPackagesWithPagination(
  PubClient client,
) async {
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

      print(
        'Page $pageCount: Found ${currentResults.packages.length} packages (total: ${allPackages.length})',
      );

      // Small delay between page requests to be respectful to the API
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      print('Error fetching page $pageCount: $e');
      break;
    }
  }

  print(
    'Completed pagination: $pageCount pages, ${allPackages.length} total packages',
  );
  return allPackages;
}
