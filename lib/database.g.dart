// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PackageDataTableTable extends PackageDataTable
    with TableInfo<$PackageDataTableTable, PackageDataTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackageDataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _devAnalyzerVersionMeta =
      const VerificationMeta('devAnalyzerVersion');
  @override
  late final GeneratedColumn<String> devAnalyzerVersion =
      GeneratedColumn<String>(
        'dev_analyzer_version',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _devVersionMeta = const VerificationMeta(
    'devVersion',
  );
  @override
  late final GeneratedColumn<String> devVersion = GeneratedColumn<String>(
    'dev_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _devDateMeta = const VerificationMeta(
    'devDate',
  );
  @override
  late final GeneratedColumn<DateTime> devDate = GeneratedColumn<DateTime>(
    'dev_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedDateMeta = const VerificationMeta(
    'publishedDate',
  );
  @override
  late final GeneratedColumn<DateTime> publishedDate =
      GeneratedColumn<DateTime>(
        'published_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _publishedVersionMeta = const VerificationMeta(
    'publishedVersion',
  );
  @override
  late final GeneratedColumn<String> publishedVersion = GeneratedColumn<String>(
    'published_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repoUrlMeta = const VerificationMeta(
    'repoUrl',
  );
  @override
  late final GeneratedColumn<String> repoUrl = GeneratedColumn<String>(
    'repo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    packageName,
    devAnalyzerVersion,
    devVersion,
    devDate,
    publishedDate,
    publishedVersion,
    repoUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'package_data';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackageDataTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('dev_analyzer_version')) {
      context.handle(
        _devAnalyzerVersionMeta,
        devAnalyzerVersion.isAcceptableOrUnknown(
          data['dev_analyzer_version']!,
          _devAnalyzerVersionMeta,
        ),
      );
    }
    if (data.containsKey('dev_version')) {
      context.handle(
        _devVersionMeta,
        devVersion.isAcceptableOrUnknown(data['dev_version']!, _devVersionMeta),
      );
    }
    if (data.containsKey('dev_date')) {
      context.handle(
        _devDateMeta,
        devDate.isAcceptableOrUnknown(data['dev_date']!, _devDateMeta),
      );
    } else if (isInserting) {
      context.missing(_devDateMeta);
    }
    if (data.containsKey('published_date')) {
      context.handle(
        _publishedDateMeta,
        publishedDate.isAcceptableOrUnknown(
          data['published_date']!,
          _publishedDateMeta,
        ),
      );
    }
    if (data.containsKey('published_version')) {
      context.handle(
        _publishedVersionMeta,
        publishedVersion.isAcceptableOrUnknown(
          data['published_version']!,
          _publishedVersionMeta,
        ),
      );
    }
    if (data.containsKey('repo_url')) {
      context.handle(
        _repoUrlMeta,
        repoUrl.isAcceptableOrUnknown(data['repo_url']!, _repoUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packageName};
  @override
  PackageDataTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackageDataTableData(
      packageName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}package_name'],
          )!,
      devAnalyzerVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dev_analyzer_version'],
      ),
      devVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dev_version'],
      ),
      devDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}dev_date'],
          )!,
      publishedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_date'],
      ),
      publishedVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}published_version'],
      ),
      repoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repo_url'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $PackageDataTableTable createAlias(String alias) {
    return $PackageDataTableTable(attachedDatabase, alias);
  }
}

class PackageDataTableData extends DataClass
    implements Insertable<PackageDataTableData> {
  /// Primary key - package name
  final String packageName;

  /// Analyzer version from dev dependencies
  final String? devAnalyzerVersion;

  /// Version from pubspec.yaml
  final String? devVersion;

  /// Date when dev data was fetched
  final DateTime devDate;

  /// Published date of the package
  final DateTime? publishedDate;

  /// Published version of the package
  final String? publishedVersion;

  /// Repository URL
  final String? repoUrl;

  /// Timestamp when this record was created
  final DateTime createdAt;

  /// Timestamp when this record was last updated
  final DateTime updatedAt;
  const PackageDataTableData({
    required this.packageName,
    this.devAnalyzerVersion,
    this.devVersion,
    required this.devDate,
    this.publishedDate,
    this.publishedVersion,
    this.repoUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['package_name'] = Variable<String>(packageName);
    if (!nullToAbsent || devAnalyzerVersion != null) {
      map['dev_analyzer_version'] = Variable<String>(devAnalyzerVersion);
    }
    if (!nullToAbsent || devVersion != null) {
      map['dev_version'] = Variable<String>(devVersion);
    }
    map['dev_date'] = Variable<DateTime>(devDate);
    if (!nullToAbsent || publishedDate != null) {
      map['published_date'] = Variable<DateTime>(publishedDate);
    }
    if (!nullToAbsent || publishedVersion != null) {
      map['published_version'] = Variable<String>(publishedVersion);
    }
    if (!nullToAbsent || repoUrl != null) {
      map['repo_url'] = Variable<String>(repoUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PackageDataTableCompanion toCompanion(bool nullToAbsent) {
    return PackageDataTableCompanion(
      packageName: Value(packageName),
      devAnalyzerVersion:
          devAnalyzerVersion == null && nullToAbsent
              ? const Value.absent()
              : Value(devAnalyzerVersion),
      devVersion:
          devVersion == null && nullToAbsent
              ? const Value.absent()
              : Value(devVersion),
      devDate: Value(devDate),
      publishedDate:
          publishedDate == null && nullToAbsent
              ? const Value.absent()
              : Value(publishedDate),
      publishedVersion:
          publishedVersion == null && nullToAbsent
              ? const Value.absent()
              : Value(publishedVersion),
      repoUrl:
          repoUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(repoUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PackageDataTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackageDataTableData(
      packageName: serializer.fromJson<String>(json['packageName']),
      devAnalyzerVersion: serializer.fromJson<String?>(
        json['devAnalyzerVersion'],
      ),
      devVersion: serializer.fromJson<String?>(json['devVersion']),
      devDate: serializer.fromJson<DateTime>(json['devDate']),
      publishedDate: serializer.fromJson<DateTime?>(json['publishedDate']),
      publishedVersion: serializer.fromJson<String?>(json['publishedVersion']),
      repoUrl: serializer.fromJson<String?>(json['repoUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'packageName': serializer.toJson<String>(packageName),
      'devAnalyzerVersion': serializer.toJson<String?>(devAnalyzerVersion),
      'devVersion': serializer.toJson<String?>(devVersion),
      'devDate': serializer.toJson<DateTime>(devDate),
      'publishedDate': serializer.toJson<DateTime?>(publishedDate),
      'publishedVersion': serializer.toJson<String?>(publishedVersion),
      'repoUrl': serializer.toJson<String?>(repoUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PackageDataTableData copyWith({
    String? packageName,
    Value<String?> devAnalyzerVersion = const Value.absent(),
    Value<String?> devVersion = const Value.absent(),
    DateTime? devDate,
    Value<DateTime?> publishedDate = const Value.absent(),
    Value<String?> publishedVersion = const Value.absent(),
    Value<String?> repoUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PackageDataTableData(
    packageName: packageName ?? this.packageName,
    devAnalyzerVersion:
        devAnalyzerVersion.present
            ? devAnalyzerVersion.value
            : this.devAnalyzerVersion,
    devVersion: devVersion.present ? devVersion.value : this.devVersion,
    devDate: devDate ?? this.devDate,
    publishedDate:
        publishedDate.present ? publishedDate.value : this.publishedDate,
    publishedVersion:
        publishedVersion.present
            ? publishedVersion.value
            : this.publishedVersion,
    repoUrl: repoUrl.present ? repoUrl.value : this.repoUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PackageDataTableData copyWithCompanion(PackageDataTableCompanion data) {
    return PackageDataTableData(
      packageName:
          data.packageName.present ? data.packageName.value : this.packageName,
      devAnalyzerVersion:
          data.devAnalyzerVersion.present
              ? data.devAnalyzerVersion.value
              : this.devAnalyzerVersion,
      devVersion:
          data.devVersion.present ? data.devVersion.value : this.devVersion,
      devDate: data.devDate.present ? data.devDate.value : this.devDate,
      publishedDate:
          data.publishedDate.present
              ? data.publishedDate.value
              : this.publishedDate,
      publishedVersion:
          data.publishedVersion.present
              ? data.publishedVersion.value
              : this.publishedVersion,
      repoUrl: data.repoUrl.present ? data.repoUrl.value : this.repoUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackageDataTableData(')
          ..write('packageName: $packageName, ')
          ..write('devAnalyzerVersion: $devAnalyzerVersion, ')
          ..write('devVersion: $devVersion, ')
          ..write('devDate: $devDate, ')
          ..write('publishedDate: $publishedDate, ')
          ..write('publishedVersion: $publishedVersion, ')
          ..write('repoUrl: $repoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    packageName,
    devAnalyzerVersion,
    devVersion,
    devDate,
    publishedDate,
    publishedVersion,
    repoUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackageDataTableData &&
          other.packageName == this.packageName &&
          other.devAnalyzerVersion == this.devAnalyzerVersion &&
          other.devVersion == this.devVersion &&
          other.devDate == this.devDate &&
          other.publishedDate == this.publishedDate &&
          other.publishedVersion == this.publishedVersion &&
          other.repoUrl == this.repoUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PackageDataTableCompanion extends UpdateCompanion<PackageDataTableData> {
  final Value<String> packageName;
  final Value<String?> devAnalyzerVersion;
  final Value<String?> devVersion;
  final Value<DateTime> devDate;
  final Value<DateTime?> publishedDate;
  final Value<String?> publishedVersion;
  final Value<String?> repoUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PackageDataTableCompanion({
    this.packageName = const Value.absent(),
    this.devAnalyzerVersion = const Value.absent(),
    this.devVersion = const Value.absent(),
    this.devDate = const Value.absent(),
    this.publishedDate = const Value.absent(),
    this.publishedVersion = const Value.absent(),
    this.repoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackageDataTableCompanion.insert({
    required String packageName,
    this.devAnalyzerVersion = const Value.absent(),
    this.devVersion = const Value.absent(),
    required DateTime devDate,
    this.publishedDate = const Value.absent(),
    this.publishedVersion = const Value.absent(),
    this.repoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : packageName = Value(packageName),
       devDate = Value(devDate);
  static Insertable<PackageDataTableData> custom({
    Expression<String>? packageName,
    Expression<String>? devAnalyzerVersion,
    Expression<String>? devVersion,
    Expression<DateTime>? devDate,
    Expression<DateTime>? publishedDate,
    Expression<String>? publishedVersion,
    Expression<String>? repoUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packageName != null) 'package_name': packageName,
      if (devAnalyzerVersion != null)
        'dev_analyzer_version': devAnalyzerVersion,
      if (devVersion != null) 'dev_version': devVersion,
      if (devDate != null) 'dev_date': devDate,
      if (publishedDate != null) 'published_date': publishedDate,
      if (publishedVersion != null) 'published_version': publishedVersion,
      if (repoUrl != null) 'repo_url': repoUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackageDataTableCompanion copyWith({
    Value<String>? packageName,
    Value<String?>? devAnalyzerVersion,
    Value<String?>? devVersion,
    Value<DateTime>? devDate,
    Value<DateTime?>? publishedDate,
    Value<String?>? publishedVersion,
    Value<String?>? repoUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PackageDataTableCompanion(
      packageName: packageName ?? this.packageName,
      devAnalyzerVersion: devAnalyzerVersion ?? this.devAnalyzerVersion,
      devVersion: devVersion ?? this.devVersion,
      devDate: devDate ?? this.devDate,
      publishedDate: publishedDate ?? this.publishedDate,
      publishedVersion: publishedVersion ?? this.publishedVersion,
      repoUrl: repoUrl ?? this.repoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (devAnalyzerVersion.present) {
      map['dev_analyzer_version'] = Variable<String>(devAnalyzerVersion.value);
    }
    if (devVersion.present) {
      map['dev_version'] = Variable<String>(devVersion.value);
    }
    if (devDate.present) {
      map['dev_date'] = Variable<DateTime>(devDate.value);
    }
    if (publishedDate.present) {
      map['published_date'] = Variable<DateTime>(publishedDate.value);
    }
    if (publishedVersion.present) {
      map['published_version'] = Variable<String>(publishedVersion.value);
    }
    if (repoUrl.present) {
      map['repo_url'] = Variable<String>(repoUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackageDataTableCompanion(')
          ..write('packageName: $packageName, ')
          ..write('devAnalyzerVersion: $devAnalyzerVersion, ')
          ..write('devVersion: $devVersion, ')
          ..write('devDate: $devDate, ')
          ..write('publishedDate: $publishedDate, ')
          ..write('publishedVersion: $publishedVersion, ')
          ..write('repoUrl: $repoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackageSearchStateTableTable extends PackageSearchStateTable
    with TableInfo<$PackageSearchStateTableTable, PackageSearchStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackageSearchStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _searchIdMeta = const VerificationMeta(
    'searchId',
  );
  @override
  late final GeneratedColumn<String> searchId = GeneratedColumn<String>(
    'search_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allPackagesJsonMeta = const VerificationMeta(
    'allPackagesJson',
  );
  @override
  late final GeneratedColumn<String> allPackagesJson = GeneratedColumn<String>(
    'all_packages_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentIndexMeta = const VerificationMeta(
    'currentIndex',
  );
  @override
  late final GeneratedColumn<int> currentIndex = GeneratedColumn<int>(
    'current_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchStartedMeta = const VerificationMeta(
    'searchStarted',
  );
  @override
  late final GeneratedColumn<DateTime> searchStarted =
      GeneratedColumn<DateTime>(
        'search_started',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    searchId,
    allPackagesJson,
    currentIndex,
    totalCount,
    searchStarted,
    lastUpdated,
    isCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'package_search_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackageSearchStateTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('search_id')) {
      context.handle(
        _searchIdMeta,
        searchId.isAcceptableOrUnknown(data['search_id']!, _searchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_searchIdMeta);
    }
    if (data.containsKey('all_packages_json')) {
      context.handle(
        _allPackagesJsonMeta,
        allPackagesJson.isAcceptableOrUnknown(
          data['all_packages_json']!,
          _allPackagesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allPackagesJsonMeta);
    }
    if (data.containsKey('current_index')) {
      context.handle(
        _currentIndexMeta,
        currentIndex.isAcceptableOrUnknown(
          data['current_index']!,
          _currentIndexMeta,
        ),
      );
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCountMeta);
    }
    if (data.containsKey('search_started')) {
      context.handle(
        _searchStartedMeta,
        searchStarted.isAcceptableOrUnknown(
          data['search_started']!,
          _searchStartedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_searchStartedMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {searchId};
  @override
  PackageSearchStateTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackageSearchStateTableData(
      searchId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}search_id'],
          )!,
      allPackagesJson:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}all_packages_json'],
          )!,
      currentIndex:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}current_index'],
          )!,
      totalCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_count'],
          )!,
      searchStarted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}search_started'],
          )!,
      lastUpdated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_updated'],
          )!,
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
    );
  }

  @override
  $PackageSearchStateTableTable createAlias(String alias) {
    return $PackageSearchStateTableTable(attachedDatabase, alias);
  }
}

class PackageSearchStateTableData extends DataClass
    implements Insertable<PackageSearchStateTableData> {
  /// Primary key - search identifier (always 'analyzer_dependency')
  final String searchId;

  /// JSON encoded list of all discovered packages
  final String allPackagesJson;

  /// Current processing index
  final int currentIndex;

  /// Total count of packages
  final int totalCount;

  /// Timestamp when search was started
  final DateTime searchStarted;

  /// Timestamp when last updated
  final DateTime lastUpdated;

  /// Whether the search is completed
  final bool isCompleted;
  const PackageSearchStateTableData({
    required this.searchId,
    required this.allPackagesJson,
    required this.currentIndex,
    required this.totalCount,
    required this.searchStarted,
    required this.lastUpdated,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['search_id'] = Variable<String>(searchId);
    map['all_packages_json'] = Variable<String>(allPackagesJson);
    map['current_index'] = Variable<int>(currentIndex);
    map['total_count'] = Variable<int>(totalCount);
    map['search_started'] = Variable<DateTime>(searchStarted);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  PackageSearchStateTableCompanion toCompanion(bool nullToAbsent) {
    return PackageSearchStateTableCompanion(
      searchId: Value(searchId),
      allPackagesJson: Value(allPackagesJson),
      currentIndex: Value(currentIndex),
      totalCount: Value(totalCount),
      searchStarted: Value(searchStarted),
      lastUpdated: Value(lastUpdated),
      isCompleted: Value(isCompleted),
    );
  }

  factory PackageSearchStateTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackageSearchStateTableData(
      searchId: serializer.fromJson<String>(json['searchId']),
      allPackagesJson: serializer.fromJson<String>(json['allPackagesJson']),
      currentIndex: serializer.fromJson<int>(json['currentIndex']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      searchStarted: serializer.fromJson<DateTime>(json['searchStarted']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'searchId': serializer.toJson<String>(searchId),
      'allPackagesJson': serializer.toJson<String>(allPackagesJson),
      'currentIndex': serializer.toJson<int>(currentIndex),
      'totalCount': serializer.toJson<int>(totalCount),
      'searchStarted': serializer.toJson<DateTime>(searchStarted),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  PackageSearchStateTableData copyWith({
    String? searchId,
    String? allPackagesJson,
    int? currentIndex,
    int? totalCount,
    DateTime? searchStarted,
    DateTime? lastUpdated,
    bool? isCompleted,
  }) => PackageSearchStateTableData(
    searchId: searchId ?? this.searchId,
    allPackagesJson: allPackagesJson ?? this.allPackagesJson,
    currentIndex: currentIndex ?? this.currentIndex,
    totalCount: totalCount ?? this.totalCount,
    searchStarted: searchStarted ?? this.searchStarted,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  PackageSearchStateTableData copyWithCompanion(
    PackageSearchStateTableCompanion data,
  ) {
    return PackageSearchStateTableData(
      searchId: data.searchId.present ? data.searchId.value : this.searchId,
      allPackagesJson:
          data.allPackagesJson.present
              ? data.allPackagesJson.value
              : this.allPackagesJson,
      currentIndex:
          data.currentIndex.present
              ? data.currentIndex.value
              : this.currentIndex,
      totalCount:
          data.totalCount.present ? data.totalCount.value : this.totalCount,
      searchStarted:
          data.searchStarted.present
              ? data.searchStarted.value
              : this.searchStarted,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackageSearchStateTableData(')
          ..write('searchId: $searchId, ')
          ..write('allPackagesJson: $allPackagesJson, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('totalCount: $totalCount, ')
          ..write('searchStarted: $searchStarted, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    searchId,
    allPackagesJson,
    currentIndex,
    totalCount,
    searchStarted,
    lastUpdated,
    isCompleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackageSearchStateTableData &&
          other.searchId == this.searchId &&
          other.allPackagesJson == this.allPackagesJson &&
          other.currentIndex == this.currentIndex &&
          other.totalCount == this.totalCount &&
          other.searchStarted == this.searchStarted &&
          other.lastUpdated == this.lastUpdated &&
          other.isCompleted == this.isCompleted);
}

class PackageSearchStateTableCompanion
    extends UpdateCompanion<PackageSearchStateTableData> {
  final Value<String> searchId;
  final Value<String> allPackagesJson;
  final Value<int> currentIndex;
  final Value<int> totalCount;
  final Value<DateTime> searchStarted;
  final Value<DateTime> lastUpdated;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const PackageSearchStateTableCompanion({
    this.searchId = const Value.absent(),
    this.allPackagesJson = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.searchStarted = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackageSearchStateTableCompanion.insert({
    required String searchId,
    required String allPackagesJson,
    this.currentIndex = const Value.absent(),
    required int totalCount,
    required DateTime searchStarted,
    this.lastUpdated = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : searchId = Value(searchId),
       allPackagesJson = Value(allPackagesJson),
       totalCount = Value(totalCount),
       searchStarted = Value(searchStarted);
  static Insertable<PackageSearchStateTableData> custom({
    Expression<String>? searchId,
    Expression<String>? allPackagesJson,
    Expression<int>? currentIndex,
    Expression<int>? totalCount,
    Expression<DateTime>? searchStarted,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (searchId != null) 'search_id': searchId,
      if (allPackagesJson != null) 'all_packages_json': allPackagesJson,
      if (currentIndex != null) 'current_index': currentIndex,
      if (totalCount != null) 'total_count': totalCount,
      if (searchStarted != null) 'search_started': searchStarted,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackageSearchStateTableCompanion copyWith({
    Value<String>? searchId,
    Value<String>? allPackagesJson,
    Value<int>? currentIndex,
    Value<int>? totalCount,
    Value<DateTime>? searchStarted,
    Value<DateTime>? lastUpdated,
    Value<bool>? isCompleted,
    Value<int>? rowid,
  }) {
    return PackageSearchStateTableCompanion(
      searchId: searchId ?? this.searchId,
      allPackagesJson: allPackagesJson ?? this.allPackagesJson,
      currentIndex: currentIndex ?? this.currentIndex,
      totalCount: totalCount ?? this.totalCount,
      searchStarted: searchStarted ?? this.searchStarted,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (searchId.present) {
      map['search_id'] = Variable<String>(searchId.value);
    }
    if (allPackagesJson.present) {
      map['all_packages_json'] = Variable<String>(allPackagesJson.value);
    }
    if (currentIndex.present) {
      map['current_index'] = Variable<int>(currentIndex.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (searchStarted.present) {
      map['search_started'] = Variable<DateTime>(searchStarted.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackageSearchStateTableCompanion(')
          ..write('searchId: $searchId, ')
          ..write('allPackagesJson: $allPackagesJson, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('totalCount: $totalCount, ')
          ..write('searchStarted: $searchStarted, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$PackageDatabase extends GeneratedDatabase {
  _$PackageDatabase(QueryExecutor e) : super(e);
  $PackageDatabaseManager get managers => $PackageDatabaseManager(this);
  late final $PackageDataTableTable packageDataTable = $PackageDataTableTable(
    this,
  );
  late final $PackageSearchStateTableTable packageSearchStateTable =
      $PackageSearchStateTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    packageDataTable,
    packageSearchStateTable,
  ];
}

typedef $$PackageDataTableTableCreateCompanionBuilder =
    PackageDataTableCompanion Function({
      required String packageName,
      Value<String?> devAnalyzerVersion,
      Value<String?> devVersion,
      required DateTime devDate,
      Value<DateTime?> publishedDate,
      Value<String?> publishedVersion,
      Value<String?> repoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$PackageDataTableTableUpdateCompanionBuilder =
    PackageDataTableCompanion Function({
      Value<String> packageName,
      Value<String?> devAnalyzerVersion,
      Value<String?> devVersion,
      Value<DateTime> devDate,
      Value<DateTime?> publishedDate,
      Value<String?> publishedVersion,
      Value<String?> repoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PackageDataTableTableFilterComposer
    extends Composer<_$PackageDatabase, $PackageDataTableTable> {
  $$PackageDataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get devAnalyzerVersion => $composableBuilder(
    column: $table.devAnalyzerVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get devVersion => $composableBuilder(
    column: $table.devVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get devDate => $composableBuilder(
    column: $table.devDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedDate => $composableBuilder(
    column: $table.publishedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publishedVersion => $composableBuilder(
    column: $table.publishedVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repoUrl => $composableBuilder(
    column: $table.repoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PackageDataTableTableOrderingComposer
    extends Composer<_$PackageDatabase, $PackageDataTableTable> {
  $$PackageDataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get devAnalyzerVersion => $composableBuilder(
    column: $table.devAnalyzerVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get devVersion => $composableBuilder(
    column: $table.devVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get devDate => $composableBuilder(
    column: $table.devDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedDate => $composableBuilder(
    column: $table.publishedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publishedVersion => $composableBuilder(
    column: $table.publishedVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repoUrl => $composableBuilder(
    column: $table.repoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PackageDataTableTableAnnotationComposer
    extends Composer<_$PackageDatabase, $PackageDataTableTable> {
  $$PackageDataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get devAnalyzerVersion => $composableBuilder(
    column: $table.devAnalyzerVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get devVersion => $composableBuilder(
    column: $table.devVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get devDate =>
      $composableBuilder(column: $table.devDate, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedDate => $composableBuilder(
    column: $table.publishedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get publishedVersion => $composableBuilder(
    column: $table.publishedVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get repoUrl =>
      $composableBuilder(column: $table.repoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PackageDataTableTableTableManager
    extends
        RootTableManager<
          _$PackageDatabase,
          $PackageDataTableTable,
          PackageDataTableData,
          $$PackageDataTableTableFilterComposer,
          $$PackageDataTableTableOrderingComposer,
          $$PackageDataTableTableAnnotationComposer,
          $$PackageDataTableTableCreateCompanionBuilder,
          $$PackageDataTableTableUpdateCompanionBuilder,
          (
            PackageDataTableData,
            BaseReferences<
              _$PackageDatabase,
              $PackageDataTableTable,
              PackageDataTableData
            >,
          ),
          PackageDataTableData,
          PrefetchHooks Function()
        > {
  $$PackageDataTableTableTableManager(
    _$PackageDatabase db,
    $PackageDataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$PackageDataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PackageDataTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$PackageDataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> packageName = const Value.absent(),
                Value<String?> devAnalyzerVersion = const Value.absent(),
                Value<String?> devVersion = const Value.absent(),
                Value<DateTime> devDate = const Value.absent(),
                Value<DateTime?> publishedDate = const Value.absent(),
                Value<String?> publishedVersion = const Value.absent(),
                Value<String?> repoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackageDataTableCompanion(
                packageName: packageName,
                devAnalyzerVersion: devAnalyzerVersion,
                devVersion: devVersion,
                devDate: devDate,
                publishedDate: publishedDate,
                publishedVersion: publishedVersion,
                repoUrl: repoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String packageName,
                Value<String?> devAnalyzerVersion = const Value.absent(),
                Value<String?> devVersion = const Value.absent(),
                required DateTime devDate,
                Value<DateTime?> publishedDate = const Value.absent(),
                Value<String?> publishedVersion = const Value.absent(),
                Value<String?> repoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackageDataTableCompanion.insert(
                packageName: packageName,
                devAnalyzerVersion: devAnalyzerVersion,
                devVersion: devVersion,
                devDate: devDate,
                publishedDate: publishedDate,
                publishedVersion: publishedVersion,
                repoUrl: repoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PackageDataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$PackageDatabase,
      $PackageDataTableTable,
      PackageDataTableData,
      $$PackageDataTableTableFilterComposer,
      $$PackageDataTableTableOrderingComposer,
      $$PackageDataTableTableAnnotationComposer,
      $$PackageDataTableTableCreateCompanionBuilder,
      $$PackageDataTableTableUpdateCompanionBuilder,
      (
        PackageDataTableData,
        BaseReferences<
          _$PackageDatabase,
          $PackageDataTableTable,
          PackageDataTableData
        >,
      ),
      PackageDataTableData,
      PrefetchHooks Function()
    >;
typedef $$PackageSearchStateTableTableCreateCompanionBuilder =
    PackageSearchStateTableCompanion Function({
      required String searchId,
      required String allPackagesJson,
      Value<int> currentIndex,
      required int totalCount,
      required DateTime searchStarted,
      Value<DateTime> lastUpdated,
      Value<bool> isCompleted,
      Value<int> rowid,
    });
typedef $$PackageSearchStateTableTableUpdateCompanionBuilder =
    PackageSearchStateTableCompanion Function({
      Value<String> searchId,
      Value<String> allPackagesJson,
      Value<int> currentIndex,
      Value<int> totalCount,
      Value<DateTime> searchStarted,
      Value<DateTime> lastUpdated,
      Value<bool> isCompleted,
      Value<int> rowid,
    });

class $$PackageSearchStateTableTableFilterComposer
    extends Composer<_$PackageDatabase, $PackageSearchStateTableTable> {
  $$PackageSearchStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get searchId => $composableBuilder(
    column: $table.searchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allPackagesJson => $composableBuilder(
    column: $table.allPackagesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get searchStarted => $composableBuilder(
    column: $table.searchStarted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PackageSearchStateTableTableOrderingComposer
    extends Composer<_$PackageDatabase, $PackageSearchStateTableTable> {
  $$PackageSearchStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get searchId => $composableBuilder(
    column: $table.searchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allPackagesJson => $composableBuilder(
    column: $table.allPackagesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get searchStarted => $composableBuilder(
    column: $table.searchStarted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PackageSearchStateTableTableAnnotationComposer
    extends Composer<_$PackageDatabase, $PackageSearchStateTableTable> {
  $$PackageSearchStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get searchId =>
      $composableBuilder(column: $table.searchId, builder: (column) => column);

  GeneratedColumn<String> get allPackagesJson => $composableBuilder(
    column: $table.allPackagesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get searchStarted => $composableBuilder(
    column: $table.searchStarted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );
}

class $$PackageSearchStateTableTableTableManager
    extends
        RootTableManager<
          _$PackageDatabase,
          $PackageSearchStateTableTable,
          PackageSearchStateTableData,
          $$PackageSearchStateTableTableFilterComposer,
          $$PackageSearchStateTableTableOrderingComposer,
          $$PackageSearchStateTableTableAnnotationComposer,
          $$PackageSearchStateTableTableCreateCompanionBuilder,
          $$PackageSearchStateTableTableUpdateCompanionBuilder,
          (
            PackageSearchStateTableData,
            BaseReferences<
              _$PackageDatabase,
              $PackageSearchStateTableTable,
              PackageSearchStateTableData
            >,
          ),
          PackageSearchStateTableData,
          PrefetchHooks Function()
        > {
  $$PackageSearchStateTableTableTableManager(
    _$PackageDatabase db,
    $PackageSearchStateTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PackageSearchStateTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$PackageSearchStateTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$PackageSearchStateTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> searchId = const Value.absent(),
                Value<String> allPackagesJson = const Value.absent(),
                Value<int> currentIndex = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<DateTime> searchStarted = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackageSearchStateTableCompanion(
                searchId: searchId,
                allPackagesJson: allPackagesJson,
                currentIndex: currentIndex,
                totalCount: totalCount,
                searchStarted: searchStarted,
                lastUpdated: lastUpdated,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String searchId,
                required String allPackagesJson,
                Value<int> currentIndex = const Value.absent(),
                required int totalCount,
                required DateTime searchStarted,
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackageSearchStateTableCompanion.insert(
                searchId: searchId,
                allPackagesJson: allPackagesJson,
                currentIndex: currentIndex,
                totalCount: totalCount,
                searchStarted: searchStarted,
                lastUpdated: lastUpdated,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PackageSearchStateTableTableProcessedTableManager =
    ProcessedTableManager<
      _$PackageDatabase,
      $PackageSearchStateTableTable,
      PackageSearchStateTableData,
      $$PackageSearchStateTableTableFilterComposer,
      $$PackageSearchStateTableTableOrderingComposer,
      $$PackageSearchStateTableTableAnnotationComposer,
      $$PackageSearchStateTableTableCreateCompanionBuilder,
      $$PackageSearchStateTableTableUpdateCompanionBuilder,
      (
        PackageSearchStateTableData,
        BaseReferences<
          _$PackageDatabase,
          $PackageSearchStateTableTable,
          PackageSearchStateTableData
        >,
      ),
      PackageSearchStateTableData,
      PrefetchHooks Function()
    >;

class $PackageDatabaseManager {
  final _$PackageDatabase _db;
  $PackageDatabaseManager(this._db);
  $$PackageDataTableTableTableManager get packageDataTable =>
      $$PackageDataTableTableTableManager(_db, _db.packageDataTable);
  $$PackageSearchStateTableTableTableManager get packageSearchStateTable =>
      $$PackageSearchStateTableTableTableManager(
        _db,
        _db.packageSearchStateTable,
      );
}
