import 'package:console/console.dart';
import 'package:pub_api_client/pub_api_client.dart';

void main(List<String> arguments) async {
  final client = PubClient();
  //await listPackages(client);
  final details = await client.packageInfo('postgres_prepared');
  final publishedDate = details.latest.published;

  final info = await client.packageMetrics('postgres_prepared');
  var repoUrl = info?.scorecard.panaReport?.result?.repositoryUrl;

  if (repoUrl != null) {
    final analyzerVersion = await downloadAndExtractAnalyzerVersion(repoUrl);

    if (analyzerVersion != null) {
      print(
        'Analyzer version found: $analyzerVersion - Published on: $publishedDate',
      );
    } else {
      print('Analyzer package not found in dependencies or dev_dependencies');
    }
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
