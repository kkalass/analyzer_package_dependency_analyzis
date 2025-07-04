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
    int? downloadCount30Days,
    int? likeCount,
    int? grantedPoints,
    double? popularityScore,
    int? maxPoints,
  }) async {
    final companion = PackageDataTableCompanion(
      packageName: Value(packageName),
      devAnalyzerVersion: Value(devAnalyzerVersion),
      devVersion: Value(devVersion),
      devDate: Value(devDate),
      publishedDate: Value(publishedDate),
      publishedVersion: Value(publishedVersion),
      repoUrl: Value(repoUrl),
      downloadCount30Days: Value(downloadCount30Days),
      likeCount: Value(likeCount),
      grantedPoints: Value(grantedPoints),
      popularityScore: Value(popularityScore),
      maxPoints: Value(maxPoints),
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

  /// Saves the search state for resuming interrupted operations
  Future<void> saveSearchState({
    required String searchId,
    required String allPackagesJson,
    required int currentIndex,
    required int totalCount,
    required DateTime searchStarted,
    required bool isCompleted,
  }) async {
    await _database.saveSearchState(
      searchId: searchId,
      allPackagesJson: allPackagesJson,
      currentIndex: currentIndex,
      totalCount: totalCount,
      searchStarted: searchStarted,
      isCompleted: isCompleted,
    );
  }

  /// Retrieves the search state for resuming operations
  Future<PackageSearchStateTableData?> getSearchState(String searchId) async {
    return await _database.getSearchState(searchId);
  }

  /// Updates the current processing index during fetch operations
  Future<void> updateSearchProgress(
    String searchId,
    int currentIndex, {
    bool? isCompleted,
  }) async {
    await updatePaginationState(
      searchId: searchId,
      processingCompleted: isCompleted,
    );

    // Also update the current index in the database using the old method for compatibility
    await _database.updateSearchProgress(
      searchId,
      currentIndex,
      isCompleted: isCompleted,
    );
  }

  /// Clears the search state (typically after completion)
  Future<void> clearSearchState(String searchId) async {
    await _database.clearSearchState(searchId);
  }

  /// Updates pagination state for resumable package discovery
  Future<void> updatePaginationState({
    required String searchId,
    String? nextPageUrl,
    int? currentPage,
    bool? discoveryCompleted,
    bool? processingCompleted,
    String? allPackagesJson,
  }) async {
    await _database.updatePaginationState(
      searchId: searchId,
      nextPageUrl: nextPageUrl,
      currentPage: currentPage,
      discoveryCompleted: discoveryCompleted,
      processingCompleted: processingCompleted,
      allPackagesJson: allPackagesJson,
    );
  }

  /// Saves pagination progress during package discovery
  Future<void> savePaginationProgress({
    required String searchId,
    required String allPackagesJson,
    String? nextPageUrl,
    required int currentPage,
    required bool discoveryCompleted,
  }) async {
    await _database.savePaginationProgress(
      searchId: searchId,
      allPackagesJson: allPackagesJson,
      nextPageUrl: nextPageUrl,
      currentPage: currentPage,
      discoveryCompleted: discoveryCompleted,
    );
  }

  /// Clears all search states
  Future<void> clearAllSearchStates() async {
    await _database.clearAllSearchStates();
  }

  /// Clears all package data
  Future<void> clearAllPackageData() async {
    await _database.clearAllPackageData();
  }

  /// Closes the database connection
  ///
  /// Should be called when the service is no longer needed
  /// to properly release database resources.
  Future<void> close() async {
    await _database.close();
  }
}
