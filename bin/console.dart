import 'package:console/console.dart';
import 'package:pub_api_client/pub_api_client.dart';

void main(List<String> arguments) async {
  final client = PubClient();
  //await listPackages(client);
  
  // Fetch package data and store it in the database
  final packageData = await fetchAndStorePackageData(client, 'postgres_prepared');
  
  if (packageData != null) {
    print('Package Name: ${packageData.packageName}');
    print('Dev Analyzer Version: ${packageData.devAnalyzerVersion}');
    print('Dev Version: ${packageData.devVersion}');
    print('Dev Date: ${packageData.devDate}');
    print('Published Date: ${packageData.publishedDate}');
    print('Published Version: ${packageData.publishedVersion}');
    print('Repository URL: ${packageData.repoUrl}');
    
    print('\n--- Retrieving from database ---');
    // Demonstrate retrieving from database
    final storedData = await getStoredPackageData('postgres_prepared');
    if (storedData != null) {
      print('Stored Package: ${storedData.packageName}');
      print('Stored Dev Analyzer Version: ${storedData.devAnalyzerVersion}');
      print('Stored at: ${storedData.createdAt}');
      print('Last updated: ${storedData.updatedAt}');
    }
  } else {
    print('No package data found for postgres_prepared');
  }
}

Future<void> listPackages(PubClient client) async {
  final results = await client.search(
    'query',
    tags: [PackageTag.dependency('analyzer')],
  );
  // Returns the packages that match the query
  print(results.packages);
}
