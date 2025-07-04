import 'dart:convert';
import 'dart:io';

import 'package:console/package_analysis.dart';
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
      if (arguments.length < 2) {
        print('Error: target package is required for fetch command');
        printUsage();
        return;
      }
      await performFetch(arguments[1]);
      break;
    case 'list':
      String? targetPackage = arguments.length > 1 ? arguments[1] : null;
      await listStoredPackages(targetPackage);
      break;
    case 'csv':
      String? targetPackage = arguments.length > 1 ? arguments[1] : null;
      await exportToCSV(targetPackage);
      break;
    case 'status':
      if (arguments.length < 2) {
        print('Error: target package is required for status command');
        printUsage();
        return;
      }
      await showSearchStatus(arguments[1]);
      break;
    case 'clear':
      if (arguments.length < 2) {
        print('Error: target package is required for clear command');
        printUsage();
        return;
      }
      await clearSearchState(arguments[1]);
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
  print('Package Dependency Analysis Tool');
  print('');
  print('Usage: dart run bin/main.dart <command> [target_package]');
  print('');
  print('Commands:');
  print(
    '  fetch <pkg>    Fetch and store all packages with dependency on <pkg>',
  );
  print(
    '  list [pkg]     List all packages stored in the database (optionally filter by target package)',
  );
  print(
    '  csv [pkg]      Export package data to CSV (optionally filter by target package)',
  );
  print('  status <pkg>   Show current search progress for target package');
  print(
    '  clear <pkg>    Clear search state for target package (use if you want to restart)',
  );
  print('  help           Show this help message');
  print('');
  print('Examples:');
  print('  dart run bin/main.dart fetch analyzer');
  print('  dart run bin/main.dart fetch flutter');
  print('  dart run bin/main.dart list analyzer');
  print('  dart run bin/main.dart csv');
  print('  dart run bin/main.dart status analyzer');
}

/// Performs the fetch operation to get all packages with dependency on target package
Future<void> performFetch(String targetPackage) async {
  final client = PubClient();
  final service = PackageDataService.create();
  final searchId = '${targetPackage}_dependency';

  try {
    print('Searching for packages with $targetPackage dependency...');

    // Check if we have an existing search state to resume
    final existingState = await service.getSearchState(searchId);

    List<SerializablePackage> allPackages;
    int startIndex = 0;

    if (existingState != null) {
      // Check if we need to resume discovery or processing
      if (!existingState.discoveryCompleted) {
        print(
          'Resuming package discovery from page ${existingState.currentPage}...',
        );

        // Continue discovering packages using pagination
        allPackages =
            (await fetchAllPackagesWithPagination(
              client,
              service,
              searchId,
              targetPackage,
            )).map((pkg) => SerializablePackage(pkg.package)).toList();

        // Update state to mark discovery as complete and start processing
        await service.updatePaginationState(
          searchId: searchId,
          discoveryCompleted: true,
          processingCompleted: false,
          allPackagesJson: jsonEncode(
            allPackages.map((pkg) => pkg.toJson()).toList(),
          ),
        );

        startIndex = 0; // Start processing from beginning
      } else if (!existingState.processingCompleted) {
        // Resume processing from where we left off
        print(
          'Resuming processing from index ${existingState.currentIndex}...',
        );
        final packagesJson = jsonDecode(existingState.allPackagesJson) as List;
        allPackages =
            packagesJson
                .map(
                  (json) => SerializablePackage.fromJson(
                    json as Map<String, dynamic>,
                  ),
                )
                .toList();
        startIndex = existingState.currentIndex;
      } else {
        print('Fetch operation is already completed!');
        print('Use "dart run bin/main.dart clear" to reset and start over.');
        return;
      }
    } else {
      // Start fresh - begin package discovery with pagination
      print('Starting new package discovery...');

      try {
        allPackages =
            (await fetchAllPackagesWithPagination(
              client,
              service,
              searchId,
              targetPackage,
            )).map((pkg) => SerializablePackage(pkg.package)).toList();

        print(
          'Discovery completed! Found ${allPackages.length} packages total.',
        );

        // Mark discovery as complete and prepare for processing
        await service.updatePaginationState(
          searchId: searchId,
          discoveryCompleted: true,
          processingCompleted: false,
          allPackagesJson: jsonEncode(
            allPackages.map((pkg) => pkg.toJson()).toList(),
          ),
        );

        startIndex = 0;
      } catch (e) {
        if (e.toString().contains('rate limit')) {
          print('Rate limit reached during package discovery.');
          print(
            'Progress has been saved. Run fetch again to resume from where we left off.',
          );
          return;
        }
        rethrow;
      }
    }

    int processedCount = startIndex;
    int alreadyStoredCount = 0;
    int newlyFetchedCount = 0;

    // Set the total count for processing if not already set
    await service.updatePaginationState(
      searchId: searchId,
      processingCompleted: false,
    );

    for (int i = startIndex; i < allPackages.length; i++) {
      final package = allPackages[i];
      processedCount++;
      print(
        '\n[$processedCount/${allPackages.length}] Processing: ${package.package}',
      );

      // Check if we already have this package stored
      final existingData = await service.getPackageData(
        package.package,
        targetPackage,
      );

      if (existingData != null) {
        alreadyStoredCount++;
        print('  ✓ Already stored (last updated: ${existingData.updatedAt})');
      } else {
        try {
          print('  → Fetching package data...');
          final packageData = await fetchAndStorePackageData(
            client,
            package.package,
            targetPackage,
            service: service, // Reuse the service instance
          );

          if (packageData != null) {
            newlyFetchedCount++;
            print('  ✓ Stored: ${package.package}');
            print(
              '    Target package version: ${packageData.devTargetPackageVersion ?? 'Not found'}',
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
        print('  → Progress saved ($processedCount/${allPackages.length})');
        print('  (Pausing briefly to be respectful to the API...)');
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    // Mark processing as completed
    await service.updatePaginationState(
      searchId: searchId,
      processingCompleted: true,
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
      print('   Target package: ${pkg.devTargetPackageVersion ?? 'N/A'}');
      print('   Updated: ${pkg.updatedAt}');
    }

    if (allStored.length > sampleSize) {
      print('   ... and ${allStored.length - sampleSize} more packages');
    }
  } catch (e) {
    print('Error during fetch operation: $e');
    print('Search state has been preserved for resumption.');
  } finally {
    await service.close();
  }
}

/// Lists all packages currently stored in the database
Future<void> listStoredPackages(String? targetPackage) async {
  final service = PackageDataService.create();

  try {
    final allStored =
        targetPackage != null
            ? await service.getAllPackageDataForTarget(targetPackage)
            : await service.getAllPackageData();

    if (allStored.isEmpty) {
      if (targetPackage != null) {
        print(
          'No packages found in database for target package "$targetPackage".',
        );
        print(
          'Run "dart run bin/main.dart fetch $targetPackage" to fetch package data.',
        );
      } else {
        print('No packages found in database.');
        print(
          'Run "dart run bin/main.dart fetch <package>" to fetch package data.',
        );
      }
      return;
    }

    if (targetPackage != null) {
      print(
        'Found ${allStored.length} packages with dependency on "$targetPackage":',
      );
    } else {
      print('Found ${allStored.length} packages in database:');
    }
    print('');

    for (int i = 0; i < allStored.length; i++) {
      final pkg = allStored[i];
      print('${i + 1}. ${pkg.packageName}');
      print('   Target package: ${pkg.targetPackage}');
      print(
        '   Target package version: ${pkg.devTargetPackageVersion ?? 'Not found'}',
      );
      print('   Dev version: ${pkg.devVersion ?? 'N/A'}');
      print('   Published version: ${pkg.publishedVersion ?? 'N/A'}');
      print('   Repository: ${pkg.repoUrl ?? 'Not found'}');
      print('   Last updated: ${pkg.updatedAt}');
      print('');
    }

    // Summary statistics
    final withTargetPackage =
        allStored.where((p) => p.devTargetPackageVersion != null).length;
    final withRepo = allStored.where((p) => p.repoUrl != null).length;

    print('--- Statistics ---');
    print('Total packages: ${allStored.length}');
    print(
      'Packages with target dependency: $withTargetPackage (${(withTargetPackage / allStored.length * 100).toStringAsFixed(1)}%)',
    );
    print(
      'Packages with repository URL: $withRepo (${(withRepo / allStored.length * 100).toStringAsFixed(1)}%)',
    );
  } finally {
    await service.close();
  }
}

/// Exports all package data to a CSV file
Future<void> exportToCSV(String? targetPackage) async {
  final service = PackageDataService.create();

  try {
    final allStored =
        targetPackage != null
            ? await service.getAllPackageDataForTarget(targetPackage)
            : await service.getAllPackageData();

    if (allStored.isEmpty) {
      if (targetPackage != null) {
        print(
          'No packages found in database for target package "$targetPackage".',
        );
        print(
          'Run "dart run bin/main.dart fetch $targetPackage" to fetch package data first.',
        );
      } else {
        print('No packages found in database.');
        print(
          'Run "dart run bin/main.dart fetch <package>" to fetch package data first.',
        );
      }
      return;
    }

    // Generate filename with timestamp
    final timestamp =
        DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];
    final filename =
        targetPackage != null
            ? '${targetPackage}_dependents_export_$timestamp.csv'
            : 'packages_export_$timestamp.csv';

    // Prepare CSV content
    final csvLines = <String>[];

    // Add header
    csvLines.add(
      'Package Name,Target Package,Target Package Version,Dev Version,Dev Date,Published Date,Published Version,Repository URL,Created At,Updated At',
    );

    // Add data rows
    for (final pkg in allStored) {
      final row = [
        _escapeCsvField(pkg.packageName),
        _escapeCsvField(pkg.targetPackage),
        _escapeCsvField(pkg.devTargetPackageVersion ?? ''),
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
    final withTargetPackage =
        allStored.where((p) => p.devTargetPackageVersion != null).length;
    final withRepo = allStored.where((p) => p.repoUrl != null).length;

    print('');
    print('Export summary:');
    print('  Total packages: ${allStored.length}');
    print('  With target dependency: $withTargetPackage');
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

/// Fetches all packages with target package dependency using the built-in fetchAllPackages method
///
/// Uses the pub_api_client's built-in recursive paging to get the complete list
/// of packages that depend on the target package.
Future<List<PackageResult>> fetchAllPackagesWithTargetDependency(
  PubClient client,
  String targetPackage,
) async {
  print('Fetching all packages with $targetPackage dependency...');

  // Use the built-in fetchAllPackages method with dependency tag
  final allPackages = await client.fetchAllPackages(
    '', // Empty search query to get all packages
    tags: [PackageTag.dependency(targetPackage)],
  );

  print(
    'Completed: Found ${allPackages.length} total packages with $targetPackage dependency',
  );
  return allPackages;
}

/// Fetches all packages with target package dependency using pagination with persistence
///
/// Iterates through all pages of search results to get the complete list
/// of packages that depend on the target package. Persists progress after each page
/// so that the fetch can be resumed if interrupted.
Future<List<PackageResult>> fetchAllPackagesWithPagination(
  PubClient client,
  PackageDataService service,
  String searchId,
  String targetPackage,
) async {
  // Check if we have existing state to resume from
  final existingState = await service.getSearchState(searchId);

  final allPackages = <PackageResult>[];
  SearchResults? currentResults;
  int pageCount = 0;

  if (existingState != null && !existingState.discoveryCompleted) {
    // Resume from existing pagination state
    print(
      'Resuming package discovery from page ${existingState.currentPage + 1}...',
    );

    // Restore previously discovered packages
    final packagesJson = jsonDecode(existingState.allPackagesJson) as List;
    final previousPackages =
        packagesJson
            .map(
              (json) =>
                  SerializablePackage.fromJson(json as Map<String, dynamic>),
            )
            .toList();

    for (final pkg in previousPackages) {
      allPackages.add(PackageResult(package: pkg.package));
    }

    pageCount = existingState.currentPage;
    print('Restored ${allPackages.length} packages from previous pages');

    // Resume from the next URL if available
    if (existingState.nextPageUrl != null) {
      try {
        currentResults = await client.nextPage(existingState.nextPageUrl!);
        allPackages.addAll(currentResults.packages);
        pageCount++;
        print(
          'Page $pageCount: Found ${currentResults.packages.length} packages (total: ${allPackages.length})',
        );

        // Save progress after resuming
        await _savePaginationProgress(
          service,
          searchId,
          allPackages,
          currentResults.next,
          pageCount,
          currentResults.next == null,
        );
      } catch (e) {
        print('Error resuming from saved state: $e');
        print('Starting fresh...');
        allPackages.clear();
        pageCount = 0;
        currentResults = null;
      }
    }
  }

  // If no resume state or resume failed, start from the beginning
  if (currentResults == null && pageCount == 0) {
    print('Starting fresh package discovery...');

    // Get first page
    currentResults = await listPackages(client, targetPackage);
    allPackages.addAll(currentResults.packages);
    pageCount++;
    print('Page $pageCount: Found ${currentResults.packages.length} packages');

    // Save initial state
    await _savePaginationProgress(
      service,
      searchId,
      allPackages,
      currentResults.next,
      pageCount,
      currentResults.next == null,
    );
  }

  // Continue fetching remaining pages
  while (currentResults?.next != null) {
    try {
      currentResults = await client.nextPage(currentResults!.next!);
      allPackages.addAll(currentResults.packages);
      pageCount++;

      print(
        'Page $pageCount: Found ${currentResults.packages.length} packages (total: ${allPackages.length})',
      );

      // Save progress after each page
      await _savePaginationProgress(
        service,
        searchId,
        allPackages,
        currentResults.next,
        pageCount,
        currentResults.next == null,
      );

      // Small delay between page requests to be respectful to the API
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      print('Error fetching page $pageCount: $e');
      print('Progress has been saved. You can resume later.');
      break;
    }
  }

  final isCompleted = currentResults?.next == null;
  if (isCompleted) {
    print('✓ Package discovery completed!');
    print(
      'Completed pagination: $pageCount pages, ${allPackages.length} total packages',
    );
  } else {
    print(
      'Package discovery interrupted but progress saved. Run fetch again to continue.',
    );
  }

  return allPackages;
}

/// Helper function to save pagination progress
Future<void> _savePaginationProgress(
  PackageDataService service,
  String searchId,
  List<PackageResult> allPackages,
  String? nextUrl,
  int currentPage,
  bool isCompleted,
) async {
  final packagesJson =
      allPackages
          .map((pkg) => SerializablePackage(pkg.package).toJson())
          .toList();

  final existingState = await service.getSearchState(searchId);

  if (existingState == null) {
    // Create new state
    await service.savePaginationProgress(
      searchId: searchId,
      allPackagesJson: jsonEncode(packagesJson),
      nextPageUrl: nextUrl,
      currentPage: currentPage,
      discoveryCompleted: isCompleted,
    );
  } else {
    // Update existing state
    await service.updatePaginationState(
      searchId: searchId,
      allPackagesJson: jsonEncode(packagesJson),
      nextPageUrl: nextUrl,
      currentPage: currentPage,
      discoveryCompleted: isCompleted,
    );
  }
}

Future<SearchResults> listPackages(
  PubClient client,
  String targetPackage,
) async {
  return await client.search(
    '', // Empty search term to get all packages with the dependency tag
    tags: [PackageTag.dependency(targetPackage)],
  );
}

/// Shows the current search status and progress
Future<void> showSearchStatus(String targetPackage) async {
  final service = PackageDataService.create();
  final searchId = '${targetPackage}_dependency';

  try {
    final state = await service.getSearchState(searchId);

    if (state == null) {
      print(
        'No search state found for target package "$targetPackage". Run "dart run bin/main.dart fetch $targetPackage" to start.',
      );
      return;
    }

    print('Search Status for "$targetPackage":');
    print('  Search ID: ${state.searchId}');
    print('  Target Package: ${state.targetPackage}');
    print('  Started: ${state.searchStarted}');
    print('  Last Updated: ${state.lastUpdated}');
    print('  Current Page: ${state.currentPage}');
    print('  Discovery Completed: ${state.discoveryCompleted ? 'Yes' : 'No'}');
    print(
      '  Processing Progress: ${state.currentIndex}/${state.totalCount} packages',
    );
    print(
      '  Processing Completed: ${state.processingCompleted ? 'Yes' : 'No'}',
    );

    if (state.totalCount > 0) {
      final percentage = (state.currentIndex / state.totalCount * 100)
          .toStringAsFixed(1);
      print('  Percentage: $percentage%');
    }

    if (!state.discoveryCompleted) {
      print('');
      print(
        'Currently discovering packages. Run "dart run bin/main.dart fetch $targetPackage" to continue.',
      );
    } else if (!state.processingCompleted) {
      final remaining = state.totalCount - state.currentIndex;
      print('  Remaining: $remaining packages');
      print('');
      print(
        'Run "dart run bin/main.dart fetch $targetPackage" to continue processing.',
      );
    } else {
      print('');
      print(
        'Search completed! Run "dart run bin/main.dart clear $targetPackage" to remove search state.',
      );
    }
  } finally {
    await service.close();
  }
}

/// Clears the search state
Future<void> clearSearchState(String targetPackage) async {
  final service = PackageDataService.create();
  final searchId = '${targetPackage}_dependency';

  try {
    final state = await service.getSearchState(searchId);

    if (state == null) {
      print(
        'No search state found to clear for target package "$targetPackage".',
      );
      return;
    }

    await service.clearSearchState(searchId);
    print('✓ Search state cleared successfully for "$targetPackage".');
    print(
      '  Previous progress: ${state.currentIndex}/${state.totalCount} packages',
    );
    print('  Started: ${state.searchStarted}');
    print('');
    print(
      'You can now run "dart run bin/main.dart fetch $targetPackage" to start fresh.',
    );
  } finally {
    await service.close();
  }
}
