import 'package:console/database.dart';
import 'package:drift/drift.dart';

/// Service class for managing package data storage operations
///
/// Provides a clean interface for storing and retrieving package data
/// while abstracting away the database implementation details.
class PackageDataService {
  final PackageDatabase _database;

  PackageDataService(this._database);

  /// Factory constructor that creates a service with a default database instance
  factory PackageDataService.create() {
    return PackageDataService(PackageDatabase());
  }

  /// Stores package data in the database
  ///
  /// Uses upsert operation to either insert new data or update existing data
  /// based on the package name as the primary key.
  Future<void> storePackageData({
    required String packageName,
    String? devAnalyzerVersion,
    String? devVersion,
    required DateTime devDate,
    DateTime? publishedDate,
    String? publishedVersion,
    String? repoUrl,
  }) async {
    final companion = PackageDataTableCompanion(
      packageName: Value(packageName),
      devAnalyzerVersion: Value(devAnalyzerVersion),
      devVersion: Value(devVersion),
      devDate: Value(devDate),
      publishedDate: Value(publishedDate),
      publishedVersion: Value(publishedVersion),
      repoUrl: Value(repoUrl),
      updatedAt: Value(DateTime.now()),
    );

    await _database.upsertPackageData(companion);
  }

  /// Retrieves package data by package name
  ///
  /// Returns null if no data is found for the given package name.
  Future<PackageDataTableData?> getPackageData(String packageName) async {
    return await _database.getPackageData(packageName);
  }

  /// Retrieves all stored package data
  ///
  /// Returns a list of all package data ordered by creation date (newest first).
  Future<List<PackageDataTableData>> getAllPackageData() async {
    return await _database.getAllPackageData();
  }

  /// Deletes package data by package name
  ///
  /// Returns the number of rows affected (0 if package not found, 1 if deleted).
  Future<int> deletePackageData(String packageName) async {
    return await _database.deletePackageData(packageName);
  }

  /// Checks if package data exists for the given package name
  Future<bool> hasPackageData(String packageName) async {
    final data = await getPackageData(packageName);
    return data != null;
  }

  /// Updates the last accessed timestamp for a package
  Future<void> touchPackageData(String packageName) async {
    await _database.touchPackageData(packageName);
  }

  /// Closes the database connection
  ///
  /// Should be called when the service is no longer needed
  /// to properly release database resources.
  Future<void> close() async {
    await _database.close();
  }
}
