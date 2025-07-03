import 'package:console/console.dart';
import 'package:pub_api_client/pub_api_client.dart';

void main(List<String> arguments) async {
  final client = PubClient();
  //await listPackages(client);
  final info = await client.packageMetrics('postgres_prepared');
  var repoUrl = info?.scorecard.panaReport?.result?.repositoryUrl;

  if (repoUrl != null) {
    await downloadAndExtractAnalyzerVersion(repoUrl);
  } else {
    print('No repository URL found for package postgres_prepared');
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
