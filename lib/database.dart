import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Table definition for storing package search state
class PackageSearchStateTable extends Table {
  @override
  String get tableName => 'package_search_state';

  /// Primary key - search identifier (always 'analyzer_dependency')
  TextColumn get searchId => text()();

  /// JSON encoded list of all discovered packages
  TextColumn get allPackagesJson => text()();

  /// Current processing index
  IntColumn get currentIndex => integer().withDefault(const Constant(0))();

  /// Total count of packages
  IntColumn get totalCount => integer()();

  /// Timestamp when search was started
  DateTimeColumn get searchStarted => dateTime()();

  /// Timestamp when last updated
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();

  /// Whether the search is completed
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {searchId};
}

/// Table definition for storing package data
class PackageDataTable extends Table {
  @override
  String get tableName => 'package_data';

  /// Primary key - package name
  TextColumn get packageName => text()();

  /// Analyzer version from dev dependencies
  TextColumn get devAnalyzerVersion => text().nullable()();

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

  /// Timestamp when this record was created
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Timestamp when this record was last updated
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {packageName};
}

/// Database class that extends GeneratedDatabase
@DriftDatabase(tables: [PackageDataTable, PackageSearchStateTable])
class PackageDatabase extends _$PackageDatabase {
  PackageDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(packageSearchStateTable);
      }
    },
  );

  /// Inserts or updates package data
  Future<void> upsertPackageData(PackageDataTableCompanion data) async {
    await into(packageDataTable).insertOnConflictUpdate(data);
  }

  /// Retrieves package data by package name
  Future<PackageDataTableData?> getPackageData(String packageName) async {
    return (select(packageDataTable)
      ..where((tbl) => tbl.packageName.equals(packageName))).getSingleOrNull();
  }

  /// Retrieves all package data ordered by creation date
  Future<List<PackageDataTableData>> getAllPackageData() async {
    return (select(packageDataTable)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).get();
  }

  /// Deletes package data by package name
  Future<int> deletePackageData(String packageName) async {
    return (delete(packageDataTable)
      ..where((tbl) => tbl.packageName.equals(packageName))).go();
  }

  /// Updates the updatedAt timestamp for a package
  Future<void> touchPackageData(String packageName) async {
    await (update(packageDataTable)..where(
      (tbl) => tbl.packageName.equals(packageName),
    )).write(PackageDataTableCompanion(updatedAt: Value(DateTime.now())));
  }

  /// Saves or updates the package search state
  Future<void> saveSearchState({
    required String searchId,
    required String allPackagesJson,
    required int currentIndex,
    required int totalCount,
    required DateTime searchStarted,
    required bool isCompleted,
  }) async {
    await into(packageSearchStateTable).insertOnConflictUpdate(
      PackageSearchStateTableCompanion(
        searchId: Value(searchId),
        allPackagesJson: Value(allPackagesJson),
        currentIndex: Value(currentIndex),
        totalCount: Value(totalCount),
        searchStarted: Value(searchStarted),
        lastUpdated: Value(DateTime.now()),
        isCompleted: Value(isCompleted),
      ),
    );
  }

  /// Retrieves the package search state
  Future<PackageSearchStateTableData?> getSearchState(String searchId) async {
    return (select(packageSearchStateTable)
      ..where((tbl) => tbl.searchId.equals(searchId))).getSingleOrNull();
  }

  /// Updates the current processing index
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
            ? updateCompanion.copyWith(isCompleted: Value(isCompleted))
            : updateCompanion;

    await (update(packageSearchStateTable)
      ..where((tbl) => tbl.searchId.equals(searchId))).write(finalUpdate);
  }

  /// Clears the search state
  Future<void> clearSearchState(String searchId) async {
    await (delete(packageSearchStateTable)
      ..where((tbl) => tbl.searchId.equals(searchId))).go();
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
