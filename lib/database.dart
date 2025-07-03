import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

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
@DriftDatabase(tables: [PackageDataTable])
class PackageDatabase extends _$PackageDatabase {
  PackageDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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
