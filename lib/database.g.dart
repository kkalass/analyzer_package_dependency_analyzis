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
  static const VerificationMeta _downloadCount30DaysMeta =
      const VerificationMeta('downloadCount30Days');
  @override
  late final GeneratedColumn<int> downloadCount30Days = GeneratedColumn<int>(
    'download_count30_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _likeCountMeta = const VerificationMeta(
    'likeCount',
  );
  @override
  late final GeneratedColumn<int> likeCount = GeneratedColumn<int>(
    'like_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grantedPointsMeta = const VerificationMeta(
    'grantedPoints',
  );
  @override
  late final GeneratedColumn<int> grantedPoints = GeneratedColumn<int>(
    'granted_points',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _popularityScoreMeta = const VerificationMeta(
    'popularityScore',
  );
  @override
  late final GeneratedColumn<double> popularityScore = GeneratedColumn<double>(
    'popularity_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxPointsMeta = const VerificationMeta(
    'maxPoints',
  );
  @override
  late final GeneratedColumn<int> maxPoints = GeneratedColumn<int>(
    'max_points',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    downloadCount30Days,
    likeCount,
    grantedPoints,
    popularityScore,
    maxPoints,
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
    if (data.containsKey('download_count30_days')) {
      context.handle(
        _downloadCount30DaysMeta,
        downloadCount30Days.isAcceptableOrUnknown(
          data['download_count30_days']!,
          _downloadCount30DaysMeta,
        ),
      );
    }
    if (data.containsKey('like_count')) {
      context.handle(
        _likeCountMeta,
        likeCount.isAcceptableOrUnknown(data['like_count']!, _likeCountMeta),
      );
    }
    if (data.containsKey('granted_points')) {
      context.handle(
        _grantedPointsMeta,
        grantedPoints.isAcceptableOrUnknown(
          data['granted_points']!,
          _grantedPointsMeta,
        ),
      );
    }
    if (data.containsKey('popularity_score')) {
      context.handle(
        _popularityScoreMeta,
        popularityScore.isAcceptableOrUnknown(
          data['popularity_score']!,
          _popularityScoreMeta,
        ),
      );
    }
    if (data.containsKey('max_points')) {
      context.handle(
        _maxPointsMeta,
        maxPoints.isAcceptableOrUnknown(data['max_points']!, _maxPointsMeta),
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
      downloadCount30Days: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}download_count30_days'],
      ),
      likeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}like_count'],
      ),
      grantedPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}granted_points'],
      ),
      popularityScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}popularity_score'],
      ),
      maxPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_points'],
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

  /// Download count for the last 30 days
  final int? downloadCount30Days;

  /// Number of likes for the package
  final int? likeCount;

  /// Granted points from pub.dev scoring
  final int? grantedPoints;

  /// Popularity score from pub.dev
  final double? popularityScore;

  /// Maximum points possible in scoring
  final int? maxPoints;

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
    this.downloadCount30Days,
    this.likeCount,
    this.grantedPoints,
    this.popularityScore,
    this.maxPoints,
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
    if (!nullToAbsent || downloadCount30Days != null) {
      map['download_count30_days'] = Variable<int>(downloadCount30Days);
    }
    if (!nullToAbsent || likeCount != null) {
      map['like_count'] = Variable<int>(likeCount);
    }
    if (!nullToAbsent || grantedPoints != null) {
      map['granted_points'] = Variable<int>(grantedPoints);
    }
    if (!nullToAbsent || popularityScore != null) {
      map['popularity_score'] = Variable<double>(popularityScore);
    }
    if (!nullToAbsent || maxPoints != null) {
      map['max_points'] = Variable<int>(maxPoints);
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
      downloadCount30Days:
          downloadCount30Days == null && nullToAbsent
              ? const Value.absent()
              : Value(downloadCount30Days),
      likeCount:
          likeCount == null && nullToAbsent
              ? const Value.absent()
              : Value(likeCount),
      grantedPoints:
          grantedPoints == null && nullToAbsent
              ? const Value.absent()
              : Value(grantedPoints),
      popularityScore:
          popularityScore == null && nullToAbsent
              ? const Value.absent()
              : Value(popularityScore),
      maxPoints:
          maxPoints == null && nullToAbsent
              ? const Value.absent()
              : Value(maxPoints),
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
      downloadCount30Days: serializer.fromJson<int?>(
        json['downloadCount30Days'],
      ),
      likeCount: serializer.fromJson<int?>(json['likeCount']),
      grantedPoints: serializer.fromJson<int?>(json['grantedPoints']),
      popularityScore: serializer.fromJson<double?>(json['popularityScore']),
      maxPoints: serializer.fromJson<int?>(json['maxPoints']),
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
      'downloadCount30Days': serializer.toJson<int?>(downloadCount30Days),
      'likeCount': serializer.toJson<int?>(likeCount),
      'grantedPoints': serializer.toJson<int?>(grantedPoints),
      'popularityScore': serializer.toJson<double?>(popularityScore),
      'maxPoints': serializer.toJson<int?>(maxPoints),
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
    Value<int?> downloadCount30Days = const Value.absent(),
    Value<int?> likeCount = const Value.absent(),
    Value<int?> grantedPoints = const Value.absent(),
    Value<double?> popularityScore = const Value.absent(),
    Value<int?> maxPoints = const Value.absent(),
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
    downloadCount30Days:
        downloadCount30Days.present
            ? downloadCount30Days.value
            : this.downloadCount30Days,
    likeCount: likeCount.present ? likeCount.value : this.likeCount,
    grantedPoints:
        grantedPoints.present ? grantedPoints.value : this.grantedPoints,
    popularityScore:
        popularityScore.present ? popularityScore.value : this.popularityScore,
    maxPoints: maxPoints.present ? maxPoints.value : this.maxPoints,
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
      downloadCount30Days:
          data.downloadCount30Days.present
              ? data.downloadCount30Days.value
              : this.downloadCount30Days,
      likeCount: data.likeCount.present ? data.likeCount.value : this.likeCount,
      grantedPoints:
          data.grantedPoints.present
              ? data.grantedPoints.value
              : this.grantedPoints,
      popularityScore:
          data.popularityScore.present
              ? data.popularityScore.value
              : this.popularityScore,
      maxPoints: data.maxPoints.present ? data.maxPoints.value : this.maxPoints,
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
          ..write('downloadCount30Days: $downloadCount30Days, ')
          ..write('likeCount: $likeCount, ')
          ..write('grantedPoints: $grantedPoints, ')
          ..write('popularityScore: $popularityScore, ')
          ..write('maxPoints: $maxPoints, ')
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
    downloadCount30Days,
    likeCount,
    grantedPoints,
    popularityScore,
    maxPoints,
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
          other.downloadCount30Days == this.downloadCount30Days &&
          other.likeCount == this.likeCount &&
          other.grantedPoints == this.grantedPoints &&
          other.popularityScore == this.popularityScore &&
          other.maxPoints == this.maxPoints &&
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
  final Value<int?> downloadCount30Days;
  final Value<int?> likeCount;
  final Value<int?> grantedPoints;
  final Value<double?> popularityScore;
  final Value<int?> maxPoints;
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
    this.downloadCount30Days = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.grantedPoints = const Value.absent(),
    this.popularityScore = const Value.absent(),
    this.maxPoints = const Value.absent(),
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
    this.downloadCount30Days = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.grantedPoints = const Value.absent(),
    this.popularityScore = const Value.absent(),
    this.maxPoints = const Value.absent(),
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
    Expression<int>? downloadCount30Days,
    Expression<int>? likeCount,
    Expression<int>? grantedPoints,
    Expression<double>? popularityScore,
    Expression<int>? maxPoints,
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
      if (downloadCount30Days != null)
        'download_count30_days': downloadCount30Days,
      if (likeCount != null) 'like_count': likeCount,
      if (grantedPoints != null) 'granted_points': grantedPoints,
      if (popularityScore != null) 'popularity_score': popularityScore,
      if (maxPoints != null) 'max_points': maxPoints,
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
    Value<int?>? downloadCount30Days,
    Value<int?>? likeCount,
    Value<int?>? grantedPoints,
    Value<double?>? popularityScore,
    Value<int?>? maxPoints,
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
      downloadCount30Days: downloadCount30Days ?? this.downloadCount30Days,
      likeCount: likeCount ?? this.likeCount,
      grantedPoints: grantedPoints ?? this.grantedPoints,
      popularityScore: popularityScore ?? this.popularityScore,
      maxPoints: maxPoints ?? this.maxPoints,
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
    if (downloadCount30Days.present) {
      map['download_count30_days'] = Variable<int>(downloadCount30Days.value);
    }
    if (likeCount.present) {
      map['like_count'] = Variable<int>(likeCount.value);
    }
    if (grantedPoints.present) {
      map['granted_points'] = Variable<int>(grantedPoints.value);
    }
    if (popularityScore.present) {
      map['popularity_score'] = Variable<double>(popularityScore.value);
    }
    if (maxPoints.present) {
      map['max_points'] = Variable<int>(maxPoints.value);
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
          ..write('downloadCount30Days: $downloadCount30Days, ')
          ..write('likeCount: $likeCount, ')
          ..write('grantedPoints: $grantedPoints, ')
          ..write('popularityScore: $popularityScore, ')
          ..write('maxPoints: $maxPoints, ')
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
  static const VerificationMeta _nextPageUrlMeta = const VerificationMeta(
    'nextPageUrl',
  );
  @override
  late final GeneratedColumn<String> nextPageUrl = GeneratedColumn<String>(
    'next_page_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPageMeta = const VerificationMeta(
    'currentPage',
  );
  @override
  late final GeneratedColumn<int> currentPage = GeneratedColumn<int>(
    'current_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _discoveryCompletedMeta =
      const VerificationMeta('discoveryCompleted');
  @override
  late final GeneratedColumn<bool> discoveryCompleted = GeneratedColumn<bool>(
    'discovery_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("discovery_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _processingCompletedMeta =
      const VerificationMeta('processingCompleted');
  @override
  late final GeneratedColumn<bool> processingCompleted = GeneratedColumn<bool>(
    'processing_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("processing_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  @override
  List<GeneratedColumn> get $columns => [
    searchId,
    allPackagesJson,
    nextPageUrl,
    currentPage,
    currentIndex,
    totalCount,
    discoveryCompleted,
    processingCompleted,
    searchStarted,
    lastUpdated,
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
    if (data.containsKey('next_page_url')) {
      context.handle(
        _nextPageUrlMeta,
        nextPageUrl.isAcceptableOrUnknown(
          data['next_page_url']!,
          _nextPageUrlMeta,
        ),
      );
    }
    if (data.containsKey('current_page')) {
      context.handle(
        _currentPageMeta,
        currentPage.isAcceptableOrUnknown(
          data['current_page']!,
          _currentPageMeta,
        ),
      );
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
    if (data.containsKey('discovery_completed')) {
      context.handle(
        _discoveryCompletedMeta,
        discoveryCompleted.isAcceptableOrUnknown(
          data['discovery_completed']!,
          _discoveryCompletedMeta,
        ),
      );
    }
    if (data.containsKey('processing_completed')) {
      context.handle(
        _processingCompletedMeta,
        processingCompleted.isAcceptableOrUnknown(
          data['processing_completed']!,
          _processingCompletedMeta,
        ),
      );
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
      nextPageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_page_url'],
      ),
      currentPage:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}current_page'],
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
      discoveryCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}discovery_completed'],
          )!,
      processingCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}processing_completed'],
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

  /// JSON encoded list of all discovered packages so far
  final String allPackagesJson;

  /// Current pagination URL (next page to fetch)
  final String? nextPageUrl;

  /// Current page number being fetched
  final int currentPage;

  /// Current processing index for package processing
  final int currentIndex;

  /// Total count of packages discovered so far
  final int totalCount;

  /// Whether package discovery is completed
  final bool discoveryCompleted;

  /// Whether processing is completed
  final bool processingCompleted;

  /// Timestamp when search was started
  final DateTime searchStarted;

  /// Timestamp when last updated
  final DateTime lastUpdated;
  const PackageSearchStateTableData({
    required this.searchId,
    required this.allPackagesJson,
    this.nextPageUrl,
    required this.currentPage,
    required this.currentIndex,
    required this.totalCount,
    required this.discoveryCompleted,
    required this.processingCompleted,
    required this.searchStarted,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['search_id'] = Variable<String>(searchId);
    map['all_packages_json'] = Variable<String>(allPackagesJson);
    if (!nullToAbsent || nextPageUrl != null) {
      map['next_page_url'] = Variable<String>(nextPageUrl);
    }
    map['current_page'] = Variable<int>(currentPage);
    map['current_index'] = Variable<int>(currentIndex);
    map['total_count'] = Variable<int>(totalCount);
    map['discovery_completed'] = Variable<bool>(discoveryCompleted);
    map['processing_completed'] = Variable<bool>(processingCompleted);
    map['search_started'] = Variable<DateTime>(searchStarted);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  PackageSearchStateTableCompanion toCompanion(bool nullToAbsent) {
    return PackageSearchStateTableCompanion(
      searchId: Value(searchId),
      allPackagesJson: Value(allPackagesJson),
      nextPageUrl:
          nextPageUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(nextPageUrl),
      currentPage: Value(currentPage),
      currentIndex: Value(currentIndex),
      totalCount: Value(totalCount),
      discoveryCompleted: Value(discoveryCompleted),
      processingCompleted: Value(processingCompleted),
      searchStarted: Value(searchStarted),
      lastUpdated: Value(lastUpdated),
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
      nextPageUrl: serializer.fromJson<String?>(json['nextPageUrl']),
      currentPage: serializer.fromJson<int>(json['currentPage']),
      currentIndex: serializer.fromJson<int>(json['currentIndex']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      discoveryCompleted: serializer.fromJson<bool>(json['discoveryCompleted']),
      processingCompleted: serializer.fromJson<bool>(
        json['processingCompleted'],
      ),
      searchStarted: serializer.fromJson<DateTime>(json['searchStarted']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'searchId': serializer.toJson<String>(searchId),
      'allPackagesJson': serializer.toJson<String>(allPackagesJson),
      'nextPageUrl': serializer.toJson<String?>(nextPageUrl),
      'currentPage': serializer.toJson<int>(currentPage),
      'currentIndex': serializer.toJson<int>(currentIndex),
      'totalCount': serializer.toJson<int>(totalCount),
      'discoveryCompleted': serializer.toJson<bool>(discoveryCompleted),
      'processingCompleted': serializer.toJson<bool>(processingCompleted),
      'searchStarted': serializer.toJson<DateTime>(searchStarted),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  PackageSearchStateTableData copyWith({
    String? searchId,
    String? allPackagesJson,
    Value<String?> nextPageUrl = const Value.absent(),
    int? currentPage,
    int? currentIndex,
    int? totalCount,
    bool? discoveryCompleted,
    bool? processingCompleted,
    DateTime? searchStarted,
    DateTime? lastUpdated,
  }) => PackageSearchStateTableData(
    searchId: searchId ?? this.searchId,
    allPackagesJson: allPackagesJson ?? this.allPackagesJson,
    nextPageUrl: nextPageUrl.present ? nextPageUrl.value : this.nextPageUrl,
    currentPage: currentPage ?? this.currentPage,
    currentIndex: currentIndex ?? this.currentIndex,
    totalCount: totalCount ?? this.totalCount,
    discoveryCompleted: discoveryCompleted ?? this.discoveryCompleted,
    processingCompleted: processingCompleted ?? this.processingCompleted,
    searchStarted: searchStarted ?? this.searchStarted,
    lastUpdated: lastUpdated ?? this.lastUpdated,
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
      nextPageUrl:
          data.nextPageUrl.present ? data.nextPageUrl.value : this.nextPageUrl,
      currentPage:
          data.currentPage.present ? data.currentPage.value : this.currentPage,
      currentIndex:
          data.currentIndex.present
              ? data.currentIndex.value
              : this.currentIndex,
      totalCount:
          data.totalCount.present ? data.totalCount.value : this.totalCount,
      discoveryCompleted:
          data.discoveryCompleted.present
              ? data.discoveryCompleted.value
              : this.discoveryCompleted,
      processingCompleted:
          data.processingCompleted.present
              ? data.processingCompleted.value
              : this.processingCompleted,
      searchStarted:
          data.searchStarted.present
              ? data.searchStarted.value
              : this.searchStarted,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackageSearchStateTableData(')
          ..write('searchId: $searchId, ')
          ..write('allPackagesJson: $allPackagesJson, ')
          ..write('nextPageUrl: $nextPageUrl, ')
          ..write('currentPage: $currentPage, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('totalCount: $totalCount, ')
          ..write('discoveryCompleted: $discoveryCompleted, ')
          ..write('processingCompleted: $processingCompleted, ')
          ..write('searchStarted: $searchStarted, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    searchId,
    allPackagesJson,
    nextPageUrl,
    currentPage,
    currentIndex,
    totalCount,
    discoveryCompleted,
    processingCompleted,
    searchStarted,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackageSearchStateTableData &&
          other.searchId == this.searchId &&
          other.allPackagesJson == this.allPackagesJson &&
          other.nextPageUrl == this.nextPageUrl &&
          other.currentPage == this.currentPage &&
          other.currentIndex == this.currentIndex &&
          other.totalCount == this.totalCount &&
          other.discoveryCompleted == this.discoveryCompleted &&
          other.processingCompleted == this.processingCompleted &&
          other.searchStarted == this.searchStarted &&
          other.lastUpdated == this.lastUpdated);
}

class PackageSearchStateTableCompanion
    extends UpdateCompanion<PackageSearchStateTableData> {
  final Value<String> searchId;
  final Value<String> allPackagesJson;
  final Value<String?> nextPageUrl;
  final Value<int> currentPage;
  final Value<int> currentIndex;
  final Value<int> totalCount;
  final Value<bool> discoveryCompleted;
  final Value<bool> processingCompleted;
  final Value<DateTime> searchStarted;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const PackageSearchStateTableCompanion({
    this.searchId = const Value.absent(),
    this.allPackagesJson = const Value.absent(),
    this.nextPageUrl = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.discoveryCompleted = const Value.absent(),
    this.processingCompleted = const Value.absent(),
    this.searchStarted = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackageSearchStateTableCompanion.insert({
    required String searchId,
    required String allPackagesJson,
    this.nextPageUrl = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.currentIndex = const Value.absent(),
    required int totalCount,
    this.discoveryCompleted = const Value.absent(),
    this.processingCompleted = const Value.absent(),
    required DateTime searchStarted,
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : searchId = Value(searchId),
       allPackagesJson = Value(allPackagesJson),
       totalCount = Value(totalCount),
       searchStarted = Value(searchStarted);
  static Insertable<PackageSearchStateTableData> custom({
    Expression<String>? searchId,
    Expression<String>? allPackagesJson,
    Expression<String>? nextPageUrl,
    Expression<int>? currentPage,
    Expression<int>? currentIndex,
    Expression<int>? totalCount,
    Expression<bool>? discoveryCompleted,
    Expression<bool>? processingCompleted,
    Expression<DateTime>? searchStarted,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (searchId != null) 'search_id': searchId,
      if (allPackagesJson != null) 'all_packages_json': allPackagesJson,
      if (nextPageUrl != null) 'next_page_url': nextPageUrl,
      if (currentPage != null) 'current_page': currentPage,
      if (currentIndex != null) 'current_index': currentIndex,
      if (totalCount != null) 'total_count': totalCount,
      if (discoveryCompleted != null) 'discovery_completed': discoveryCompleted,
      if (processingCompleted != null)
        'processing_completed': processingCompleted,
      if (searchStarted != null) 'search_started': searchStarted,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackageSearchStateTableCompanion copyWith({
    Value<String>? searchId,
    Value<String>? allPackagesJson,
    Value<String?>? nextPageUrl,
    Value<int>? currentPage,
    Value<int>? currentIndex,
    Value<int>? totalCount,
    Value<bool>? discoveryCompleted,
    Value<bool>? processingCompleted,
    Value<DateTime>? searchStarted,
    Value<DateTime>? lastUpdated,
    Value<int>? rowid,
  }) {
    return PackageSearchStateTableCompanion(
      searchId: searchId ?? this.searchId,
      allPackagesJson: allPackagesJson ?? this.allPackagesJson,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      currentPage: currentPage ?? this.currentPage,
      currentIndex: currentIndex ?? this.currentIndex,
      totalCount: totalCount ?? this.totalCount,
      discoveryCompleted: discoveryCompleted ?? this.discoveryCompleted,
      processingCompleted: processingCompleted ?? this.processingCompleted,
      searchStarted: searchStarted ?? this.searchStarted,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (nextPageUrl.present) {
      map['next_page_url'] = Variable<String>(nextPageUrl.value);
    }
    if (currentPage.present) {
      map['current_page'] = Variable<int>(currentPage.value);
    }
    if (currentIndex.present) {
      map['current_index'] = Variable<int>(currentIndex.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (discoveryCompleted.present) {
      map['discovery_completed'] = Variable<bool>(discoveryCompleted.value);
    }
    if (processingCompleted.present) {
      map['processing_completed'] = Variable<bool>(processingCompleted.value);
    }
    if (searchStarted.present) {
      map['search_started'] = Variable<DateTime>(searchStarted.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
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
          ..write('nextPageUrl: $nextPageUrl, ')
          ..write('currentPage: $currentPage, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('totalCount: $totalCount, ')
          ..write('discoveryCompleted: $discoveryCompleted, ')
          ..write('processingCompleted: $processingCompleted, ')
          ..write('searchStarted: $searchStarted, ')
          ..write('lastUpdated: $lastUpdated, ')
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
      Value<int?> downloadCount30Days,
      Value<int?> likeCount,
      Value<int?> grantedPoints,
      Value<double?> popularityScore,
      Value<int?> maxPoints,
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
      Value<int?> downloadCount30Days,
      Value<int?> likeCount,
      Value<int?> grantedPoints,
      Value<double?> popularityScore,
      Value<int?> maxPoints,
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

  ColumnFilters<int> get downloadCount30Days => $composableBuilder(
    column: $table.downloadCount30Days,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grantedPoints => $composableBuilder(
    column: $table.grantedPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get popularityScore => $composableBuilder(
    column: $table.popularityScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxPoints => $composableBuilder(
    column: $table.maxPoints,
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

  ColumnOrderings<int> get downloadCount30Days => $composableBuilder(
    column: $table.downloadCount30Days,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grantedPoints => $composableBuilder(
    column: $table.grantedPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get popularityScore => $composableBuilder(
    column: $table.popularityScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxPoints => $composableBuilder(
    column: $table.maxPoints,
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

  GeneratedColumn<int> get downloadCount30Days => $composableBuilder(
    column: $table.downloadCount30Days,
    builder: (column) => column,
  );

  GeneratedColumn<int> get likeCount =>
      $composableBuilder(column: $table.likeCount, builder: (column) => column);

  GeneratedColumn<int> get grantedPoints => $composableBuilder(
    column: $table.grantedPoints,
    builder: (column) => column,
  );

  GeneratedColumn<double> get popularityScore => $composableBuilder(
    column: $table.popularityScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxPoints =>
      $composableBuilder(column: $table.maxPoints, builder: (column) => column);

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
                Value<int?> downloadCount30Days = const Value.absent(),
                Value<int?> likeCount = const Value.absent(),
                Value<int?> grantedPoints = const Value.absent(),
                Value<double?> popularityScore = const Value.absent(),
                Value<int?> maxPoints = const Value.absent(),
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
                downloadCount30Days: downloadCount30Days,
                likeCount: likeCount,
                grantedPoints: grantedPoints,
                popularityScore: popularityScore,
                maxPoints: maxPoints,
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
                Value<int?> downloadCount30Days = const Value.absent(),
                Value<int?> likeCount = const Value.absent(),
                Value<int?> grantedPoints = const Value.absent(),
                Value<double?> popularityScore = const Value.absent(),
                Value<int?> maxPoints = const Value.absent(),
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
                downloadCount30Days: downloadCount30Days,
                likeCount: likeCount,
                grantedPoints: grantedPoints,
                popularityScore: popularityScore,
                maxPoints: maxPoints,
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
      Value<String?> nextPageUrl,
      Value<int> currentPage,
      Value<int> currentIndex,
      required int totalCount,
      Value<bool> discoveryCompleted,
      Value<bool> processingCompleted,
      required DateTime searchStarted,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });
typedef $$PackageSearchStateTableTableUpdateCompanionBuilder =
    PackageSearchStateTableCompanion Function({
      Value<String> searchId,
      Value<String> allPackagesJson,
      Value<String?> nextPageUrl,
      Value<int> currentPage,
      Value<int> currentIndex,
      Value<int> totalCount,
      Value<bool> discoveryCompleted,
      Value<bool> processingCompleted,
      Value<DateTime> searchStarted,
      Value<DateTime> lastUpdated,
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

  ColumnFilters<String> get nextPageUrl => $composableBuilder(
    column: $table.nextPageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
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

  ColumnFilters<bool> get discoveryCompleted => $composableBuilder(
    column: $table.discoveryCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get processingCompleted => $composableBuilder(
    column: $table.processingCompleted,
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

  ColumnOrderings<String> get nextPageUrl => $composableBuilder(
    column: $table.nextPageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
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

  ColumnOrderings<bool> get discoveryCompleted => $composableBuilder(
    column: $table.discoveryCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get processingCompleted => $composableBuilder(
    column: $table.processingCompleted,
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

  GeneratedColumn<String> get nextPageUrl => $composableBuilder(
    column: $table.nextPageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
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

  GeneratedColumn<bool> get discoveryCompleted => $composableBuilder(
    column: $table.discoveryCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get processingCompleted => $composableBuilder(
    column: $table.processingCompleted,
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
                Value<String?> nextPageUrl = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<int> currentIndex = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<bool> discoveryCompleted = const Value.absent(),
                Value<bool> processingCompleted = const Value.absent(),
                Value<DateTime> searchStarted = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackageSearchStateTableCompanion(
                searchId: searchId,
                allPackagesJson: allPackagesJson,
                nextPageUrl: nextPageUrl,
                currentPage: currentPage,
                currentIndex: currentIndex,
                totalCount: totalCount,
                discoveryCompleted: discoveryCompleted,
                processingCompleted: processingCompleted,
                searchStarted: searchStarted,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String searchId,
                required String allPackagesJson,
                Value<String?> nextPageUrl = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<int> currentIndex = const Value.absent(),
                required int totalCount,
                Value<bool> discoveryCompleted = const Value.absent(),
                Value<bool> processingCompleted = const Value.absent(),
                required DateTime searchStarted,
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackageSearchStateTableCompanion.insert(
                searchId: searchId,
                allPackagesJson: allPackagesJson,
                nextPageUrl: nextPageUrl,
                currentPage: currentPage,
                currentIndex: currentIndex,
                totalCount: totalCount,
                discoveryCompleted: discoveryCompleted,
                processingCompleted: processingCompleted,
                searchStarted: searchStarted,
                lastUpdated: lastUpdated,
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
