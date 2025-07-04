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

  group('Target package version extraction tests', () {
    test('extracts target package version from dependencies section', () {
      const yamlContent = '''
name: example_package
dependencies:
  analyzer: ^6.2.0
  http: ^1.1.0
dev_dependencies:
  test: ^1.24.0
''';

      final result = readPubspec(yamlContent);

      expect(result, isNotNull);
      expect(result!.targetPackageVersion, equals('^6.2.0'));
    });

    test('extracts target package version from dev_dependencies section', () {
      const yamlContent = '''
name: example_package
dependencies:
  http: ^1.1.0
dev_dependencies:
  analyzer: ^7.4.5
  test: ^1.24.0
''';

      final result = readPubspec(yamlContent);

      expect(result, isNotNull);
      expect(result!.targetPackageVersion, equals('^7.4.5'));
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

        final result = readPubspec(yamlContent);

        expect(result, isNotNull);
        expect(result!.targetPackageVersion, equals('^6.0.0'));
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

      final result = readPubspec(yamlContent);

      expect(result, isNotNull);
      expect(result!.targetPackageVersion, isNull);
    });

    test('returns null for invalid YAML content', () {
      const yamlContent = 'invalid: yaml: content: [';

      final result = readPubspec(yamlContent);

      expect(result, isNull);
    });

    test('returns null for non-map YAML content', () {
      const yamlContent = '- item1\n- item2';

      final result = readPubspec(yamlContent);

      expect(result, isNull);
    });

    test('handles target package version as number', () {
      const yamlContent = '''
name: example_package
version: 1.2.3
dependencies:
  analyzer: 6.2.0
''';

      final result = readPubspec(yamlContent);

      expect(result, isNotNull);
      expect(result!.targetPackageVersion, equals('6.2.0'));
      expect(result.version, equals('1.2.3'));
    });
  });

  group('PubspecInfo extraction tests', () {
    test('extracts target package version from Map-based pubspec data', () {
      final pubspecData = {
        'name': 'example_package',
        'version': '1.0.0',
        'dependencies': {'analyzer': '^6.2.0'},
      };

      final result = extractPubspecInfo(pubspecData, 'analyzer');

      expect(result, isNotNull);
      expect(result!.version, equals('1.0.0'));
      expect(result.targetPackageVersion, equals('^6.2.0'));
    });

    test('extracts target package version from dev_dependencies section', () {
      final pubspecData = {
        'name': 'example_package',
        'version': '1.0.0',
        'dev_dependencies': {'analyzer': '^6.2.0'},
      };

      final result = extractPubspecInfo(pubspecData, 'analyzer');

      expect(result, isNotNull);
      expect(result!.version, equals('1.0.0'));
      expect(result.targetPackageVersion, equals('^6.2.0'));
    });

    test('returns null when no analyzer dependency is found', () {
      final pubspecData = {
        'name': 'example_package',
        'version': '1.0.0',
        'dependencies': {'http': '^0.13.0'},
      };

      final result = extractPubspecInfo(pubspecData, 'analyzer');

      expect(result, isNotNull);
      expect(result!.version, equals('1.0.0'));
      expect(result.targetPackageVersion, isNull);
    });

    test('handles null pubspec data gracefully', () {
      final result = extractPubspecInfo(null, 'analyzer');

      expect(result, isNull);
    });

    test('handles empty pubspec data gracefully', () {
      final result = extractPubspecInfo({}, 'analyzer');

      expect(result, isNotNull);
      expect(result!.version, equals('unknown'));
      expect(result.targetPackageVersion, isNull);
    });
  });
}
