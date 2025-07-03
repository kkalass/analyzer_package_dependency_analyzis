import 'dart:convert';
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
    case 'status':
      await showSearchStatus();
      break;
    case 'clear':
      await clearSearchState();
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
  print('  status   Show current search progress and state');
  print('  clear    Clear search state (use if you want to restart)');
  print('  help     Show this help message');
  print('');
  print('Examples:');
  print('  dart run bin/console.dart fetch');
  print('  dart run bin/console.dart list');
  print('  dart run bin/console.dart csv');
  print('  dart run bin/console.dart status');
}

/// Performs the fetch operation to get all packages with analyzer dependency
Future<void> performFetch() async {
  final client = PubClient();
  final service = PackageDataService.create();
  const searchId = 'analyzer_dependency';

  try {
    print('Searching for packages with analyzer dependency...');

    // Check if we have an existing search state to resume
    final existingState = await service.getSearchState(searchId);

    List<SerializablePackage> allPackages;
    int startIndex = 0;
    DateTime searchStarted;

    if (existingState != null && !existingState.isCompleted) {
      // Resume from existing state
      print(
        'Found existing search state. Resuming from index ${existingState.currentIndex}...',
      );
      final packagesJson = jsonDecode(existingState.allPackagesJson) as List;
      allPackages =
          packagesJson
              .map(
                (json) =>
                    SerializablePackage.fromJson(json as Map<String, dynamic>),
              )
              .toList();
      startIndex = existingState.currentIndex;
      searchStarted = existingState.searchStarted;
      print(
        'Resuming processing of ${allPackages.length} packages from index $startIndex',
      );
    } else {
      // Start fresh - fetch all packages and persist the list
      print('Starting new search...');
      searchStarted = DateTime.now();

      try {
        final packageResults = await fetchAllPackagesWithAnalyzerDependency(
          client,
        );
        allPackages =
            packageResults
                .map((pkg) => SerializablePackage(pkg.package))
                .toList();

        print(
          'Found ${allPackages.length} packages total. Saving search state...',
        );

        // Save the initial search state
        await service.saveSearchState(
          searchId: searchId,
          allPackagesJson: jsonEncode(
            allPackages.map((pkg) => pkg.toJson()).toList(),
          ),
          currentIndex: 0,
          totalCount: allPackages.length,
          searchStarted: searchStarted,
          isCompleted: false,
        );
      } catch (e) {
        if (e.toString().contains('rate limit')) {
          print(
            'Rate limit reached while fetching package list. Please wait a few minutes and try again.',
          );
          print(
            'The search will be resumed automatically when you run fetch again.',
          );
          return;
        }
        rethrow;
      }
    }

    int processedCount = startIndex;
    int alreadyStoredCount = 0;
    int newlyFetchedCount = 0;

    for (int i = startIndex; i < allPackages.length; i++) {
      final package = allPackages[i];
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

      // Update progress every 5 packages
      if (processedCount % 5 == 0) {
        await service.updateSearchProgress(searchId, processedCount);
        print('  → Progress saved (${processedCount}/${allPackages.length})');
        print('  (Pausing briefly to be respectful to the API...)');
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    // Mark as completed
    await service.updateSearchProgress(
      searchId,
      allPackages.length,
      isCompleted: true,
    );

    print('\n--- Summary ---');
    print('Total packages processed: $processedCount');
    print('Already stored: $alreadyStoredCount');
    print('Newly fetched and stored: $newlyFetchedCount');
    print('Search completed at: ${DateTime.now()}');

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

    // Optionally clear the search state after successful completion
    print('\nClearing search state...');
    await service.clearSearchState(searchId);
    print('✓ Search state cleared');
  } catch (e) {
    print('Error during fetch operation: $e');
    print('Search state has been preserved for resumption.');
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

/// Fetches all packages with analyzer dependency using the built-in fetchAllPackages method
///
/// Uses the pub_api_client's built-in recursive paging to get the complete list
/// of packages that depend on the analyzer package.
Future<List<PackageResult>> fetchAllPackagesWithAnalyzerDependency(
  PubClient client,
) async {
  print('Fetching all packages with analyzer dependency...');

  // Use the built-in fetchAllPackages method with dependency tag
  final allPackages = await client.fetchAllPackages(
    '', // Empty search query to get all packages
    tags: [PackageTag.dependency('analyzer')],
  );

  print(
    'Completed: Found ${allPackages.length} total packages with analyzer dependency',
  );
  return allPackages;
}

/// Shows the current search status and progress
Future<void> showSearchStatus() async {
  final service = PackageDataService.create();
  const searchId = 'analyzer_dependency';

  try {
    final state = await service.getSearchState(searchId);

    if (state == null) {
      print(
        'No search state found. Run "dart run bin/console.dart fetch" to start.',
      );
      return;
    }

    print('Search Status:');
    print('  Search ID: ${state.searchId}');
    print('  Started: ${state.searchStarted}');
    print('  Last Updated: ${state.lastUpdated}');
    print('  Progress: ${state.currentIndex}/${state.totalCount} packages');
    print('  Completed: ${state.isCompleted ? 'Yes' : 'No'}');

    final percentage = (state.currentIndex / state.totalCount * 100)
        .toStringAsFixed(1);
    print('  Percentage: $percentage%');

    if (!state.isCompleted) {
      final remaining = state.totalCount - state.currentIndex;
      print('  Remaining: $remaining packages');
      print('');
      print('Run "dart run bin/console.dart fetch" to continue processing.');
    } else {
      print('');
      print(
        'Search completed! Run "dart run bin/console.dart clear" to remove search state.',
      );
    }
  } finally {
    await service.close();
  }
}

/// Clears the search state
Future<void> clearSearchState() async {
  final service = PackageDataService.create();
  const searchId = 'analyzer_dependency';

  try {
    final state = await service.getSearchState(searchId);

    if (state == null) {
      print('No search state found to clear.');
      return;
    }

    await service.clearSearchState(searchId);
    print('✓ Search state cleared successfully.');
    print(
      '  Previous progress: ${state.currentIndex}/${state.totalCount} packages',
    );
    print('  Started: ${state.searchStarted}');
    print('');
    print('You can now run "dart run bin/console.dart fetch" to start fresh.');
  } finally {
    await service.close();
  }
}
