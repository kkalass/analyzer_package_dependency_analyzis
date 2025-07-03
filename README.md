# Package Analyzer Dependency Analysis Tool

A command-line application that fetches and analyzes pub.dev packages that depend on the `analyzer` package. The tool provides comprehensive data collection, storage, and export capabilities for analyzing the ecosystem of packages that use Dart's analyzer library.

## Features

- **Package Discovery**: Searches pub.dev for all packages with analyzer dependency using pagination
- **Metadata Collection**: Fetches detailed package information including:
  - Package name and published versions
  - Repository URLs (GitHub, GitLab, etc.)
  - Analyzer version used in development (from pubspec.yaml)
  - Publication dates and development versions
- **Persistent Storage**: SQLite database for reliable data persistence using Drift ORM
- **Resume Capability**: Interrupted operations can be resumed from where they left off
- **Data Export**: CSV export functionality for further analysis
- **Progress Tracking**: Real-time status monitoring of search and fetch operations

## Architecture

The application follows clean architecture principles with clear separation of concerns:

- **Database Layer** (`lib/database.dart`): Drift-based SQLite database with automatic migrations
- **Service Layer** (`lib/package_data_service.dart`): Clean abstraction for data operations
- **Business Logic** (`lib/console.dart`): Core functionality for package analysis
- **CLI Interface** (`bin/console.dart`): Command-line interface with multiple commands

## Installation

1. Ensure you have Dart SDK 3.7.2 or higher installed
2. Clone this repository
3. Run dependency installation:
   ```bash
   dart pub get
   ```

## Usage

### Available Commands

```bash
# Fetch all packages with analyzer dependency
dart run bin/console.dart fetch

# List all stored packages in the database
dart run bin/console.dart list

# Export package data to CSV file
dart run bin/console.dart csv

# Show current search progress and state
dart run bin/console.dart status

# Clear search state (restart from beginning)
dart run bin/console.dart clear

# Show help information
dart run bin/console.dart help
```

### Example Workflow

1. **Start data collection**:
   ```bash
   dart run bin/console.dart fetch
   ```

2. **Monitor progress** (in another terminal):
   ```bash
   dart run bin/console.dart status
   ```

3. **Export results when complete**:
   ```bash
   dart run bin/console.dart csv
   ```

4. **View stored packages**:
   ```bash
   dart run bin/console.dart list
   ```

## Data Structure

The tool collects and stores the following information for each package:

| Field | Description |
|-------|-------------|
| Package Name | Unique identifier from pub.dev |
| Analyzer Version | Version constraint from dev pubspec.yaml |
| Dev Version | Development version from repository |
| Dev Date | Timestamp when repository data was fetched |
| Published Date | Official publication date on pub.dev |
| Published Version | Latest published version |
| Repository URL | Source code repository location |
| Created/Updated At | Database timestamps |

## Output

- **CSV Export**: Results are saved to `results/packages_export_<timestamp>.csv`
- **Database**: Persistent storage in `db/packages.sqlite`
- **Console**: Real-time progress and status information

## Resumable Operations

The tool supports resuming interrupted operations:

- **Discovery Phase**: Package list retrieval from pub.dev with pagination
- **Processing Phase**: Individual package metadata collection
- **State Persistence**: Current progress saved to database automatically

If the process is interrupted, simply run `dart run bin/console.dart fetch` again to resume from where it left off.

## Error Handling

- Network failures are handled with retry logic
- Invalid repository URLs are skipped with logging
- Database connection issues are reported clearly
- Progress state ensures no duplicate processing

## Testing

Run the test suite:

```bash
dart test
```

Tests cover:
- URL conversion utilities for different Git hosting providers
- Analyzer version extraction from pubspec.yaml files
- Database operations and data integrity
- Service layer functionality

## Contributing

1. Follow the existing code style and architecture patterns
2. Add tests for new functionality
3. Update documentation as needed
4. Ensure all tests pass before submitting changes

## Dependencies

Key dependencies include:
- `pub_api_client`: Official pub.dev API client
- `drift`: Type-safe SQLite database ORM
- `yaml`: YAML parsing for pubspec.yaml files
- `http`: HTTP client for repository access
