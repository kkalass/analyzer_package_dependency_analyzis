import 'package:console/console.dart';
import 'package:test/test.dart';

void main() {
  group('URL conversion tests', () {
    test('converts GitHub URL to raw pubspec.yaml URL', () {
      const repoUrl = 'https://github.com/user/repo';
      const expected =
          'https://raw.githubusercontent.com/user/repo/main/pubspec.yaml';

      final result = convertToPubspecRawUrl(repoUrl);

      expect(result, equals(expected));
    });

    test('converts GitHub URL with trailing slash to raw pubspec.yaml URL', () {
      const repoUrl = 'https://github.com/user/repo/';
      const expected =
          'https://raw.githubusercontent.com/user/repo/main/pubspec.yaml';

      final result = convertToPubspecRawUrl(repoUrl);

      expect(result, equals(expected));
    });

    test('converts GitLab URL to raw pubspec.yaml URL', () {
      const repoUrl = 'https://gitlab.com/user/repo';
      const expected = 'https://gitlab.com/user/repo/-/raw/main/pubspec.yaml';

      final result = convertToPubspecRawUrl(repoUrl);

      expect(result, equals(expected));
    });

    test('handles unknown repository hosts as fallback', () {
      const repoUrl = 'https://custom-git.com/user/repo';
      const expected = 'https://custom-git.com/user/repo/pubspec.yaml';

      final result = convertToPubspecRawUrl(repoUrl);

      expect(result, equals(expected));
    });
  });

  group('Analyzer version extraction tests', () {
    test('extracts analyzer version from dependencies section', () {
      const yamlContent = '''
name: example_package
dependencies:
  analyzer: ^6.2.0
  http: ^1.1.0
dev_dependencies:
  test: ^1.24.0
''';

      final result = extractAnalyzerVersion(yamlContent);

      expect(result, equals('^6.2.0'));
    });

    test('extracts analyzer version from dev_dependencies section', () {
      const yamlContent = '''
name: example_package
dependencies:
  http: ^1.1.0
dev_dependencies:
  analyzer: ^7.4.5
  test: ^1.24.0
''';

      final result = extractAnalyzerVersion(yamlContent);

      expect(result, equals('^7.4.5'));
    });

    test(
      'prioritizes dependencies over dev_dependencies when analyzer is in both',
      () {
        const yamlContent = '''
name: example_package
dependencies:
  analyzer: ^6.0.0
  http: ^1.1.0
dev_dependencies:
  analyzer: ^7.0.0
  test: ^1.24.0
''';

        final result = extractAnalyzerVersion(yamlContent);

        expect(result, equals('^6.0.0'));
      },
    );

    test('returns null when analyzer is not found', () {
      const yamlContent = '''
name: example_package
dependencies:
  http: ^1.1.0
dev_dependencies:
  test: ^1.24.0
''';

      final result = extractAnalyzerVersion(yamlContent);

      expect(result, isNull);
    });

    test('returns null for invalid YAML content', () {
      const yamlContent = 'invalid: yaml: content: [';

      final result = extractAnalyzerVersion(yamlContent);

      expect(result, isNull);
    });

    test('returns null for non-map YAML content', () {
      const yamlContent = '- item1\n- item2';

      final result = extractAnalyzerVersion(yamlContent);

      expect(result, isNull);
    });

    test('handles analyzer version as number', () {
      const yamlContent = '''
name: example_package
dependencies:
  analyzer: 6.2.0
''';

      final result = extractAnalyzerVersion(yamlContent);

      expect(result, equals('6.2.0'));
    });
  });
}
