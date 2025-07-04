import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Table definition for storing target package versions from pub.dev
class TargetPackageVersionTable extends Table {
  @override
  String get tableName => 'target_package_versions';

  /// Primary key - target package name
  TextColumn get targetPackage => text()();

  /// Version string (e.g., "1.2.3")
  TextColumn get version => text()();

  /// Major version number
  IntColumn get majorVersion => integer()();

  /// Minor version number
  IntColumn get minorVersion => integer()();

  /// Patch version number
  IntColumn get patchVersion => integer()();

  /// When this version was published on pub.dev
  DateTimeColumn get publishedDate => dateTime()();

  /// When this record was created
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {targetPackage, version};
}

/// Table definition for storing supported versions per dependent
class DependentSupportedVersionTable extends Table {
  @override
  String get tableName => 'dependent_supported_versions';

  /// Primary key - dependent package name
  TextColumn get dependentPackage => text()();

  /// Primary key - target package name
  TextColumn get targetPackage => text()();

  /// Primary key - supported version string
  TextColumn get supportedVersion => text()();

  /// Constraint string from pubspec.yaml (e.g., "^1.0.0")
  TextColumn get constraintString => text()();

  /// When this record was created
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {
    dependentPackage,
    targetPackage,
    supportedVersion,
  };
}

/// Table definition for storing version compatibility reports
class VersionCompatibilityReportTable extends Table {
  @override
  String get tableName => 'version_compatibility_reports';

  /// Primary key - target package name
  TextColumn get targetPackage => text()();

  /// Primary key - target package version
  TextColumn get targetVersion => text()();

  /// Number of dependents that support this version
  IntColumn get supportedDependentsCount => integer()();

  /// Total number of dependents analyzed
  IntColumn get totalDependentsCount => integer()();

  /// Percentage of dependents that support this version (0-100)
  RealColumn get supportPercentage => real()();

  /// When this report was generated
  DateTimeColumn get generatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {targetPackage, targetVersion};
}

/// Table definition for storing package search state
class PackageSearchStateTable extends Table {
  @override
  String get tableName => 'package_search_state';

  /// Primary key - search identifier (e.g., 'analyzer_dependency')
  TextColumn get searchId => text()();

  /// The package we're analyzing dependencies for (e.g., 'analyzer')
  TextColumn get targetPackage => text()();

  /// JSON encoded list of all discovered packages so far
  TextColumn get allPackagesJson => text()();

  /// Current pagination URL (next page to fetch)
  TextColumn get nextPageUrl => text().nullable()();

  /// Current page number being fetched
  IntColumn get currentPage => integer().withDefault(const Constant(0))();

  /// Current processing index for package processing
  IntColumn get currentIndex => integer().withDefault(const Constant(0))();

  /// Total count of packages discovered so far
  IntColumn get totalCount => integer()();

  /// Whether package discovery is completed
  BoolColumn get discoveryCompleted =>
      boolean().withDefault(const Constant(false))();

  /// Whether processing is completed
  BoolColumn get processingCompleted =>
      boolean().withDefault(const Constant(false))();

  /// Timestamp when search was started
  DateTimeColumn get searchStarted => dateTime()();

  /// Timestamp when last updated
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {searchId};
}

/// Table definition for storing package data
class PackageDataTable extends Table {
  @override
  String get tableName => 'package_data';

  /// Primary key - package name
  TextColumn get packageName => text()();

  /// The package we're analyzing dependencies for (e.g., 'analyzer')
  TextColumn get targetPackage => text()();

  /// Target package version from dev dependencies
  TextColumn get devTargetPackageVersion => text().nullable()();

  /// Version from pubspec.yaml
  TextColumn get devVersion => text().nullable()();

  /// Date when dev data was fetched
  DateTimeColumn get devDate => dateTime()();

  /// Published date of the package
  DateTimeColumn get publishedDate => dateTime().nullable()();

  /// Published version of the package
  TextColumn get publishedVersion => text().nullable()();

  /// Repository URL
  TextColumn get repoUrl => text().nullable()();

  /// Download count for the last 30 days
  IntColumn get downloadCount30Days => integer().nullable()();

  /// Number of likes for the package
  IntColumn get likeCount => integer().nullable()();

  /// Granted points from pub.dev scoring
  IntColumn get grantedPoints => integer().nullable()();

  /// Popularity score from pub.dev
  RealColumn get popularityScore => real().nullable()();

  /// Maximum points possible in scoring
  IntColumn get maxPoints => integer().nullable()();

  /// Timestamp when this record was created
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Timestamp when this record was last updated
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {packageName, targetPackage};
}

/// Database class that extends GeneratedDatabase
@DriftDatabase(
  tables: [
    PackageDataTable,
    PackageSearchStateTable,
    TargetPackageVersionTable,
    DependentSupportedVersionTable,
    VersionCompatibilityReportTable,
  ],
)
class PackageDatabase extends _$PackageDatabase {
  PackageDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(packageSearchStateTable);
      }
      if (from < 3) {
        // For simplicity, we'll recreate the table with new schema
        await m.drop(packageSearchStateTable);
        await m.createTable(packageSearchStateTable);
      }
      if (from < 4) {
        // Recreate the package data table with new columns
        await m.drop(packageDataTable);
        await m.createTable(packageDataTable);
      }
      if (from < 5) {
        // Recreate both tables to add targetPackage field and update primary keys
        await m.drop(packageDataTable);
        await m.drop(packageSearchStateTable);
        await m.createTable(packageDataTable);
        await m.createTable(packageSearchStateTable);
      }
      if (from < 6) {
        // Rename devAnalyzerVersion column to devTargetPackageVersion
        await m.drop(packageDataTable);
        await m.createTable(packageDataTable);
      }
      if (from < 7) {
        // Change primary key to composite (packageName, targetPackage)
        await m.drop(packageDataTable);
        await m.createTable(packageDataTable);
      }
      if (from < 8) {
        // Add new tables for version compatibility analysis
        await m.createTable(targetPackageVersionTable);
        await m.createTable(dependentSupportedVersionTable);
        await m.createTable(versionCompatibilityReportTable);
      }
    },
  );

  /// Inserts or updates package data
  Future<void> upsertPackageData(PackageDataTableCompanion data) async {
    await into(packageDataTable).insertOnConflictUpdate(data);
  }

  /// Retrieves package data by package name and target package
  Future<PackageDataTableData?> getPackageData(
    String packageName,
    String targetPackage,
  ) async {
    return (select(packageDataTable)..where(
      (tbl) =>
          tbl.packageName.equals(packageName) &
          tbl.targetPackage.equals(targetPackage),
    )).getSingleOrNull();
  }

  /// Retrieves all package data ordered by creation date
  Future<List<PackageDataTableData>> getAllPackageData() async {
    return (select(packageDataTable)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).get();
  }

  /// Retrieves all package data for a specific target package
  Future<List<PackageDataTableData>> getAllPackageDataForTarget(
    String targetPackage,
  ) async {
    return (select(packageDataTable)
          ..where((tbl) => tbl.targetPackage.equals(targetPackage))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .get();
  }

  /// Deletes package data by package name and target package
  Future<int> deletePackageData(
    String packageName,
    String targetPackage,
  ) async {
    return (delete(packageDataTable)..where(
      (tbl) =>
          tbl.packageName.equals(packageName) &
          tbl.targetPackage.equals(targetPackage),
    )).go();
  }

  /// Updates the updatedAt timestamp for a package
  Future<void> touchPackageData(
    String packageName,
    String targetPackage,
  ) async {
    await (update(packageDataTable)..where(
      (tbl) =>
          tbl.packageName.equals(packageName) &
          tbl.targetPackage.equals(targetPackage),
    )).write(PackageDataTableCompanion(updatedAt: Value(DateTime.now())));
  }

  /// Saves or updates the package search state (legacy method for compatibility)
  Future<void> saveSearchState({
    required String searchId,
    required String targetPackage,
    required String allPackagesJson,
    required int currentIndex,
    required int totalCount,
    required DateTime searchStarted,
    required bool isCompleted,
  }) async {
    await into(packageSearchStateTable).insertOnConflictUpdate(
      PackageSearchStateTableCompanion(
        searchId: Value(searchId),
        targetPackage: Value(targetPackage),
        allPackagesJson: Value(allPackagesJson),
        currentIndex: Value(currentIndex),
        totalCount: Value(totalCount),
        searchStarted: Value(searchStarted),
        lastUpdated: Value(DateTime.now()),
        processingCompleted: Value(
          isCompleted,
        ), // Map old isCompleted to processingCompleted
        discoveryCompleted: Value(
          true,
        ), // Assume discovery is complete if using old method
        currentPage: Value(0), // Default value
        nextPageUrl: const Value(null), // Default value
      ),
    );
  }

  /// Retrieves the package search state
  Future<PackageSearchStateTableData?> getSearchState(String searchId) async {
    return (select(packageSearchStateTable)
      ..where((tbl) => tbl.searchId.equals(searchId))).getSingleOrNull();
  }

  /// Updates the current processing index (legacy method for compatibility)
  Future<void> updateSearchProgress(
    String searchId,
    int currentIndex, {
    bool? isCompleted,
  }) async {
    final updateCompanion = PackageSearchStateTableCompanion(
      currentIndex: Value(currentIndex),
      lastUpdated: Value(DateTime.now()),
    );

    final finalUpdate =
        isCompleted != null
            ? updateCompanion.copyWith(processingCompleted: Value(isCompleted))
            : updateCompanion;

    await (update(packageSearchStateTable)
      ..where((tbl) => tbl.searchId.equals(searchId))).write(finalUpdate);
  }

  /// Updates pagination state for package discovery
  Future<void> updatePaginationState({
    required String searchId,
    String? nextPageUrl,
    int? currentPage,
    bool? discoveryCompleted,
    bool? processingCompleted,
    String? allPackagesJson,
  }) async {
    final companion = PackageSearchStateTableCompanion(
      lastUpdated: Value(DateTime.now()),
    );

    var updateCompanion = companion;
    if (nextPageUrl != null) {
      updateCompanion = updateCompanion.copyWith(
        nextPageUrl: Value(nextPageUrl),
      );
    }
    if (currentPage != null) {
      updateCompanion = updateCompanion.copyWith(
        currentPage: Value(currentPage),
      );
    }
    if (discoveryCompleted != null) {
      updateCompanion = updateCompanion.copyWith(
        discoveryCompleted: Value(discoveryCompleted),
      );
    }
    if (processingCompleted != null) {
      updateCompanion = updateCompanion.copyWith(
        processingCompleted: Value(processingCompleted),
      );
    }
    if (allPackagesJson != null) {
      updateCompanion = updateCompanion.copyWith(
        allPackagesJson: Value(allPackagesJson),
      );

      // Update totalCount based on the packages JSON
      int totalCount = 0;
      try {
        final packagesJson = jsonDecode(allPackagesJson) as List;
        totalCount = packagesJson.length;
      } catch (e) {
        // If we can't parse JSON, keep totalCount as 0
      }

      updateCompanion = updateCompanion.copyWith(totalCount: Value(totalCount));
    }

    await (update(packageSearchStateTable)
      ..where((tbl) => tbl.searchId.equals(searchId))).write(updateCompanion);
  }

  /// Saves pagination progress during package discovery
  Future<void> savePaginationProgress({
    required String searchId,
    required String targetPackage,
    required String allPackagesJson,
    String? nextPageUrl,
    required int currentPage,
    required bool discoveryCompleted,
  }) async {
    // Calculate total count from the packages JSON
    int totalCount = 0;
    try {
      final packagesJson = jsonDecode(allPackagesJson) as List;
      totalCount = packagesJson.length;
    } catch (e) {
      // If we can't parse JSON, keep totalCount as 0
    }

    await into(packageSearchStateTable).insertOnConflictUpdate(
      PackageSearchStateTableCompanion(
        searchId: Value(searchId),
        targetPackage: Value(targetPackage),
        allPackagesJson: Value(allPackagesJson),
        nextPageUrl: Value(nextPageUrl),
        currentPage: Value(currentPage),
        discoveryCompleted: Value(discoveryCompleted),
        processingCompleted: Value(false),
        currentIndex: Value(
          0,
        ), // Reset processing index when updating pagination
        totalCount: Value(
          totalCount,
        ), // Set to actual discovered packages count
        searchStarted: Value(DateTime.now()),
        lastUpdated: Value(DateTime.now()),
      ),
    );
  }

  /// Clears the search state
  Future<void> clearSearchState(String searchId) async {
    await (delete(packageSearchStateTable)
      ..where((tbl) => tbl.searchId.equals(searchId))).go();
  }

  /// Clears all search states
  Future<void> clearAllSearchStates() async {
    await delete(packageSearchStateTable).go();
  }

  /// Clears all package data
  Future<void> clearAllPackageData() async {
    await delete(packageDataTable).go();
  }

  /// Stores target package version information
  Future<void> storeTargetPackageVersion({
    required String targetPackage,
    required String version,
    required int majorVersion,
    required int minorVersion,
    required int patchVersion,
    required DateTime publishedDate,
  }) async {
    await into(targetPackageVersionTable).insertOnConflictUpdate(
      TargetPackageVersionTableCompanion(
        targetPackage: Value(targetPackage),
        version: Value(version),
        majorVersion: Value(majorVersion),
        minorVersion: Value(minorVersion),
        patchVersion: Value(patchVersion),
        publishedDate: Value(publishedDate),
      ),
    );
  }

  /// Retrieves target package versions ordered by version descending
  Future<List<TargetPackageVersionTableData>> getTargetPackageVersions(
    String targetPackage,
  ) async {
    return (select(targetPackageVersionTable)
          ..where((tbl) => tbl.targetPackage.equals(targetPackage))
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.majorVersion),
            (tbl) => OrderingTerm.desc(tbl.minorVersion),
            (tbl) => OrderingTerm.desc(tbl.patchVersion),
          ]))
        .get();
  }

  /// Stores supported version information for a dependent
  Future<void> storeDependentSupportedVersion({
    required String dependentPackage,
    required String targetPackage,
    required String supportedVersion,
    required String constraintString,
  }) async {
    await into(dependentSupportedVersionTable).insertOnConflictUpdate(
      DependentSupportedVersionTableCompanion(
        dependentPackage: Value(dependentPackage),
        targetPackage: Value(targetPackage),
        supportedVersion: Value(supportedVersion),
        constraintString: Value(constraintString),
      ),
    );
  }

  /// Retrieves supported versions for a dependent package
  Future<List<DependentSupportedVersionTableData>>
  getDependentSupportedVersions(
    String dependentPackage,
    String targetPackage,
  ) async {
    return (select(dependentSupportedVersionTable)..where(
      (tbl) =>
          tbl.dependentPackage.equals(dependentPackage) &
          tbl.targetPackage.equals(targetPackage),
    )).get();
  }

  /// Retrieves all dependents that support a specific version
  Future<List<DependentSupportedVersionTableData>>
  getDependentsSupportingVersion(String targetPackage, String version) async {
    return (select(dependentSupportedVersionTable)..where(
      (tbl) =>
          tbl.targetPackage.equals(targetPackage) &
          tbl.supportedVersion.equals(version),
    )).get();
  }

  /// Retrieves all dependents that support a specific version with their constraint strings
  Future<List<DependentSupportedVersionTableData>>
  getDependentsSupportingVersionWithConstraints(
    String targetPackage,
    String version,
  ) async {
    return (select(dependentSupportedVersionTable)
          ..where(
            (tbl) =>
                tbl.targetPackage.equals(targetPackage) &
                tbl.supportedVersion.equals(version),
          )
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.dependentPackage)]))
        .get();
  }

  /// Stores version compatibility report data
  Future<void> storeVersionCompatibilityReport({
    required String targetPackage,
    required String targetVersion,
    required int supportedDependentsCount,
    required int totalDependentsCount,
    required double supportPercentage,
  }) async {
    await into(versionCompatibilityReportTable).insertOnConflictUpdate(
      VersionCompatibilityReportTableCompanion(
        targetPackage: Value(targetPackage),
        targetVersion: Value(targetVersion),
        supportedDependentsCount: Value(supportedDependentsCount),
        totalDependentsCount: Value(totalDependentsCount),
        supportPercentage: Value(supportPercentage),
      ),
    );
  }

  /// Retrieves version compatibility reports for a target package
  Future<List<VersionCompatibilityReportTableData>>
  getVersionCompatibilityReports(String targetPackage) async {
    return (select(versionCompatibilityReportTable)
          ..where((tbl) => tbl.targetPackage.equals(targetPackage))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.generatedAt)]))
        .get();
  }

  /// Clears version compatibility reports for a target package
  Future<void> clearVersionCompatibilityReports(String targetPackage) async {
    await (delete(versionCompatibilityReportTable)
      ..where((tbl) => tbl.targetPackage.equals(targetPackage))).go();
  }
}

/// Opens a connection to the SQLite database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = Directory('db');
    if (!await dbFolder.exists()) {
      await dbFolder.create(recursive: true);
    }

    final file = File(p.join(dbFolder.path, 'packages.sqlite'));
    return NativeDatabase(file);
  });
}
