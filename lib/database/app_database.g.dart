// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _identifierMeta =
      const VerificationMeta('identifier');
  @override
  late final GeneratedColumn<String> identifier = GeneratedColumn<String>(
      'identifier', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns => [id, identifier, companyName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('identifier')) {
      context.handle(
          _identifierMeta,
          identifier.isAcceptableOrUnknown(
              data['identifier']!, _identifierMeta));
    } else if (isInserting) {
      context.missing(_identifierMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      identifier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}identifier'])!,
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String identifier;
  final String companyName;
  const Customer(
      {required this.id, required this.identifier, required this.companyName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['identifier'] = Variable<String>(identifier);
    map['company_name'] = Variable<String>(companyName);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      identifier: Value(identifier),
      companyName: Value(companyName),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      identifier: serializer.fromJson<String>(json['identifier']),
      companyName: serializer.fromJson<String>(json['companyName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'identifier': serializer.toJson<String>(identifier),
      'companyName': serializer.toJson<String>(companyName),
    };
  }

  Customer copyWith({int? id, String? identifier, String? companyName}) =>
      Customer(
        id: id ?? this.id,
        identifier: identifier ?? this.identifier,
        companyName: companyName ?? this.companyName,
      );
  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('identifier: $identifier, ')
          ..write('companyName: $companyName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, identifier, companyName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.identifier == this.identifier &&
          other.companyName == this.companyName);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> identifier;
  final Value<String> companyName;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.identifier = const Value.absent(),
    this.companyName = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String identifier,
    this.companyName = const Value.absent(),
  }) : identifier = Value(identifier);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? identifier,
    Expression<String>? companyName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (identifier != null) 'identifier': identifier,
      if (companyName != null) 'company_name': companyName,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? id, Value<String>? identifier, Value<String>? companyName}) {
    return CustomersCompanion(
      id: id ?? this.id,
      identifier: identifier ?? this.identifier,
      companyName: companyName ?? this.companyName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('identifier: $identifier, ')
          ..write('companyName: $companyName')
          ..write(')'))
        .toString();
  }
}

class $SiteResidentsTable extends SiteResidents
    with TableInfo<$SiteResidentsTable, SiteResident> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SiteResidentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _jobPositionMeta =
      const VerificationMeta('jobPosition');
  @override
  late final GeneratedColumn<String> jobPosition = GeneratedColumn<String>(
      'job_position', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns => [id, firstName, lastName, jobPosition];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'site_residents';
  @override
  VerificationContext validateIntegrity(Insertable<SiteResident> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('job_position')) {
      context.handle(
          _jobPositionMeta,
          jobPosition.isAcceptableOrUnknown(
              data['job_position']!, _jobPositionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SiteResident map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SiteResident(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      jobPosition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_position'])!,
    );
  }

  @override
  $SiteResidentsTable createAlias(String alias) {
    return $SiteResidentsTable(attachedDatabase, alias);
  }
}

class SiteResident extends DataClass implements Insertable<SiteResident> {
  final int id;
  final String firstName;
  final String lastName;
  final String jobPosition;
  const SiteResident(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.jobPosition});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['job_position'] = Variable<String>(jobPosition);
    return map;
  }

  SiteResidentsCompanion toCompanion(bool nullToAbsent) {
    return SiteResidentsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      jobPosition: Value(jobPosition),
    );
  }

  factory SiteResident.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiteResident(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      jobPosition: serializer.fromJson<String>(json['jobPosition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'jobPosition': serializer.toJson<String>(jobPosition),
    };
  }

  SiteResident copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? jobPosition}) =>
      SiteResident(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        jobPosition: jobPosition ?? this.jobPosition,
      );
  @override
  String toString() {
    return (StringBuffer('SiteResident(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('jobPosition: $jobPosition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, jobPosition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiteResident &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.jobPosition == this.jobPosition);
}

class SiteResidentsCompanion extends UpdateCompanion<SiteResident> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> jobPosition;
  const SiteResidentsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.jobPosition = const Value.absent(),
  });
  SiteResidentsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    this.jobPosition = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName);
  static Insertable<SiteResident> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? jobPosition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (jobPosition != null) 'job_position': jobPosition,
    });
  }

  SiteResidentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? jobPosition}) {
    return SiteResidentsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobPosition: jobPosition ?? this.jobPosition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (jobPosition.present) {
      map['job_position'] = Variable<String>(jobPosition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiteResidentsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('jobPosition: $jobPosition')
          ..write(')'))
        .toString();
  }
}

class $BuildingSitesTable extends BuildingSites
    with TableInfo<$BuildingSitesTable, BuildingSite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildingSitesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _siteNameMeta =
      const VerificationMeta('siteName');
  @override
  late final GeneratedColumn<String> siteName = GeneratedColumn<String>(
      'site_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _siteResidentIdMeta =
      const VerificationMeta('siteResidentId');
  @override
  late final GeneratedColumn<int> siteResidentId = GeneratedColumn<int>(
      'site_resident_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES site_residents (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, siteName, customerId, siteResidentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'building_sites';
  @override
  VerificationContext validateIntegrity(Insertable<BuildingSite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('site_name')) {
      context.handle(_siteNameMeta,
          siteName.isAcceptableOrUnknown(data['site_name']!, _siteNameMeta));
    } else if (isInserting) {
      context.missing(_siteNameMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('site_resident_id')) {
      context.handle(
          _siteResidentIdMeta,
          siteResidentId.isAcceptableOrUnknown(
              data['site_resident_id']!, _siteResidentIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuildingSite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuildingSite(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      siteName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}site_name'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      siteResidentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}site_resident_id']),
    );
  }

  @override
  $BuildingSitesTable createAlias(String alias) {
    return $BuildingSitesTable(attachedDatabase, alias);
  }
}

class BuildingSite extends DataClass implements Insertable<BuildingSite> {
  final int id;
  final String siteName;
  final int customerId;
  final int? siteResidentId;
  const BuildingSite(
      {required this.id,
      required this.siteName,
      required this.customerId,
      this.siteResidentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['site_name'] = Variable<String>(siteName);
    map['customer_id'] = Variable<int>(customerId);
    if (!nullToAbsent || siteResidentId != null) {
      map['site_resident_id'] = Variable<int>(siteResidentId);
    }
    return map;
  }

  BuildingSitesCompanion toCompanion(bool nullToAbsent) {
    return BuildingSitesCompanion(
      id: Value(id),
      siteName: Value(siteName),
      customerId: Value(customerId),
      siteResidentId: siteResidentId == null && nullToAbsent
          ? const Value.absent()
          : Value(siteResidentId),
    );
  }

  factory BuildingSite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuildingSite(
      id: serializer.fromJson<int>(json['id']),
      siteName: serializer.fromJson<String>(json['siteName']),
      customerId: serializer.fromJson<int>(json['customerId']),
      siteResidentId: serializer.fromJson<int?>(json['siteResidentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteName': serializer.toJson<String>(siteName),
      'customerId': serializer.toJson<int>(customerId),
      'siteResidentId': serializer.toJson<int?>(siteResidentId),
    };
  }

  BuildingSite copyWith(
          {int? id,
          String? siteName,
          int? customerId,
          Value<int?> siteResidentId = const Value.absent()}) =>
      BuildingSite(
        id: id ?? this.id,
        siteName: siteName ?? this.siteName,
        customerId: customerId ?? this.customerId,
        siteResidentId:
            siteResidentId.present ? siteResidentId.value : this.siteResidentId,
      );
  @override
  String toString() {
    return (StringBuffer('BuildingSite(')
          ..write('id: $id, ')
          ..write('siteName: $siteName, ')
          ..write('customerId: $customerId, ')
          ..write('siteResidentId: $siteResidentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, siteName, customerId, siteResidentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuildingSite &&
          other.id == this.id &&
          other.siteName == this.siteName &&
          other.customerId == this.customerId &&
          other.siteResidentId == this.siteResidentId);
}

class BuildingSitesCompanion extends UpdateCompanion<BuildingSite> {
  final Value<int> id;
  final Value<String> siteName;
  final Value<int> customerId;
  final Value<int?> siteResidentId;
  const BuildingSitesCompanion({
    this.id = const Value.absent(),
    this.siteName = const Value.absent(),
    this.customerId = const Value.absent(),
    this.siteResidentId = const Value.absent(),
  });
  BuildingSitesCompanion.insert({
    this.id = const Value.absent(),
    required String siteName,
    required int customerId,
    this.siteResidentId = const Value.absent(),
  })  : siteName = Value(siteName),
        customerId = Value(customerId);
  static Insertable<BuildingSite> custom({
    Expression<int>? id,
    Expression<String>? siteName,
    Expression<int>? customerId,
    Expression<int>? siteResidentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteName != null) 'site_name': siteName,
      if (customerId != null) 'customer_id': customerId,
      if (siteResidentId != null) 'site_resident_id': siteResidentId,
    });
  }

  BuildingSitesCompanion copyWith(
      {Value<int>? id,
      Value<String>? siteName,
      Value<int>? customerId,
      Value<int?>? siteResidentId}) {
    return BuildingSitesCompanion(
      id: id ?? this.id,
      siteName: siteName ?? this.siteName,
      customerId: customerId ?? this.customerId,
      siteResidentId: siteResidentId ?? this.siteResidentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteName.present) {
      map['site_name'] = Variable<String>(siteName.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (siteResidentId.present) {
      map['site_resident_id'] = Variable<int>(siteResidentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildingSitesCompanion(')
          ..write('id: $id, ')
          ..write('siteName: $siteName, ')
          ..write('customerId: $customerId, ')
          ..write('siteResidentId: $siteResidentId')
          ..write(')'))
        .toString();
  }
}

class $ConcreteVolumetricWeightsTable extends ConcreteVolumetricWeights
    with TableInfo<$ConcreteVolumetricWeightsTable, ConcreteVolumetricWeight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConcreteVolumetricWeightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tareWeightGrMeta =
      const VerificationMeta('tareWeightGr');
  @override
  late final GeneratedColumn<double> tareWeightGr = GeneratedColumn<double>(
      'tare_weight_gr', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _materialTareWeightGrMeta =
      const VerificationMeta('materialTareWeightGr');
  @override
  late final GeneratedColumn<double> materialTareWeightGr =
      GeneratedColumn<double>('material_tare_weight_gr', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _materialWeightGrMeta =
      const VerificationMeta('materialWeightGr');
  @override
  late final GeneratedColumn<double> materialWeightGr = GeneratedColumn<double>(
      'material_weight_gr', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _tareVolumeCm3Meta =
      const VerificationMeta('tareVolumeCm3');
  @override
  late final GeneratedColumn<double> tareVolumeCm3 = GeneratedColumn<double>(
      'tare_volume_cm3', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _volumetricWeightGrCm3Meta =
      const VerificationMeta('volumetricWeightGrCm3');
  @override
  late final GeneratedColumn<double> volumetricWeightGrCm3 =
      GeneratedColumn<double>('volumetric_weight_gr_cm3', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _volumeLoadM3Meta =
      const VerificationMeta('volumeLoadM3');
  @override
  late final GeneratedColumn<double> volumeLoadM3 = GeneratedColumn<double>(
      'volume_load_m3', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _cementQuantityKgMeta =
      const VerificationMeta('cementQuantityKg');
  @override
  late final GeneratedColumn<double> cementQuantityKg = GeneratedColumn<double>(
      'cement_quantity_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _coarseAggregateKgMeta =
      const VerificationMeta('coarseAggregateKg');
  @override
  late final GeneratedColumn<double> coarseAggregateKg =
      GeneratedColumn<double>('coarse_aggregate_kg', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fineAggregateKgMeta =
      const VerificationMeta('fineAggregateKg');
  @override
  late final GeneratedColumn<double> fineAggregateKg = GeneratedColumn<double>(
      'fine_aggregate_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _waterKgMeta =
      const VerificationMeta('waterKg');
  @override
  late final GeneratedColumn<double> waterKg = GeneratedColumn<double>(
      'water_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _additivesMeta =
      const VerificationMeta('additives');
  @override
  late final GeneratedColumn<String> additives = GeneratedColumn<String>(
      'additives', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalLoadKgMeta =
      const VerificationMeta('totalLoadKg');
  @override
  late final GeneratedColumn<double> totalLoadKg = GeneratedColumn<double>(
      'total_load_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalLoadVolumetricWeightRelationMeta =
      const VerificationMeta('totalLoadVolumetricWeightRelation');
  @override
  late final GeneratedColumn<double> totalLoadVolumetricWeightRelation =
      GeneratedColumn<double>(
          'total_load_volumetric_weight_relation', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
      'percentage', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tareWeightGr,
        materialTareWeightGr,
        materialWeightGr,
        tareVolumeCm3,
        volumetricWeightGrCm3,
        volumeLoadM3,
        cementQuantityKg,
        coarseAggregateKg,
        fineAggregateKg,
        waterKg,
        additives,
        totalLoadKg,
        totalLoadVolumetricWeightRelation,
        percentage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'concrete_volumetric_weights';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConcreteVolumetricWeight> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tare_weight_gr')) {
      context.handle(
          _tareWeightGrMeta,
          tareWeightGr.isAcceptableOrUnknown(
              data['tare_weight_gr']!, _tareWeightGrMeta));
    } else if (isInserting) {
      context.missing(_tareWeightGrMeta);
    }
    if (data.containsKey('material_tare_weight_gr')) {
      context.handle(
          _materialTareWeightGrMeta,
          materialTareWeightGr.isAcceptableOrUnknown(
              data['material_tare_weight_gr']!, _materialTareWeightGrMeta));
    } else if (isInserting) {
      context.missing(_materialTareWeightGrMeta);
    }
    if (data.containsKey('material_weight_gr')) {
      context.handle(
          _materialWeightGrMeta,
          materialWeightGr.isAcceptableOrUnknown(
              data['material_weight_gr']!, _materialWeightGrMeta));
    } else if (isInserting) {
      context.missing(_materialWeightGrMeta);
    }
    if (data.containsKey('tare_volume_cm3')) {
      context.handle(
          _tareVolumeCm3Meta,
          tareVolumeCm3.isAcceptableOrUnknown(
              data['tare_volume_cm3']!, _tareVolumeCm3Meta));
    } else if (isInserting) {
      context.missing(_tareVolumeCm3Meta);
    }
    if (data.containsKey('volumetric_weight_gr_cm3')) {
      context.handle(
          _volumetricWeightGrCm3Meta,
          volumetricWeightGrCm3.isAcceptableOrUnknown(
              data['volumetric_weight_gr_cm3']!, _volumetricWeightGrCm3Meta));
    } else if (isInserting) {
      context.missing(_volumetricWeightGrCm3Meta);
    }
    if (data.containsKey('volume_load_m3')) {
      context.handle(
          _volumeLoadM3Meta,
          volumeLoadM3.isAcceptableOrUnknown(
              data['volume_load_m3']!, _volumeLoadM3Meta));
    } else if (isInserting) {
      context.missing(_volumeLoadM3Meta);
    }
    if (data.containsKey('cement_quantity_kg')) {
      context.handle(
          _cementQuantityKgMeta,
          cementQuantityKg.isAcceptableOrUnknown(
              data['cement_quantity_kg']!, _cementQuantityKgMeta));
    } else if (isInserting) {
      context.missing(_cementQuantityKgMeta);
    }
    if (data.containsKey('coarse_aggregate_kg')) {
      context.handle(
          _coarseAggregateKgMeta,
          coarseAggregateKg.isAcceptableOrUnknown(
              data['coarse_aggregate_kg']!, _coarseAggregateKgMeta));
    } else if (isInserting) {
      context.missing(_coarseAggregateKgMeta);
    }
    if (data.containsKey('fine_aggregate_kg')) {
      context.handle(
          _fineAggregateKgMeta,
          fineAggregateKg.isAcceptableOrUnknown(
              data['fine_aggregate_kg']!, _fineAggregateKgMeta));
    } else if (isInserting) {
      context.missing(_fineAggregateKgMeta);
    }
    if (data.containsKey('water_kg')) {
      context.handle(_waterKgMeta,
          waterKg.isAcceptableOrUnknown(data['water_kg']!, _waterKgMeta));
    } else if (isInserting) {
      context.missing(_waterKgMeta);
    }
    if (data.containsKey('additives')) {
      context.handle(_additivesMeta,
          additives.isAcceptableOrUnknown(data['additives']!, _additivesMeta));
    }
    if (data.containsKey('total_load_kg')) {
      context.handle(
          _totalLoadKgMeta,
          totalLoadKg.isAcceptableOrUnknown(
              data['total_load_kg']!, _totalLoadKgMeta));
    } else if (isInserting) {
      context.missing(_totalLoadKgMeta);
    }
    if (data.containsKey('total_load_volumetric_weight_relation')) {
      context.handle(
          _totalLoadVolumetricWeightRelationMeta,
          totalLoadVolumetricWeightRelation.isAcceptableOrUnknown(
              data['total_load_volumetric_weight_relation']!,
              _totalLoadVolumetricWeightRelationMeta));
    } else if (isInserting) {
      context.missing(_totalLoadVolumetricWeightRelationMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConcreteVolumetricWeight map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConcreteVolumetricWeight(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tareWeightGr: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tare_weight_gr'])!,
      materialTareWeightGr: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}material_tare_weight_gr'])!,
      materialWeightGr: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}material_weight_gr'])!,
      tareVolumeCm3: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tare_volume_cm3'])!,
      volumetricWeightGrCm3: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}volumetric_weight_gr_cm3'])!,
      volumeLoadM3: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}volume_load_m3'])!,
      cementQuantityKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}cement_quantity_kg'])!,
      coarseAggregateKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}coarse_aggregate_kg'])!,
      fineAggregateKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}fine_aggregate_kg'])!,
      waterKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}water_kg'])!,
      additives: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}additives']),
      totalLoadKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_load_kg'])!,
      totalLoadVolumetricWeightRelation: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}total_load_volumetric_weight_relation'])!,
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}percentage'])!,
    );
  }

  @override
  $ConcreteVolumetricWeightsTable createAlias(String alias) {
    return $ConcreteVolumetricWeightsTable(attachedDatabase, alias);
  }
}

class ConcreteVolumetricWeight extends DataClass
    implements Insertable<ConcreteVolumetricWeight> {
  final int id;
  final double tareWeightGr;
  final double materialTareWeightGr;
  final double materialWeightGr;
  final double tareVolumeCm3;
  final double volumetricWeightGrCm3;
  final double volumeLoadM3;
  final double cementQuantityKg;
  final double coarseAggregateKg;
  final double fineAggregateKg;
  final double waterKg;
  final String? additives;
  final double totalLoadKg;
  final double totalLoadVolumetricWeightRelation;
  final double percentage;
  const ConcreteVolumetricWeight(
      {required this.id,
      required this.tareWeightGr,
      required this.materialTareWeightGr,
      required this.materialWeightGr,
      required this.tareVolumeCm3,
      required this.volumetricWeightGrCm3,
      required this.volumeLoadM3,
      required this.cementQuantityKg,
      required this.coarseAggregateKg,
      required this.fineAggregateKg,
      required this.waterKg,
      this.additives,
      required this.totalLoadKg,
      required this.totalLoadVolumetricWeightRelation,
      required this.percentage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tare_weight_gr'] = Variable<double>(tareWeightGr);
    map['material_tare_weight_gr'] = Variable<double>(materialTareWeightGr);
    map['material_weight_gr'] = Variable<double>(materialWeightGr);
    map['tare_volume_cm3'] = Variable<double>(tareVolumeCm3);
    map['volumetric_weight_gr_cm3'] = Variable<double>(volumetricWeightGrCm3);
    map['volume_load_m3'] = Variable<double>(volumeLoadM3);
    map['cement_quantity_kg'] = Variable<double>(cementQuantityKg);
    map['coarse_aggregate_kg'] = Variable<double>(coarseAggregateKg);
    map['fine_aggregate_kg'] = Variable<double>(fineAggregateKg);
    map['water_kg'] = Variable<double>(waterKg);
    if (!nullToAbsent || additives != null) {
      map['additives'] = Variable<String>(additives);
    }
    map['total_load_kg'] = Variable<double>(totalLoadKg);
    map['total_load_volumetric_weight_relation'] =
        Variable<double>(totalLoadVolumetricWeightRelation);
    map['percentage'] = Variable<double>(percentage);
    return map;
  }

  ConcreteVolumetricWeightsCompanion toCompanion(bool nullToAbsent) {
    return ConcreteVolumetricWeightsCompanion(
      id: Value(id),
      tareWeightGr: Value(tareWeightGr),
      materialTareWeightGr: Value(materialTareWeightGr),
      materialWeightGr: Value(materialWeightGr),
      tareVolumeCm3: Value(tareVolumeCm3),
      volumetricWeightGrCm3: Value(volumetricWeightGrCm3),
      volumeLoadM3: Value(volumeLoadM3),
      cementQuantityKg: Value(cementQuantityKg),
      coarseAggregateKg: Value(coarseAggregateKg),
      fineAggregateKg: Value(fineAggregateKg),
      waterKg: Value(waterKg),
      additives: additives == null && nullToAbsent
          ? const Value.absent()
          : Value(additives),
      totalLoadKg: Value(totalLoadKg),
      totalLoadVolumetricWeightRelation:
          Value(totalLoadVolumetricWeightRelation),
      percentage: Value(percentage),
    );
  }

  factory ConcreteVolumetricWeight.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConcreteVolumetricWeight(
      id: serializer.fromJson<int>(json['id']),
      tareWeightGr: serializer.fromJson<double>(json['tareWeightGr']),
      materialTareWeightGr:
          serializer.fromJson<double>(json['materialTareWeightGr']),
      materialWeightGr: serializer.fromJson<double>(json['materialWeightGr']),
      tareVolumeCm3: serializer.fromJson<double>(json['tareVolumeCm3']),
      volumetricWeightGrCm3:
          serializer.fromJson<double>(json['volumetricWeightGrCm3']),
      volumeLoadM3: serializer.fromJson<double>(json['volumeLoadM3']),
      cementQuantityKg: serializer.fromJson<double>(json['cementQuantityKg']),
      coarseAggregateKg: serializer.fromJson<double>(json['coarseAggregateKg']),
      fineAggregateKg: serializer.fromJson<double>(json['fineAggregateKg']),
      waterKg: serializer.fromJson<double>(json['waterKg']),
      additives: serializer.fromJson<String?>(json['additives']),
      totalLoadKg: serializer.fromJson<double>(json['totalLoadKg']),
      totalLoadVolumetricWeightRelation: serializer
          .fromJson<double>(json['totalLoadVolumetricWeightRelation']),
      percentage: serializer.fromJson<double>(json['percentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tareWeightGr': serializer.toJson<double>(tareWeightGr),
      'materialTareWeightGr': serializer.toJson<double>(materialTareWeightGr),
      'materialWeightGr': serializer.toJson<double>(materialWeightGr),
      'tareVolumeCm3': serializer.toJson<double>(tareVolumeCm3),
      'volumetricWeightGrCm3': serializer.toJson<double>(volumetricWeightGrCm3),
      'volumeLoadM3': serializer.toJson<double>(volumeLoadM3),
      'cementQuantityKg': serializer.toJson<double>(cementQuantityKg),
      'coarseAggregateKg': serializer.toJson<double>(coarseAggregateKg),
      'fineAggregateKg': serializer.toJson<double>(fineAggregateKg),
      'waterKg': serializer.toJson<double>(waterKg),
      'additives': serializer.toJson<String?>(additives),
      'totalLoadKg': serializer.toJson<double>(totalLoadKg),
      'totalLoadVolumetricWeightRelation':
          serializer.toJson<double>(totalLoadVolumetricWeightRelation),
      'percentage': serializer.toJson<double>(percentage),
    };
  }

  ConcreteVolumetricWeight copyWith(
          {int? id,
          double? tareWeightGr,
          double? materialTareWeightGr,
          double? materialWeightGr,
          double? tareVolumeCm3,
          double? volumetricWeightGrCm3,
          double? volumeLoadM3,
          double? cementQuantityKg,
          double? coarseAggregateKg,
          double? fineAggregateKg,
          double? waterKg,
          Value<String?> additives = const Value.absent(),
          double? totalLoadKg,
          double? totalLoadVolumetricWeightRelation,
          double? percentage}) =>
      ConcreteVolumetricWeight(
        id: id ?? this.id,
        tareWeightGr: tareWeightGr ?? this.tareWeightGr,
        materialTareWeightGr: materialTareWeightGr ?? this.materialTareWeightGr,
        materialWeightGr: materialWeightGr ?? this.materialWeightGr,
        tareVolumeCm3: tareVolumeCm3 ?? this.tareVolumeCm3,
        volumetricWeightGrCm3:
            volumetricWeightGrCm3 ?? this.volumetricWeightGrCm3,
        volumeLoadM3: volumeLoadM3 ?? this.volumeLoadM3,
        cementQuantityKg: cementQuantityKg ?? this.cementQuantityKg,
        coarseAggregateKg: coarseAggregateKg ?? this.coarseAggregateKg,
        fineAggregateKg: fineAggregateKg ?? this.fineAggregateKg,
        waterKg: waterKg ?? this.waterKg,
        additives: additives.present ? additives.value : this.additives,
        totalLoadKg: totalLoadKg ?? this.totalLoadKg,
        totalLoadVolumetricWeightRelation: totalLoadVolumetricWeightRelation ??
            this.totalLoadVolumetricWeightRelation,
        percentage: percentage ?? this.percentage,
      );
  @override
  String toString() {
    return (StringBuffer('ConcreteVolumetricWeight(')
          ..write('id: $id, ')
          ..write('tareWeightGr: $tareWeightGr, ')
          ..write('materialTareWeightGr: $materialTareWeightGr, ')
          ..write('materialWeightGr: $materialWeightGr, ')
          ..write('tareVolumeCm3: $tareVolumeCm3, ')
          ..write('volumetricWeightGrCm3: $volumetricWeightGrCm3, ')
          ..write('volumeLoadM3: $volumeLoadM3, ')
          ..write('cementQuantityKg: $cementQuantityKg, ')
          ..write('coarseAggregateKg: $coarseAggregateKg, ')
          ..write('fineAggregateKg: $fineAggregateKg, ')
          ..write('waterKg: $waterKg, ')
          ..write('additives: $additives, ')
          ..write('totalLoadKg: $totalLoadKg, ')
          ..write(
              'totalLoadVolumetricWeightRelation: $totalLoadVolumetricWeightRelation, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tareWeightGr,
      materialTareWeightGr,
      materialWeightGr,
      tareVolumeCm3,
      volumetricWeightGrCm3,
      volumeLoadM3,
      cementQuantityKg,
      coarseAggregateKg,
      fineAggregateKg,
      waterKg,
      additives,
      totalLoadKg,
      totalLoadVolumetricWeightRelation,
      percentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConcreteVolumetricWeight &&
          other.id == this.id &&
          other.tareWeightGr == this.tareWeightGr &&
          other.materialTareWeightGr == this.materialTareWeightGr &&
          other.materialWeightGr == this.materialWeightGr &&
          other.tareVolumeCm3 == this.tareVolumeCm3 &&
          other.volumetricWeightGrCm3 == this.volumetricWeightGrCm3 &&
          other.volumeLoadM3 == this.volumeLoadM3 &&
          other.cementQuantityKg == this.cementQuantityKg &&
          other.coarseAggregateKg == this.coarseAggregateKg &&
          other.fineAggregateKg == this.fineAggregateKg &&
          other.waterKg == this.waterKg &&
          other.additives == this.additives &&
          other.totalLoadKg == this.totalLoadKg &&
          other.totalLoadVolumetricWeightRelation ==
              this.totalLoadVolumetricWeightRelation &&
          other.percentage == this.percentage);
}

class ConcreteVolumetricWeightsCompanion
    extends UpdateCompanion<ConcreteVolumetricWeight> {
  final Value<int> id;
  final Value<double> tareWeightGr;
  final Value<double> materialTareWeightGr;
  final Value<double> materialWeightGr;
  final Value<double> tareVolumeCm3;
  final Value<double> volumetricWeightGrCm3;
  final Value<double> volumeLoadM3;
  final Value<double> cementQuantityKg;
  final Value<double> coarseAggregateKg;
  final Value<double> fineAggregateKg;
  final Value<double> waterKg;
  final Value<String?> additives;
  final Value<double> totalLoadKg;
  final Value<double> totalLoadVolumetricWeightRelation;
  final Value<double> percentage;
  const ConcreteVolumetricWeightsCompanion({
    this.id = const Value.absent(),
    this.tareWeightGr = const Value.absent(),
    this.materialTareWeightGr = const Value.absent(),
    this.materialWeightGr = const Value.absent(),
    this.tareVolumeCm3 = const Value.absent(),
    this.volumetricWeightGrCm3 = const Value.absent(),
    this.volumeLoadM3 = const Value.absent(),
    this.cementQuantityKg = const Value.absent(),
    this.coarseAggregateKg = const Value.absent(),
    this.fineAggregateKg = const Value.absent(),
    this.waterKg = const Value.absent(),
    this.additives = const Value.absent(),
    this.totalLoadKg = const Value.absent(),
    this.totalLoadVolumetricWeightRelation = const Value.absent(),
    this.percentage = const Value.absent(),
  });
  ConcreteVolumetricWeightsCompanion.insert({
    this.id = const Value.absent(),
    required double tareWeightGr,
    required double materialTareWeightGr,
    required double materialWeightGr,
    required double tareVolumeCm3,
    required double volumetricWeightGrCm3,
    required double volumeLoadM3,
    required double cementQuantityKg,
    required double coarseAggregateKg,
    required double fineAggregateKg,
    required double waterKg,
    this.additives = const Value.absent(),
    required double totalLoadKg,
    required double totalLoadVolumetricWeightRelation,
    required double percentage,
  })  : tareWeightGr = Value(tareWeightGr),
        materialTareWeightGr = Value(materialTareWeightGr),
        materialWeightGr = Value(materialWeightGr),
        tareVolumeCm3 = Value(tareVolumeCm3),
        volumetricWeightGrCm3 = Value(volumetricWeightGrCm3),
        volumeLoadM3 = Value(volumeLoadM3),
        cementQuantityKg = Value(cementQuantityKg),
        coarseAggregateKg = Value(coarseAggregateKg),
        fineAggregateKg = Value(fineAggregateKg),
        waterKg = Value(waterKg),
        totalLoadKg = Value(totalLoadKg),
        totalLoadVolumetricWeightRelation =
            Value(totalLoadVolumetricWeightRelation),
        percentage = Value(percentage);
  static Insertable<ConcreteVolumetricWeight> custom({
    Expression<int>? id,
    Expression<double>? tareWeightGr,
    Expression<double>? materialTareWeightGr,
    Expression<double>? materialWeightGr,
    Expression<double>? tareVolumeCm3,
    Expression<double>? volumetricWeightGrCm3,
    Expression<double>? volumeLoadM3,
    Expression<double>? cementQuantityKg,
    Expression<double>? coarseAggregateKg,
    Expression<double>? fineAggregateKg,
    Expression<double>? waterKg,
    Expression<String>? additives,
    Expression<double>? totalLoadKg,
    Expression<double>? totalLoadVolumetricWeightRelation,
    Expression<double>? percentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tareWeightGr != null) 'tare_weight_gr': tareWeightGr,
      if (materialTareWeightGr != null)
        'material_tare_weight_gr': materialTareWeightGr,
      if (materialWeightGr != null) 'material_weight_gr': materialWeightGr,
      if (tareVolumeCm3 != null) 'tare_volume_cm3': tareVolumeCm3,
      if (volumetricWeightGrCm3 != null)
        'volumetric_weight_gr_cm3': volumetricWeightGrCm3,
      if (volumeLoadM3 != null) 'volume_load_m3': volumeLoadM3,
      if (cementQuantityKg != null) 'cement_quantity_kg': cementQuantityKg,
      if (coarseAggregateKg != null) 'coarse_aggregate_kg': coarseAggregateKg,
      if (fineAggregateKg != null) 'fine_aggregate_kg': fineAggregateKg,
      if (waterKg != null) 'water_kg': waterKg,
      if (additives != null) 'additives': additives,
      if (totalLoadKg != null) 'total_load_kg': totalLoadKg,
      if (totalLoadVolumetricWeightRelation != null)
        'total_load_volumetric_weight_relation':
            totalLoadVolumetricWeightRelation,
      if (percentage != null) 'percentage': percentage,
    });
  }

  ConcreteVolumetricWeightsCompanion copyWith(
      {Value<int>? id,
      Value<double>? tareWeightGr,
      Value<double>? materialTareWeightGr,
      Value<double>? materialWeightGr,
      Value<double>? tareVolumeCm3,
      Value<double>? volumetricWeightGrCm3,
      Value<double>? volumeLoadM3,
      Value<double>? cementQuantityKg,
      Value<double>? coarseAggregateKg,
      Value<double>? fineAggregateKg,
      Value<double>? waterKg,
      Value<String?>? additives,
      Value<double>? totalLoadKg,
      Value<double>? totalLoadVolumetricWeightRelation,
      Value<double>? percentage}) {
    return ConcreteVolumetricWeightsCompanion(
      id: id ?? this.id,
      tareWeightGr: tareWeightGr ?? this.tareWeightGr,
      materialTareWeightGr: materialTareWeightGr ?? this.materialTareWeightGr,
      materialWeightGr: materialWeightGr ?? this.materialWeightGr,
      tareVolumeCm3: tareVolumeCm3 ?? this.tareVolumeCm3,
      volumetricWeightGrCm3:
          volumetricWeightGrCm3 ?? this.volumetricWeightGrCm3,
      volumeLoadM3: volumeLoadM3 ?? this.volumeLoadM3,
      cementQuantityKg: cementQuantityKg ?? this.cementQuantityKg,
      coarseAggregateKg: coarseAggregateKg ?? this.coarseAggregateKg,
      fineAggregateKg: fineAggregateKg ?? this.fineAggregateKg,
      waterKg: waterKg ?? this.waterKg,
      additives: additives ?? this.additives,
      totalLoadKg: totalLoadKg ?? this.totalLoadKg,
      totalLoadVolumetricWeightRelation: totalLoadVolumetricWeightRelation ??
          this.totalLoadVolumetricWeightRelation,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tareWeightGr.present) {
      map['tare_weight_gr'] = Variable<double>(tareWeightGr.value);
    }
    if (materialTareWeightGr.present) {
      map['material_tare_weight_gr'] =
          Variable<double>(materialTareWeightGr.value);
    }
    if (materialWeightGr.present) {
      map['material_weight_gr'] = Variable<double>(materialWeightGr.value);
    }
    if (tareVolumeCm3.present) {
      map['tare_volume_cm3'] = Variable<double>(tareVolumeCm3.value);
    }
    if (volumetricWeightGrCm3.present) {
      map['volumetric_weight_gr_cm3'] =
          Variable<double>(volumetricWeightGrCm3.value);
    }
    if (volumeLoadM3.present) {
      map['volume_load_m3'] = Variable<double>(volumeLoadM3.value);
    }
    if (cementQuantityKg.present) {
      map['cement_quantity_kg'] = Variable<double>(cementQuantityKg.value);
    }
    if (coarseAggregateKg.present) {
      map['coarse_aggregate_kg'] = Variable<double>(coarseAggregateKg.value);
    }
    if (fineAggregateKg.present) {
      map['fine_aggregate_kg'] = Variable<double>(fineAggregateKg.value);
    }
    if (waterKg.present) {
      map['water_kg'] = Variable<double>(waterKg.value);
    }
    if (additives.present) {
      map['additives'] = Variable<String>(additives.value);
    }
    if (totalLoadKg.present) {
      map['total_load_kg'] = Variable<double>(totalLoadKg.value);
    }
    if (totalLoadVolumetricWeightRelation.present) {
      map['total_load_volumetric_weight_relation'] =
          Variable<double>(totalLoadVolumetricWeightRelation.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConcreteVolumetricWeightsCompanion(')
          ..write('id: $id, ')
          ..write('tareWeightGr: $tareWeightGr, ')
          ..write('materialTareWeightGr: $materialTareWeightGr, ')
          ..write('materialWeightGr: $materialWeightGr, ')
          ..write('tareVolumeCm3: $tareVolumeCm3, ')
          ..write('volumetricWeightGrCm3: $volumetricWeightGrCm3, ')
          ..write('volumeLoadM3: $volumeLoadM3, ')
          ..write('cementQuantityKg: $cementQuantityKg, ')
          ..write('coarseAggregateKg: $coarseAggregateKg, ')
          ..write('fineAggregateKg: $fineAggregateKg, ')
          ..write('waterKg: $waterKg, ')
          ..write('additives: $additives, ')
          ..write('totalLoadKg: $totalLoadKg, ')
          ..write(
              'totalLoadVolumetricWeightRelation: $totalLoadVolumetricWeightRelation, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }
}

class $ConcreteTestingOrdersTable extends ConcreteTestingOrders
    with TableInfo<$ConcreteTestingOrdersTable, ConcreteTestingOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConcreteTestingOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _designResistanceMeta =
      const VerificationMeta('designResistance');
  @override
  late final GeneratedColumn<String> designResistance = GeneratedColumn<String>(
      'design_resistance', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _slumpingCmMeta =
      const VerificationMeta('slumpingCm');
  @override
  late final GeneratedColumn<int> slumpingCm = GeneratedColumn<int>(
      'slumping_cm', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalVolumeM3Meta =
      const VerificationMeta('totalVolumeM3');
  @override
  late final GeneratedColumn<int> totalVolumeM3 = GeneratedColumn<int>(
      'total_volume_m3', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tmaMmMeta = const VerificationMeta('tmaMm');
  @override
  late final GeneratedColumn<int> tmaMm = GeneratedColumn<int>(
      'tma_mm', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _designAgeMeta =
      const VerificationMeta('designAge');
  @override
  late final GeneratedColumn<String> designAge = GeneratedColumn<String>(
      'design_age', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _testingDateMeta =
      const VerificationMeta('testingDate');
  @override
  late final GeneratedColumn<DateTime> testingDate = GeneratedColumn<DateTime>(
      'testing_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _buildingSiteIdMeta =
      const VerificationMeta('buildingSiteId');
  @override
  late final GeneratedColumn<int> buildingSiteId = GeneratedColumn<int>(
      'building_site_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES building_sites (id)'));
  static const VerificationMeta _siteResidentIdMeta =
      const VerificationMeta('siteResidentId');
  @override
  late final GeneratedColumn<int> siteResidentId = GeneratedColumn<int>(
      'site_resident_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES site_residents (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        designResistance,
        slumpingCm,
        totalVolumeM3,
        tmaMm,
        designAge,
        testingDate,
        customerId,
        buildingSiteId,
        siteResidentId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'concrete_testing_orders';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConcreteTestingOrder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('design_resistance')) {
      context.handle(
          _designResistanceMeta,
          designResistance.isAcceptableOrUnknown(
              data['design_resistance']!, _designResistanceMeta));
    } else if (isInserting) {
      context.missing(_designResistanceMeta);
    }
    if (data.containsKey('slumping_cm')) {
      context.handle(
          _slumpingCmMeta,
          slumpingCm.isAcceptableOrUnknown(
              data['slumping_cm']!, _slumpingCmMeta));
    } else if (isInserting) {
      context.missing(_slumpingCmMeta);
    }
    if (data.containsKey('total_volume_m3')) {
      context.handle(
          _totalVolumeM3Meta,
          totalVolumeM3.isAcceptableOrUnknown(
              data['total_volume_m3']!, _totalVolumeM3Meta));
    } else if (isInserting) {
      context.missing(_totalVolumeM3Meta);
    }
    if (data.containsKey('tma_mm')) {
      context.handle(
          _tmaMmMeta, tmaMm.isAcceptableOrUnknown(data['tma_mm']!, _tmaMmMeta));
    } else if (isInserting) {
      context.missing(_tmaMmMeta);
    }
    if (data.containsKey('design_age')) {
      context.handle(_designAgeMeta,
          designAge.isAcceptableOrUnknown(data['design_age']!, _designAgeMeta));
    } else if (isInserting) {
      context.missing(_designAgeMeta);
    }
    if (data.containsKey('testing_date')) {
      context.handle(
          _testingDateMeta,
          testingDate.isAcceptableOrUnknown(
              data['testing_date']!, _testingDateMeta));
    } else if (isInserting) {
      context.missing(_testingDateMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('building_site_id')) {
      context.handle(
          _buildingSiteIdMeta,
          buildingSiteId.isAcceptableOrUnknown(
              data['building_site_id']!, _buildingSiteIdMeta));
    } else if (isInserting) {
      context.missing(_buildingSiteIdMeta);
    }
    if (data.containsKey('site_resident_id')) {
      context.handle(
          _siteResidentIdMeta,
          siteResidentId.isAcceptableOrUnknown(
              data['site_resident_id']!, _siteResidentIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConcreteTestingOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConcreteTestingOrder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      designResistance: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}design_resistance'])!,
      slumpingCm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}slumping_cm'])!,
      totalVolumeM3: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_volume_m3'])!,
      tmaMm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tma_mm'])!,
      designAge: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}design_age'])!,
      testingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}testing_date'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      buildingSiteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}building_site_id'])!,
      siteResidentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}site_resident_id']),
    );
  }

  @override
  $ConcreteTestingOrdersTable createAlias(String alias) {
    return $ConcreteTestingOrdersTable(attachedDatabase, alias);
  }
}

class ConcreteTestingOrder extends DataClass
    implements Insertable<ConcreteTestingOrder> {
  final int id;
  final String designResistance;
  final int slumpingCm;
  final int totalVolumeM3;
  final int tmaMm;
  final String designAge;
  final DateTime testingDate;
  final int customerId;
  final int buildingSiteId;
  final int? siteResidentId;
  const ConcreteTestingOrder(
      {required this.id,
      required this.designResistance,
      required this.slumpingCm,
      required this.totalVolumeM3,
      required this.tmaMm,
      required this.designAge,
      required this.testingDate,
      required this.customerId,
      required this.buildingSiteId,
      this.siteResidentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['design_resistance'] = Variable<String>(designResistance);
    map['slumping_cm'] = Variable<int>(slumpingCm);
    map['total_volume_m3'] = Variable<int>(totalVolumeM3);
    map['tma_mm'] = Variable<int>(tmaMm);
    map['design_age'] = Variable<String>(designAge);
    map['testing_date'] = Variable<DateTime>(testingDate);
    map['customer_id'] = Variable<int>(customerId);
    map['building_site_id'] = Variable<int>(buildingSiteId);
    if (!nullToAbsent || siteResidentId != null) {
      map['site_resident_id'] = Variable<int>(siteResidentId);
    }
    return map;
  }

  ConcreteTestingOrdersCompanion toCompanion(bool nullToAbsent) {
    return ConcreteTestingOrdersCompanion(
      id: Value(id),
      designResistance: Value(designResistance),
      slumpingCm: Value(slumpingCm),
      totalVolumeM3: Value(totalVolumeM3),
      tmaMm: Value(tmaMm),
      designAge: Value(designAge),
      testingDate: Value(testingDate),
      customerId: Value(customerId),
      buildingSiteId: Value(buildingSiteId),
      siteResidentId: siteResidentId == null && nullToAbsent
          ? const Value.absent()
          : Value(siteResidentId),
    );
  }

  factory ConcreteTestingOrder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConcreteTestingOrder(
      id: serializer.fromJson<int>(json['id']),
      designResistance: serializer.fromJson<String>(json['designResistance']),
      slumpingCm: serializer.fromJson<int>(json['slumpingCm']),
      totalVolumeM3: serializer.fromJson<int>(json['totalVolumeM3']),
      tmaMm: serializer.fromJson<int>(json['tmaMm']),
      designAge: serializer.fromJson<String>(json['designAge']),
      testingDate: serializer.fromJson<DateTime>(json['testingDate']),
      customerId: serializer.fromJson<int>(json['customerId']),
      buildingSiteId: serializer.fromJson<int>(json['buildingSiteId']),
      siteResidentId: serializer.fromJson<int?>(json['siteResidentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'designResistance': serializer.toJson<String>(designResistance),
      'slumpingCm': serializer.toJson<int>(slumpingCm),
      'totalVolumeM3': serializer.toJson<int>(totalVolumeM3),
      'tmaMm': serializer.toJson<int>(tmaMm),
      'designAge': serializer.toJson<String>(designAge),
      'testingDate': serializer.toJson<DateTime>(testingDate),
      'customerId': serializer.toJson<int>(customerId),
      'buildingSiteId': serializer.toJson<int>(buildingSiteId),
      'siteResidentId': serializer.toJson<int?>(siteResidentId),
    };
  }

  ConcreteTestingOrder copyWith(
          {int? id,
          String? designResistance,
          int? slumpingCm,
          int? totalVolumeM3,
          int? tmaMm,
          String? designAge,
          DateTime? testingDate,
          int? customerId,
          int? buildingSiteId,
          Value<int?> siteResidentId = const Value.absent()}) =>
      ConcreteTestingOrder(
        id: id ?? this.id,
        designResistance: designResistance ?? this.designResistance,
        slumpingCm: slumpingCm ?? this.slumpingCm,
        totalVolumeM3: totalVolumeM3 ?? this.totalVolumeM3,
        tmaMm: tmaMm ?? this.tmaMm,
        designAge: designAge ?? this.designAge,
        testingDate: testingDate ?? this.testingDate,
        customerId: customerId ?? this.customerId,
        buildingSiteId: buildingSiteId ?? this.buildingSiteId,
        siteResidentId:
            siteResidentId.present ? siteResidentId.value : this.siteResidentId,
      );
  @override
  String toString() {
    return (StringBuffer('ConcreteTestingOrder(')
          ..write('id: $id, ')
          ..write('designResistance: $designResistance, ')
          ..write('slumpingCm: $slumpingCm, ')
          ..write('totalVolumeM3: $totalVolumeM3, ')
          ..write('tmaMm: $tmaMm, ')
          ..write('designAge: $designAge, ')
          ..write('testingDate: $testingDate, ')
          ..write('customerId: $customerId, ')
          ..write('buildingSiteId: $buildingSiteId, ')
          ..write('siteResidentId: $siteResidentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      designResistance,
      slumpingCm,
      totalVolumeM3,
      tmaMm,
      designAge,
      testingDate,
      customerId,
      buildingSiteId,
      siteResidentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConcreteTestingOrder &&
          other.id == this.id &&
          other.designResistance == this.designResistance &&
          other.slumpingCm == this.slumpingCm &&
          other.totalVolumeM3 == this.totalVolumeM3 &&
          other.tmaMm == this.tmaMm &&
          other.designAge == this.designAge &&
          other.testingDate == this.testingDate &&
          other.customerId == this.customerId &&
          other.buildingSiteId == this.buildingSiteId &&
          other.siteResidentId == this.siteResidentId);
}

class ConcreteTestingOrdersCompanion
    extends UpdateCompanion<ConcreteTestingOrder> {
  final Value<int> id;
  final Value<String> designResistance;
  final Value<int> slumpingCm;
  final Value<int> totalVolumeM3;
  final Value<int> tmaMm;
  final Value<String> designAge;
  final Value<DateTime> testingDate;
  final Value<int> customerId;
  final Value<int> buildingSiteId;
  final Value<int?> siteResidentId;
  const ConcreteTestingOrdersCompanion({
    this.id = const Value.absent(),
    this.designResistance = const Value.absent(),
    this.slumpingCm = const Value.absent(),
    this.totalVolumeM3 = const Value.absent(),
    this.tmaMm = const Value.absent(),
    this.designAge = const Value.absent(),
    this.testingDate = const Value.absent(),
    this.customerId = const Value.absent(),
    this.buildingSiteId = const Value.absent(),
    this.siteResidentId = const Value.absent(),
  });
  ConcreteTestingOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String designResistance,
    required int slumpingCm,
    required int totalVolumeM3,
    required int tmaMm,
    required String designAge,
    required DateTime testingDate,
    required int customerId,
    required int buildingSiteId,
    this.siteResidentId = const Value.absent(),
  })  : designResistance = Value(designResistance),
        slumpingCm = Value(slumpingCm),
        totalVolumeM3 = Value(totalVolumeM3),
        tmaMm = Value(tmaMm),
        designAge = Value(designAge),
        testingDate = Value(testingDate),
        customerId = Value(customerId),
        buildingSiteId = Value(buildingSiteId);
  static Insertable<ConcreteTestingOrder> custom({
    Expression<int>? id,
    Expression<String>? designResistance,
    Expression<int>? slumpingCm,
    Expression<int>? totalVolumeM3,
    Expression<int>? tmaMm,
    Expression<String>? designAge,
    Expression<DateTime>? testingDate,
    Expression<int>? customerId,
    Expression<int>? buildingSiteId,
    Expression<int>? siteResidentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (designResistance != null) 'design_resistance': designResistance,
      if (slumpingCm != null) 'slumping_cm': slumpingCm,
      if (totalVolumeM3 != null) 'total_volume_m3': totalVolumeM3,
      if (tmaMm != null) 'tma_mm': tmaMm,
      if (designAge != null) 'design_age': designAge,
      if (testingDate != null) 'testing_date': testingDate,
      if (customerId != null) 'customer_id': customerId,
      if (buildingSiteId != null) 'building_site_id': buildingSiteId,
      if (siteResidentId != null) 'site_resident_id': siteResidentId,
    });
  }

  ConcreteTestingOrdersCompanion copyWith(
      {Value<int>? id,
      Value<String>? designResistance,
      Value<int>? slumpingCm,
      Value<int>? totalVolumeM3,
      Value<int>? tmaMm,
      Value<String>? designAge,
      Value<DateTime>? testingDate,
      Value<int>? customerId,
      Value<int>? buildingSiteId,
      Value<int?>? siteResidentId}) {
    return ConcreteTestingOrdersCompanion(
      id: id ?? this.id,
      designResistance: designResistance ?? this.designResistance,
      slumpingCm: slumpingCm ?? this.slumpingCm,
      totalVolumeM3: totalVolumeM3 ?? this.totalVolumeM3,
      tmaMm: tmaMm ?? this.tmaMm,
      designAge: designAge ?? this.designAge,
      testingDate: testingDate ?? this.testingDate,
      customerId: customerId ?? this.customerId,
      buildingSiteId: buildingSiteId ?? this.buildingSiteId,
      siteResidentId: siteResidentId ?? this.siteResidentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (designResistance.present) {
      map['design_resistance'] = Variable<String>(designResistance.value);
    }
    if (slumpingCm.present) {
      map['slumping_cm'] = Variable<int>(slumpingCm.value);
    }
    if (totalVolumeM3.present) {
      map['total_volume_m3'] = Variable<int>(totalVolumeM3.value);
    }
    if (tmaMm.present) {
      map['tma_mm'] = Variable<int>(tmaMm.value);
    }
    if (designAge.present) {
      map['design_age'] = Variable<String>(designAge.value);
    }
    if (testingDate.present) {
      map['testing_date'] = Variable<DateTime>(testingDate.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (buildingSiteId.present) {
      map['building_site_id'] = Variable<int>(buildingSiteId.value);
    }
    if (siteResidentId.present) {
      map['site_resident_id'] = Variable<int>(siteResidentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConcreteTestingOrdersCompanion(')
          ..write('id: $id, ')
          ..write('designResistance: $designResistance, ')
          ..write('slumpingCm: $slumpingCm, ')
          ..write('totalVolumeM3: $totalVolumeM3, ')
          ..write('tmaMm: $tmaMm, ')
          ..write('designAge: $designAge, ')
          ..write('testingDate: $testingDate, ')
          ..write('customerId: $customerId, ')
          ..write('buildingSiteId: $buildingSiteId, ')
          ..write('siteResidentId: $siteResidentId')
          ..write(')'))
        .toString();
  }
}

class $ConcreteSamplesTable extends ConcreteSamples
    with TableInfo<$ConcreteSamplesTable, ConcreteSample> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConcreteSamplesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remissionMeta =
      const VerificationMeta('remission');
  @override
  late final GeneratedColumn<String> remission = GeneratedColumn<String>(
      'remission', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<double> volume = GeneratedColumn<double>(
      'volume', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _plantTimeMeta =
      const VerificationMeta('plantTime');
  @override
  late final GeneratedColumn<String> plantTime = GeneratedColumn<String>(
      'plant_time', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _buildingSiteTimeMeta =
      const VerificationMeta('buildingSiteTime');
  @override
  late final GeneratedColumn<String> buildingSiteTime = GeneratedColumn<String>(
      'building_site_time', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _realSlumpingCmMeta =
      const VerificationMeta('realSlumpingCm');
  @override
  late final GeneratedColumn<double> realSlumpingCm = GeneratedColumn<double>(
      'real_slumping_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _temperatureCelsiusMeta =
      const VerificationMeta('temperatureCelsius');
  @override
  late final GeneratedColumn<double> temperatureCelsius =
      GeneratedColumn<double>('temperature_celsius', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _concreteTestingOrderIdMeta =
      const VerificationMeta('concreteTestingOrderId');
  @override
  late final GeneratedColumn<int> concreteTestingOrderId = GeneratedColumn<int>(
      'concrete_testing_order_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES concrete_testing_orders (id)'));
  static const VerificationMeta _concreteVolumetricWeightIdMeta =
      const VerificationMeta('concreteVolumetricWeightId');
  @override
  late final GeneratedColumn<int> concreteVolumetricWeightId =
      GeneratedColumn<int>(
          'concrete_volumetric_weight_id', aliasedName, true,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES concrete_volumetric_weights (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remission,
        volume,
        plantTime,
        buildingSiteTime,
        realSlumpingCm,
        temperatureCelsius,
        location,
        concreteTestingOrderId,
        concreteVolumetricWeightId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'concrete_samples';
  @override
  VerificationContext validateIntegrity(Insertable<ConcreteSample> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remission')) {
      context.handle(_remissionMeta,
          remission.isAcceptableOrUnknown(data['remission']!, _remissionMeta));
    } else if (isInserting) {
      context.missing(_remissionMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('plant_time')) {
      context.handle(_plantTimeMeta,
          plantTime.isAcceptableOrUnknown(data['plant_time']!, _plantTimeMeta));
    } else if (isInserting) {
      context.missing(_plantTimeMeta);
    }
    if (data.containsKey('building_site_time')) {
      context.handle(
          _buildingSiteTimeMeta,
          buildingSiteTime.isAcceptableOrUnknown(
              data['building_site_time']!, _buildingSiteTimeMeta));
    } else if (isInserting) {
      context.missing(_buildingSiteTimeMeta);
    }
    if (data.containsKey('real_slumping_cm')) {
      context.handle(
          _realSlumpingCmMeta,
          realSlumpingCm.isAcceptableOrUnknown(
              data['real_slumping_cm']!, _realSlumpingCmMeta));
    } else if (isInserting) {
      context.missing(_realSlumpingCmMeta);
    }
    if (data.containsKey('temperature_celsius')) {
      context.handle(
          _temperatureCelsiusMeta,
          temperatureCelsius.isAcceptableOrUnknown(
              data['temperature_celsius']!, _temperatureCelsiusMeta));
    } else if (isInserting) {
      context.missing(_temperatureCelsiusMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('concrete_testing_order_id')) {
      context.handle(
          _concreteTestingOrderIdMeta,
          concreteTestingOrderId.isAcceptableOrUnknown(
              data['concrete_testing_order_id']!, _concreteTestingOrderIdMeta));
    } else if (isInserting) {
      context.missing(_concreteTestingOrderIdMeta);
    }
    if (data.containsKey('concrete_volumetric_weight_id')) {
      context.handle(
          _concreteVolumetricWeightIdMeta,
          concreteVolumetricWeightId.isAcceptableOrUnknown(
              data['concrete_volumetric_weight_id']!,
              _concreteVolumetricWeightIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConcreteSample map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConcreteSample(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remission: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remission'])!,
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}volume'])!,
      plantTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plant_time'])!,
      buildingSiteTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}building_site_time'])!,
      realSlumpingCm: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}real_slumping_cm'])!,
      temperatureCelsius: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}temperature_celsius'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      concreteTestingOrderId: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}concrete_testing_order_id'])!,
      concreteVolumetricWeightId: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}concrete_volumetric_weight_id']),
    );
  }

  @override
  $ConcreteSamplesTable createAlias(String alias) {
    return $ConcreteSamplesTable(attachedDatabase, alias);
  }
}

class ConcreteSample extends DataClass implements Insertable<ConcreteSample> {
  final int id;
  final String remission;
  final double volume;
  final String plantTime;
  final String buildingSiteTime;
  final double realSlumpingCm;
  final double temperatureCelsius;
  final String location;
  final int concreteTestingOrderId;
  final int? concreteVolumetricWeightId;
  const ConcreteSample(
      {required this.id,
      required this.remission,
      required this.volume,
      required this.plantTime,
      required this.buildingSiteTime,
      required this.realSlumpingCm,
      required this.temperatureCelsius,
      required this.location,
      required this.concreteTestingOrderId,
      this.concreteVolumetricWeightId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remission'] = Variable<String>(remission);
    map['volume'] = Variable<double>(volume);
    map['plant_time'] = Variable<String>(plantTime);
    map['building_site_time'] = Variable<String>(buildingSiteTime);
    map['real_slumping_cm'] = Variable<double>(realSlumpingCm);
    map['temperature_celsius'] = Variable<double>(temperatureCelsius);
    map['location'] = Variable<String>(location);
    map['concrete_testing_order_id'] = Variable<int>(concreteTestingOrderId);
    if (!nullToAbsent || concreteVolumetricWeightId != null) {
      map['concrete_volumetric_weight_id'] =
          Variable<int>(concreteVolumetricWeightId);
    }
    return map;
  }

  ConcreteSamplesCompanion toCompanion(bool nullToAbsent) {
    return ConcreteSamplesCompanion(
      id: Value(id),
      remission: Value(remission),
      volume: Value(volume),
      plantTime: Value(plantTime),
      buildingSiteTime: Value(buildingSiteTime),
      realSlumpingCm: Value(realSlumpingCm),
      temperatureCelsius: Value(temperatureCelsius),
      location: Value(location),
      concreteTestingOrderId: Value(concreteTestingOrderId),
      concreteVolumetricWeightId:
          concreteVolumetricWeightId == null && nullToAbsent
              ? const Value.absent()
              : Value(concreteVolumetricWeightId),
    );
  }

  factory ConcreteSample.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConcreteSample(
      id: serializer.fromJson<int>(json['id']),
      remission: serializer.fromJson<String>(json['remission']),
      volume: serializer.fromJson<double>(json['volume']),
      plantTime: serializer.fromJson<String>(json['plantTime']),
      buildingSiteTime: serializer.fromJson<String>(json['buildingSiteTime']),
      realSlumpingCm: serializer.fromJson<double>(json['realSlumpingCm']),
      temperatureCelsius:
          serializer.fromJson<double>(json['temperatureCelsius']),
      location: serializer.fromJson<String>(json['location']),
      concreteTestingOrderId:
          serializer.fromJson<int>(json['concreteTestingOrderId']),
      concreteVolumetricWeightId:
          serializer.fromJson<int?>(json['concreteVolumetricWeightId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remission': serializer.toJson<String>(remission),
      'volume': serializer.toJson<double>(volume),
      'plantTime': serializer.toJson<String>(plantTime),
      'buildingSiteTime': serializer.toJson<String>(buildingSiteTime),
      'realSlumpingCm': serializer.toJson<double>(realSlumpingCm),
      'temperatureCelsius': serializer.toJson<double>(temperatureCelsius),
      'location': serializer.toJson<String>(location),
      'concreteTestingOrderId': serializer.toJson<int>(concreteTestingOrderId),
      'concreteVolumetricWeightId':
          serializer.toJson<int?>(concreteVolumetricWeightId),
    };
  }

  ConcreteSample copyWith(
          {int? id,
          String? remission,
          double? volume,
          String? plantTime,
          String? buildingSiteTime,
          double? realSlumpingCm,
          double? temperatureCelsius,
          String? location,
          int? concreteTestingOrderId,
          Value<int?> concreteVolumetricWeightId = const Value.absent()}) =>
      ConcreteSample(
        id: id ?? this.id,
        remission: remission ?? this.remission,
        volume: volume ?? this.volume,
        plantTime: plantTime ?? this.plantTime,
        buildingSiteTime: buildingSiteTime ?? this.buildingSiteTime,
        realSlumpingCm: realSlumpingCm ?? this.realSlumpingCm,
        temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
        location: location ?? this.location,
        concreteTestingOrderId:
            concreteTestingOrderId ?? this.concreteTestingOrderId,
        concreteVolumetricWeightId: concreteVolumetricWeightId.present
            ? concreteVolumetricWeightId.value
            : this.concreteVolumetricWeightId,
      );
  @override
  String toString() {
    return (StringBuffer('ConcreteSample(')
          ..write('id: $id, ')
          ..write('remission: $remission, ')
          ..write('volume: $volume, ')
          ..write('plantTime: $plantTime, ')
          ..write('buildingSiteTime: $buildingSiteTime, ')
          ..write('realSlumpingCm: $realSlumpingCm, ')
          ..write('temperatureCelsius: $temperatureCelsius, ')
          ..write('location: $location, ')
          ..write('concreteTestingOrderId: $concreteTestingOrderId, ')
          ..write('concreteVolumetricWeightId: $concreteVolumetricWeightId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      remission,
      volume,
      plantTime,
      buildingSiteTime,
      realSlumpingCm,
      temperatureCelsius,
      location,
      concreteTestingOrderId,
      concreteVolumetricWeightId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConcreteSample &&
          other.id == this.id &&
          other.remission == this.remission &&
          other.volume == this.volume &&
          other.plantTime == this.plantTime &&
          other.buildingSiteTime == this.buildingSiteTime &&
          other.realSlumpingCm == this.realSlumpingCm &&
          other.temperatureCelsius == this.temperatureCelsius &&
          other.location == this.location &&
          other.concreteTestingOrderId == this.concreteTestingOrderId &&
          other.concreteVolumetricWeightId == this.concreteVolumetricWeightId);
}

class ConcreteSamplesCompanion extends UpdateCompanion<ConcreteSample> {
  final Value<int> id;
  final Value<String> remission;
  final Value<double> volume;
  final Value<String> plantTime;
  final Value<String> buildingSiteTime;
  final Value<double> realSlumpingCm;
  final Value<double> temperatureCelsius;
  final Value<String> location;
  final Value<int> concreteTestingOrderId;
  final Value<int?> concreteVolumetricWeightId;
  const ConcreteSamplesCompanion({
    this.id = const Value.absent(),
    this.remission = const Value.absent(),
    this.volume = const Value.absent(),
    this.plantTime = const Value.absent(),
    this.buildingSiteTime = const Value.absent(),
    this.realSlumpingCm = const Value.absent(),
    this.temperatureCelsius = const Value.absent(),
    this.location = const Value.absent(),
    this.concreteTestingOrderId = const Value.absent(),
    this.concreteVolumetricWeightId = const Value.absent(),
  });
  ConcreteSamplesCompanion.insert({
    this.id = const Value.absent(),
    required String remission,
    required double volume,
    required String plantTime,
    required String buildingSiteTime,
    required double realSlumpingCm,
    required double temperatureCelsius,
    required String location,
    required int concreteTestingOrderId,
    this.concreteVolumetricWeightId = const Value.absent(),
  })  : remission = Value(remission),
        volume = Value(volume),
        plantTime = Value(plantTime),
        buildingSiteTime = Value(buildingSiteTime),
        realSlumpingCm = Value(realSlumpingCm),
        temperatureCelsius = Value(temperatureCelsius),
        location = Value(location),
        concreteTestingOrderId = Value(concreteTestingOrderId);
  static Insertable<ConcreteSample> custom({
    Expression<int>? id,
    Expression<String>? remission,
    Expression<double>? volume,
    Expression<String>? plantTime,
    Expression<String>? buildingSiteTime,
    Expression<double>? realSlumpingCm,
    Expression<double>? temperatureCelsius,
    Expression<String>? location,
    Expression<int>? concreteTestingOrderId,
    Expression<int>? concreteVolumetricWeightId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remission != null) 'remission': remission,
      if (volume != null) 'volume': volume,
      if (plantTime != null) 'plant_time': plantTime,
      if (buildingSiteTime != null) 'building_site_time': buildingSiteTime,
      if (realSlumpingCm != null) 'real_slumping_cm': realSlumpingCm,
      if (temperatureCelsius != null) 'temperature_celsius': temperatureCelsius,
      if (location != null) 'location': location,
      if (concreteTestingOrderId != null)
        'concrete_testing_order_id': concreteTestingOrderId,
      if (concreteVolumetricWeightId != null)
        'concrete_volumetric_weight_id': concreteVolumetricWeightId,
    });
  }

  ConcreteSamplesCompanion copyWith(
      {Value<int>? id,
      Value<String>? remission,
      Value<double>? volume,
      Value<String>? plantTime,
      Value<String>? buildingSiteTime,
      Value<double>? realSlumpingCm,
      Value<double>? temperatureCelsius,
      Value<String>? location,
      Value<int>? concreteTestingOrderId,
      Value<int?>? concreteVolumetricWeightId}) {
    return ConcreteSamplesCompanion(
      id: id ?? this.id,
      remission: remission ?? this.remission,
      volume: volume ?? this.volume,
      plantTime: plantTime ?? this.plantTime,
      buildingSiteTime: buildingSiteTime ?? this.buildingSiteTime,
      realSlumpingCm: realSlumpingCm ?? this.realSlumpingCm,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      location: location ?? this.location,
      concreteTestingOrderId:
          concreteTestingOrderId ?? this.concreteTestingOrderId,
      concreteVolumetricWeightId:
          concreteVolumetricWeightId ?? this.concreteVolumetricWeightId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remission.present) {
      map['remission'] = Variable<String>(remission.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (plantTime.present) {
      map['plant_time'] = Variable<String>(plantTime.value);
    }
    if (buildingSiteTime.present) {
      map['building_site_time'] = Variable<String>(buildingSiteTime.value);
    }
    if (realSlumpingCm.present) {
      map['real_slumping_cm'] = Variable<double>(realSlumpingCm.value);
    }
    if (temperatureCelsius.present) {
      map['temperature_celsius'] = Variable<double>(temperatureCelsius.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (concreteTestingOrderId.present) {
      map['concrete_testing_order_id'] =
          Variable<int>(concreteTestingOrderId.value);
    }
    if (concreteVolumetricWeightId.present) {
      map['concrete_volumetric_weight_id'] =
          Variable<int>(concreteVolumetricWeightId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConcreteSamplesCompanion(')
          ..write('id: $id, ')
          ..write('remission: $remission, ')
          ..write('volume: $volume, ')
          ..write('plantTime: $plantTime, ')
          ..write('buildingSiteTime: $buildingSiteTime, ')
          ..write('realSlumpingCm: $realSlumpingCm, ')
          ..write('temperatureCelsius: $temperatureCelsius, ')
          ..write('location: $location, ')
          ..write('concreteTestingOrderId: $concreteTestingOrderId, ')
          ..write('concreteVolumetricWeightId: $concreteVolumetricWeightId')
          ..write(')'))
        .toString();
  }
}

class $ConcreteCylindersTable extends ConcreteCylinders
    with TableInfo<$ConcreteCylindersTable, ConcreteCylinder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConcreteCylindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _buildingSiteSampleNumberMeta =
      const VerificationMeta('buildingSiteSampleNumber');
  @override
  late final GeneratedColumn<int> buildingSiteSampleNumber =
      GeneratedColumn<int>('building_site_sample_number', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _testingAgeDaysMeta =
      const VerificationMeta('testingAgeDays');
  @override
  late final GeneratedColumn<int> testingAgeDays = GeneratedColumn<int>(
      'testing_age_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _testingDateMeta =
      const VerificationMeta('testingDate');
  @override
  late final GeneratedColumn<int> testingDate = GeneratedColumn<int>(
      'testing_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalLoadKgMeta =
      const VerificationMeta('totalLoadKg');
  @override
  late final GeneratedColumn<double> totalLoadKg = GeneratedColumn<double>(
      'total_load_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _diameterCmMeta =
      const VerificationMeta('diameterCm');
  @override
  late final GeneratedColumn<double> diameterCm = GeneratedColumn<double>(
      'diameter_cm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _resistanceKgfCm2Meta =
      const VerificationMeta('resistanceKgfCm2');
  @override
  late final GeneratedColumn<double> resistanceKgfCm2 = GeneratedColumn<double>(
      'resistance_kgf_cm2', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _medianMeta = const VerificationMeta('median');
  @override
  late final GeneratedColumn<double> median = GeneratedColumn<double>(
      'median', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
      'percentage', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _concreteSampleIdMeta =
      const VerificationMeta('concreteSampleId');
  @override
  late final GeneratedColumn<int> concreteSampleId = GeneratedColumn<int>(
      'concrete_sample_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES concrete_samples (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        buildingSiteSampleNumber,
        testingAgeDays,
        testingDate,
        totalLoadKg,
        diameterCm,
        resistanceKgfCm2,
        median,
        percentage,
        concreteSampleId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'concrete_cylinders';
  @override
  VerificationContext validateIntegrity(Insertable<ConcreteCylinder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('building_site_sample_number')) {
      context.handle(
          _buildingSiteSampleNumberMeta,
          buildingSiteSampleNumber.isAcceptableOrUnknown(
              data['building_site_sample_number']!,
              _buildingSiteSampleNumberMeta));
    } else if (isInserting) {
      context.missing(_buildingSiteSampleNumberMeta);
    }
    if (data.containsKey('testing_age_days')) {
      context.handle(
          _testingAgeDaysMeta,
          testingAgeDays.isAcceptableOrUnknown(
              data['testing_age_days']!, _testingAgeDaysMeta));
    } else if (isInserting) {
      context.missing(_testingAgeDaysMeta);
    }
    if (data.containsKey('testing_date')) {
      context.handle(
          _testingDateMeta,
          testingDate.isAcceptableOrUnknown(
              data['testing_date']!, _testingDateMeta));
    } else if (isInserting) {
      context.missing(_testingDateMeta);
    }
    if (data.containsKey('total_load_kg')) {
      context.handle(
          _totalLoadKgMeta,
          totalLoadKg.isAcceptableOrUnknown(
              data['total_load_kg']!, _totalLoadKgMeta));
    }
    if (data.containsKey('diameter_cm')) {
      context.handle(
          _diameterCmMeta,
          diameterCm.isAcceptableOrUnknown(
              data['diameter_cm']!, _diameterCmMeta));
    }
    if (data.containsKey('resistance_kgf_cm2')) {
      context.handle(
          _resistanceKgfCm2Meta,
          resistanceKgfCm2.isAcceptableOrUnknown(
              data['resistance_kgf_cm2']!, _resistanceKgfCm2Meta));
    }
    if (data.containsKey('median')) {
      context.handle(_medianMeta,
          median.isAcceptableOrUnknown(data['median']!, _medianMeta));
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    }
    if (data.containsKey('concrete_sample_id')) {
      context.handle(
          _concreteSampleIdMeta,
          concreteSampleId.isAcceptableOrUnknown(
              data['concrete_sample_id']!, _concreteSampleIdMeta));
    } else if (isInserting) {
      context.missing(_concreteSampleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConcreteCylinder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConcreteCylinder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      buildingSiteSampleNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}building_site_sample_number'])!,
      testingAgeDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}testing_age_days'])!,
      testingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}testing_date'])!,
      totalLoadKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_load_kg']),
      diameterCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}diameter_cm']),
      resistanceKgfCm2: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}resistance_kgf_cm2']),
      median: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}median']),
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}percentage']),
      concreteSampleId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}concrete_sample_id'])!,
    );
  }

  @override
  $ConcreteCylindersTable createAlias(String alias) {
    return $ConcreteCylindersTable(attachedDatabase, alias);
  }
}

class ConcreteCylinder extends DataClass
    implements Insertable<ConcreteCylinder> {
  final int id;
  final int buildingSiteSampleNumber;
  final int testingAgeDays;
  final int testingDate;
  final double? totalLoadKg;
  final double? diameterCm;
  final double? resistanceKgfCm2;
  final double? median;
  final double? percentage;
  final int concreteSampleId;
  const ConcreteCylinder(
      {required this.id,
      required this.buildingSiteSampleNumber,
      required this.testingAgeDays,
      required this.testingDate,
      this.totalLoadKg,
      this.diameterCm,
      this.resistanceKgfCm2,
      this.median,
      this.percentage,
      required this.concreteSampleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['building_site_sample_number'] =
        Variable<int>(buildingSiteSampleNumber);
    map['testing_age_days'] = Variable<int>(testingAgeDays);
    map['testing_date'] = Variable<int>(testingDate);
    if (!nullToAbsent || totalLoadKg != null) {
      map['total_load_kg'] = Variable<double>(totalLoadKg);
    }
    if (!nullToAbsent || diameterCm != null) {
      map['diameter_cm'] = Variable<double>(diameterCm);
    }
    if (!nullToAbsent || resistanceKgfCm2 != null) {
      map['resistance_kgf_cm2'] = Variable<double>(resistanceKgfCm2);
    }
    if (!nullToAbsent || median != null) {
      map['median'] = Variable<double>(median);
    }
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<double>(percentage);
    }
    map['concrete_sample_id'] = Variable<int>(concreteSampleId);
    return map;
  }

  ConcreteCylindersCompanion toCompanion(bool nullToAbsent) {
    return ConcreteCylindersCompanion(
      id: Value(id),
      buildingSiteSampleNumber: Value(buildingSiteSampleNumber),
      testingAgeDays: Value(testingAgeDays),
      testingDate: Value(testingDate),
      totalLoadKg: totalLoadKg == null && nullToAbsent
          ? const Value.absent()
          : Value(totalLoadKg),
      diameterCm: diameterCm == null && nullToAbsent
          ? const Value.absent()
          : Value(diameterCm),
      resistanceKgfCm2: resistanceKgfCm2 == null && nullToAbsent
          ? const Value.absent()
          : Value(resistanceKgfCm2),
      median:
          median == null && nullToAbsent ? const Value.absent() : Value(median),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
      concreteSampleId: Value(concreteSampleId),
    );
  }

  factory ConcreteCylinder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConcreteCylinder(
      id: serializer.fromJson<int>(json['id']),
      buildingSiteSampleNumber:
          serializer.fromJson<int>(json['buildingSiteSampleNumber']),
      testingAgeDays: serializer.fromJson<int>(json['testingAgeDays']),
      testingDate: serializer.fromJson<int>(json['testingDate']),
      totalLoadKg: serializer.fromJson<double?>(json['totalLoadKg']),
      diameterCm: serializer.fromJson<double?>(json['diameterCm']),
      resistanceKgfCm2: serializer.fromJson<double?>(json['resistanceKgfCm2']),
      median: serializer.fromJson<double?>(json['median']),
      percentage: serializer.fromJson<double?>(json['percentage']),
      concreteSampleId: serializer.fromJson<int>(json['concreteSampleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buildingSiteSampleNumber':
          serializer.toJson<int>(buildingSiteSampleNumber),
      'testingAgeDays': serializer.toJson<int>(testingAgeDays),
      'testingDate': serializer.toJson<int>(testingDate),
      'totalLoadKg': serializer.toJson<double?>(totalLoadKg),
      'diameterCm': serializer.toJson<double?>(diameterCm),
      'resistanceKgfCm2': serializer.toJson<double?>(resistanceKgfCm2),
      'median': serializer.toJson<double?>(median),
      'percentage': serializer.toJson<double?>(percentage),
      'concreteSampleId': serializer.toJson<int>(concreteSampleId),
    };
  }

  ConcreteCylinder copyWith(
          {int? id,
          int? buildingSiteSampleNumber,
          int? testingAgeDays,
          int? testingDate,
          Value<double?> totalLoadKg = const Value.absent(),
          Value<double?> diameterCm = const Value.absent(),
          Value<double?> resistanceKgfCm2 = const Value.absent(),
          Value<double?> median = const Value.absent(),
          Value<double?> percentage = const Value.absent(),
          int? concreteSampleId}) =>
      ConcreteCylinder(
        id: id ?? this.id,
        buildingSiteSampleNumber:
            buildingSiteSampleNumber ?? this.buildingSiteSampleNumber,
        testingAgeDays: testingAgeDays ?? this.testingAgeDays,
        testingDate: testingDate ?? this.testingDate,
        totalLoadKg: totalLoadKg.present ? totalLoadKg.value : this.totalLoadKg,
        diameterCm: diameterCm.present ? diameterCm.value : this.diameterCm,
        resistanceKgfCm2: resistanceKgfCm2.present
            ? resistanceKgfCm2.value
            : this.resistanceKgfCm2,
        median: median.present ? median.value : this.median,
        percentage: percentage.present ? percentage.value : this.percentage,
        concreteSampleId: concreteSampleId ?? this.concreteSampleId,
      );
  @override
  String toString() {
    return (StringBuffer('ConcreteCylinder(')
          ..write('id: $id, ')
          ..write('buildingSiteSampleNumber: $buildingSiteSampleNumber, ')
          ..write('testingAgeDays: $testingAgeDays, ')
          ..write('testingDate: $testingDate, ')
          ..write('totalLoadKg: $totalLoadKg, ')
          ..write('diameterCm: $diameterCm, ')
          ..write('resistanceKgfCm2: $resistanceKgfCm2, ')
          ..write('median: $median, ')
          ..write('percentage: $percentage, ')
          ..write('concreteSampleId: $concreteSampleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      buildingSiteSampleNumber,
      testingAgeDays,
      testingDate,
      totalLoadKg,
      diameterCm,
      resistanceKgfCm2,
      median,
      percentage,
      concreteSampleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConcreteCylinder &&
          other.id == this.id &&
          other.buildingSiteSampleNumber == this.buildingSiteSampleNumber &&
          other.testingAgeDays == this.testingAgeDays &&
          other.testingDate == this.testingDate &&
          other.totalLoadKg == this.totalLoadKg &&
          other.diameterCm == this.diameterCm &&
          other.resistanceKgfCm2 == this.resistanceKgfCm2 &&
          other.median == this.median &&
          other.percentage == this.percentage &&
          other.concreteSampleId == this.concreteSampleId);
}

class ConcreteCylindersCompanion extends UpdateCompanion<ConcreteCylinder> {
  final Value<int> id;
  final Value<int> buildingSiteSampleNumber;
  final Value<int> testingAgeDays;
  final Value<int> testingDate;
  final Value<double?> totalLoadKg;
  final Value<double?> diameterCm;
  final Value<double?> resistanceKgfCm2;
  final Value<double?> median;
  final Value<double?> percentage;
  final Value<int> concreteSampleId;
  const ConcreteCylindersCompanion({
    this.id = const Value.absent(),
    this.buildingSiteSampleNumber = const Value.absent(),
    this.testingAgeDays = const Value.absent(),
    this.testingDate = const Value.absent(),
    this.totalLoadKg = const Value.absent(),
    this.diameterCm = const Value.absent(),
    this.resistanceKgfCm2 = const Value.absent(),
    this.median = const Value.absent(),
    this.percentage = const Value.absent(),
    this.concreteSampleId = const Value.absent(),
  });
  ConcreteCylindersCompanion.insert({
    this.id = const Value.absent(),
    required int buildingSiteSampleNumber,
    required int testingAgeDays,
    required int testingDate,
    this.totalLoadKg = const Value.absent(),
    this.diameterCm = const Value.absent(),
    this.resistanceKgfCm2 = const Value.absent(),
    this.median = const Value.absent(),
    this.percentage = const Value.absent(),
    required int concreteSampleId,
  })  : buildingSiteSampleNumber = Value(buildingSiteSampleNumber),
        testingAgeDays = Value(testingAgeDays),
        testingDate = Value(testingDate),
        concreteSampleId = Value(concreteSampleId);
  static Insertable<ConcreteCylinder> custom({
    Expression<int>? id,
    Expression<int>? buildingSiteSampleNumber,
    Expression<int>? testingAgeDays,
    Expression<int>? testingDate,
    Expression<double>? totalLoadKg,
    Expression<double>? diameterCm,
    Expression<double>? resistanceKgfCm2,
    Expression<double>? median,
    Expression<double>? percentage,
    Expression<int>? concreteSampleId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buildingSiteSampleNumber != null)
        'building_site_sample_number': buildingSiteSampleNumber,
      if (testingAgeDays != null) 'testing_age_days': testingAgeDays,
      if (testingDate != null) 'testing_date': testingDate,
      if (totalLoadKg != null) 'total_load_kg': totalLoadKg,
      if (diameterCm != null) 'diameter_cm': diameterCm,
      if (resistanceKgfCm2 != null) 'resistance_kgf_cm2': resistanceKgfCm2,
      if (median != null) 'median': median,
      if (percentage != null) 'percentage': percentage,
      if (concreteSampleId != null) 'concrete_sample_id': concreteSampleId,
    });
  }

  ConcreteCylindersCompanion copyWith(
      {Value<int>? id,
      Value<int>? buildingSiteSampleNumber,
      Value<int>? testingAgeDays,
      Value<int>? testingDate,
      Value<double?>? totalLoadKg,
      Value<double?>? diameterCm,
      Value<double?>? resistanceKgfCm2,
      Value<double?>? median,
      Value<double?>? percentage,
      Value<int>? concreteSampleId}) {
    return ConcreteCylindersCompanion(
      id: id ?? this.id,
      buildingSiteSampleNumber:
          buildingSiteSampleNumber ?? this.buildingSiteSampleNumber,
      testingAgeDays: testingAgeDays ?? this.testingAgeDays,
      testingDate: testingDate ?? this.testingDate,
      totalLoadKg: totalLoadKg ?? this.totalLoadKg,
      diameterCm: diameterCm ?? this.diameterCm,
      resistanceKgfCm2: resistanceKgfCm2 ?? this.resistanceKgfCm2,
      median: median ?? this.median,
      percentage: percentage ?? this.percentage,
      concreteSampleId: concreteSampleId ?? this.concreteSampleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buildingSiteSampleNumber.present) {
      map['building_site_sample_number'] =
          Variable<int>(buildingSiteSampleNumber.value);
    }
    if (testingAgeDays.present) {
      map['testing_age_days'] = Variable<int>(testingAgeDays.value);
    }
    if (testingDate.present) {
      map['testing_date'] = Variable<int>(testingDate.value);
    }
    if (totalLoadKg.present) {
      map['total_load_kg'] = Variable<double>(totalLoadKg.value);
    }
    if (diameterCm.present) {
      map['diameter_cm'] = Variable<double>(diameterCm.value);
    }
    if (resistanceKgfCm2.present) {
      map['resistance_kgf_cm2'] = Variable<double>(resistanceKgfCm2.value);
    }
    if (median.present) {
      map['median'] = Variable<double>(median.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (concreteSampleId.present) {
      map['concrete_sample_id'] = Variable<int>(concreteSampleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConcreteCylindersCompanion(')
          ..write('id: $id, ')
          ..write('buildingSiteSampleNumber: $buildingSiteSampleNumber, ')
          ..write('testingAgeDays: $testingAgeDays, ')
          ..write('testingDate: $testingDate, ')
          ..write('totalLoadKg: $totalLoadKg, ')
          ..write('diameterCm: $diameterCm, ')
          ..write('resistanceKgfCm2: $resistanceKgfCm2, ')
          ..write('median: $median, ')
          ..write('percentage: $percentage, ')
          ..write('concreteSampleId: $concreteSampleId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $SiteResidentsTable siteResidents = $SiteResidentsTable(this);
  late final $BuildingSitesTable buildingSites = $BuildingSitesTable(this);
  late final $ConcreteVolumetricWeightsTable concreteVolumetricWeights =
      $ConcreteVolumetricWeightsTable(this);
  late final $ConcreteTestingOrdersTable concreteTestingOrders =
      $ConcreteTestingOrdersTable(this);
  late final $ConcreteSamplesTable concreteSamples =
      $ConcreteSamplesTable(this);
  late final $ConcreteCylindersTable concreteCylinders =
      $ConcreteCylindersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        customers,
        siteResidents,
        buildingSites,
        concreteVolumetricWeights,
        concreteTestingOrders,
        concreteSamples,
        concreteCylinders
      ];
}

typedef $$CustomersTableInsertCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  required String identifier,
  Value<String> companyName,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> identifier,
  Value<String> companyName,
});

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableProcessedTableManager,
    $$CustomersTableInsertCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CustomersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CustomersTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$CustomersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> identifier = const Value.absent(),
            Value<String> companyName = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            identifier: identifier,
            companyName: companyName,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String identifier,
            Value<String> companyName = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            identifier: identifier,
            companyName: companyName,
          ),
        ));
}

class $$CustomersTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableProcessedTableManager,
    $$CustomersTableInsertCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder> {
  $$CustomersTableProcessedTableManager(super.$state);
}

class $$CustomersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get identifier => $state.composableBuilder(
      column: $state.table.identifier,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get companyName => $state.composableBuilder(
      column: $state.table.companyName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter buildingSitesRefs(
      ComposableFilter Function($$BuildingSitesTableFilterComposer f) f) {
    final $$BuildingSitesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.buildingSites,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder, parentComposers) =>
            $$BuildingSitesTableFilterComposer(ComposerState($state.db,
                $state.db.buildingSites, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter concreteTestingOrdersRefs(
      ComposableFilter Function($$ConcreteTestingOrdersTableFilterComposer f)
          f) {
    final $$ConcreteTestingOrdersTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.concreteTestingOrders,
            getReferencedColumn: (t) => t.customerId,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteTestingOrdersTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.concreteTestingOrders,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get identifier => $state.composableBuilder(
      column: $state.table.identifier,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get companyName => $state.composableBuilder(
      column: $state.table.companyName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SiteResidentsTableInsertCompanionBuilder = SiteResidentsCompanion
    Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  Value<String> jobPosition,
});
typedef $$SiteResidentsTableUpdateCompanionBuilder = SiteResidentsCompanion
    Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> jobPosition,
});

class $$SiteResidentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SiteResidentsTable,
    SiteResident,
    $$SiteResidentsTableFilterComposer,
    $$SiteResidentsTableOrderingComposer,
    $$SiteResidentsTableProcessedTableManager,
    $$SiteResidentsTableInsertCompanionBuilder,
    $$SiteResidentsTableUpdateCompanionBuilder> {
  $$SiteResidentsTableTableManager(_$AppDatabase db, $SiteResidentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SiteResidentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SiteResidentsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SiteResidentsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> jobPosition = const Value.absent(),
          }) =>
              SiteResidentsCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            jobPosition: jobPosition,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            Value<String> jobPosition = const Value.absent(),
          }) =>
              SiteResidentsCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            jobPosition: jobPosition,
          ),
        ));
}

class $$SiteResidentsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $SiteResidentsTable,
    SiteResident,
    $$SiteResidentsTableFilterComposer,
    $$SiteResidentsTableOrderingComposer,
    $$SiteResidentsTableProcessedTableManager,
    $$SiteResidentsTableInsertCompanionBuilder,
    $$SiteResidentsTableUpdateCompanionBuilder> {
  $$SiteResidentsTableProcessedTableManager(super.$state);
}

class $$SiteResidentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SiteResidentsTable> {
  $$SiteResidentsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get jobPosition => $state.composableBuilder(
      column: $state.table.jobPosition,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter buildingSitesRefs(
      ComposableFilter Function($$BuildingSitesTableFilterComposer f) f) {
    final $$BuildingSitesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.buildingSites,
        getReferencedColumn: (t) => t.siteResidentId,
        builder: (joinBuilder, parentComposers) =>
            $$BuildingSitesTableFilterComposer(ComposerState($state.db,
                $state.db.buildingSites, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter concreteTestingOrdersRefs(
      ComposableFilter Function($$ConcreteTestingOrdersTableFilterComposer f)
          f) {
    final $$ConcreteTestingOrdersTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.concreteTestingOrders,
            getReferencedColumn: (t) => t.siteResidentId,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteTestingOrdersTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.concreteTestingOrders,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$SiteResidentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SiteResidentsTable> {
  $$SiteResidentsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get jobPosition => $state.composableBuilder(
      column: $state.table.jobPosition,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BuildingSitesTableInsertCompanionBuilder = BuildingSitesCompanion
    Function({
  Value<int> id,
  required String siteName,
  required int customerId,
  Value<int?> siteResidentId,
});
typedef $$BuildingSitesTableUpdateCompanionBuilder = BuildingSitesCompanion
    Function({
  Value<int> id,
  Value<String> siteName,
  Value<int> customerId,
  Value<int?> siteResidentId,
});

class $$BuildingSitesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BuildingSitesTable,
    BuildingSite,
    $$BuildingSitesTableFilterComposer,
    $$BuildingSitesTableOrderingComposer,
    $$BuildingSitesTableProcessedTableManager,
    $$BuildingSitesTableInsertCompanionBuilder,
    $$BuildingSitesTableUpdateCompanionBuilder> {
  $$BuildingSitesTableTableManager(_$AppDatabase db, $BuildingSitesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BuildingSitesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BuildingSitesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$BuildingSitesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> siteName = const Value.absent(),
            Value<int> customerId = const Value.absent(),
            Value<int?> siteResidentId = const Value.absent(),
          }) =>
              BuildingSitesCompanion(
            id: id,
            siteName: siteName,
            customerId: customerId,
            siteResidentId: siteResidentId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String siteName,
            required int customerId,
            Value<int?> siteResidentId = const Value.absent(),
          }) =>
              BuildingSitesCompanion.insert(
            id: id,
            siteName: siteName,
            customerId: customerId,
            siteResidentId: siteResidentId,
          ),
        ));
}

class $$BuildingSitesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $BuildingSitesTable,
    BuildingSite,
    $$BuildingSitesTableFilterComposer,
    $$BuildingSitesTableOrderingComposer,
    $$BuildingSitesTableProcessedTableManager,
    $$BuildingSitesTableInsertCompanionBuilder,
    $$BuildingSitesTableUpdateCompanionBuilder> {
  $$BuildingSitesTableProcessedTableManager(super.$state);
}

class $$BuildingSitesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BuildingSitesTable> {
  $$BuildingSitesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get siteName => $state.composableBuilder(
      column: $state.table.siteName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableFilterComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$SiteResidentsTableFilterComposer get siteResidentId {
    final $$SiteResidentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.siteResidentId,
        referencedTable: $state.db.siteResidents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SiteResidentsTableFilterComposer(ComposerState($state.db,
                $state.db.siteResidents, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter concreteTestingOrdersRefs(
      ComposableFilter Function($$ConcreteTestingOrdersTableFilterComposer f)
          f) {
    final $$ConcreteTestingOrdersTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.concreteTestingOrders,
            getReferencedColumn: (t) => t.buildingSiteId,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteTestingOrdersTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.concreteTestingOrders,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$BuildingSitesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BuildingSitesTable> {
  $$BuildingSitesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get siteName => $state.composableBuilder(
      column: $state.table.siteName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableOrderingComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$SiteResidentsTableOrderingComposer get siteResidentId {
    final $$SiteResidentsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.siteResidentId,
            referencedTable: $state.db.siteResidents,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$SiteResidentsTableOrderingComposer(ComposerState($state.db,
                    $state.db.siteResidents, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ConcreteVolumetricWeightsTableInsertCompanionBuilder
    = ConcreteVolumetricWeightsCompanion Function({
  Value<int> id,
  required double tareWeightGr,
  required double materialTareWeightGr,
  required double materialWeightGr,
  required double tareVolumeCm3,
  required double volumetricWeightGrCm3,
  required double volumeLoadM3,
  required double cementQuantityKg,
  required double coarseAggregateKg,
  required double fineAggregateKg,
  required double waterKg,
  Value<String?> additives,
  required double totalLoadKg,
  required double totalLoadVolumetricWeightRelation,
  required double percentage,
});
typedef $$ConcreteVolumetricWeightsTableUpdateCompanionBuilder
    = ConcreteVolumetricWeightsCompanion Function({
  Value<int> id,
  Value<double> tareWeightGr,
  Value<double> materialTareWeightGr,
  Value<double> materialWeightGr,
  Value<double> tareVolumeCm3,
  Value<double> volumetricWeightGrCm3,
  Value<double> volumeLoadM3,
  Value<double> cementQuantityKg,
  Value<double> coarseAggregateKg,
  Value<double> fineAggregateKg,
  Value<double> waterKg,
  Value<String?> additives,
  Value<double> totalLoadKg,
  Value<double> totalLoadVolumetricWeightRelation,
  Value<double> percentage,
});

class $$ConcreteVolumetricWeightsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConcreteVolumetricWeightsTable,
    ConcreteVolumetricWeight,
    $$ConcreteVolumetricWeightsTableFilterComposer,
    $$ConcreteVolumetricWeightsTableOrderingComposer,
    $$ConcreteVolumetricWeightsTableProcessedTableManager,
    $$ConcreteVolumetricWeightsTableInsertCompanionBuilder,
    $$ConcreteVolumetricWeightsTableUpdateCompanionBuilder> {
  $$ConcreteVolumetricWeightsTableTableManager(
      _$AppDatabase db, $ConcreteVolumetricWeightsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ConcreteVolumetricWeightsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ConcreteVolumetricWeightsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ConcreteVolumetricWeightsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<double> tareWeightGr = const Value.absent(),
            Value<double> materialTareWeightGr = const Value.absent(),
            Value<double> materialWeightGr = const Value.absent(),
            Value<double> tareVolumeCm3 = const Value.absent(),
            Value<double> volumetricWeightGrCm3 = const Value.absent(),
            Value<double> volumeLoadM3 = const Value.absent(),
            Value<double> cementQuantityKg = const Value.absent(),
            Value<double> coarseAggregateKg = const Value.absent(),
            Value<double> fineAggregateKg = const Value.absent(),
            Value<double> waterKg = const Value.absent(),
            Value<String?> additives = const Value.absent(),
            Value<double> totalLoadKg = const Value.absent(),
            Value<double> totalLoadVolumetricWeightRelation =
                const Value.absent(),
            Value<double> percentage = const Value.absent(),
          }) =>
              ConcreteVolumetricWeightsCompanion(
            id: id,
            tareWeightGr: tareWeightGr,
            materialTareWeightGr: materialTareWeightGr,
            materialWeightGr: materialWeightGr,
            tareVolumeCm3: tareVolumeCm3,
            volumetricWeightGrCm3: volumetricWeightGrCm3,
            volumeLoadM3: volumeLoadM3,
            cementQuantityKg: cementQuantityKg,
            coarseAggregateKg: coarseAggregateKg,
            fineAggregateKg: fineAggregateKg,
            waterKg: waterKg,
            additives: additives,
            totalLoadKg: totalLoadKg,
            totalLoadVolumetricWeightRelation:
                totalLoadVolumetricWeightRelation,
            percentage: percentage,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required double tareWeightGr,
            required double materialTareWeightGr,
            required double materialWeightGr,
            required double tareVolumeCm3,
            required double volumetricWeightGrCm3,
            required double volumeLoadM3,
            required double cementQuantityKg,
            required double coarseAggregateKg,
            required double fineAggregateKg,
            required double waterKg,
            Value<String?> additives = const Value.absent(),
            required double totalLoadKg,
            required double totalLoadVolumetricWeightRelation,
            required double percentage,
          }) =>
              ConcreteVolumetricWeightsCompanion.insert(
            id: id,
            tareWeightGr: tareWeightGr,
            materialTareWeightGr: materialTareWeightGr,
            materialWeightGr: materialWeightGr,
            tareVolumeCm3: tareVolumeCm3,
            volumetricWeightGrCm3: volumetricWeightGrCm3,
            volumeLoadM3: volumeLoadM3,
            cementQuantityKg: cementQuantityKg,
            coarseAggregateKg: coarseAggregateKg,
            fineAggregateKg: fineAggregateKg,
            waterKg: waterKg,
            additives: additives,
            totalLoadKg: totalLoadKg,
            totalLoadVolumetricWeightRelation:
                totalLoadVolumetricWeightRelation,
            percentage: percentage,
          ),
        ));
}

class $$ConcreteVolumetricWeightsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ConcreteVolumetricWeightsTable,
        ConcreteVolumetricWeight,
        $$ConcreteVolumetricWeightsTableFilterComposer,
        $$ConcreteVolumetricWeightsTableOrderingComposer,
        $$ConcreteVolumetricWeightsTableProcessedTableManager,
        $$ConcreteVolumetricWeightsTableInsertCompanionBuilder,
        $$ConcreteVolumetricWeightsTableUpdateCompanionBuilder> {
  $$ConcreteVolumetricWeightsTableProcessedTableManager(super.$state);
}

class $$ConcreteVolumetricWeightsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ConcreteVolumetricWeightsTable> {
  $$ConcreteVolumetricWeightsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tareWeightGr => $state.composableBuilder(
      column: $state.table.tareWeightGr,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get materialTareWeightGr => $state.composableBuilder(
      column: $state.table.materialTareWeightGr,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get materialWeightGr => $state.composableBuilder(
      column: $state.table.materialWeightGr,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get tareVolumeCm3 => $state.composableBuilder(
      column: $state.table.tareVolumeCm3,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get volumetricWeightGrCm3 => $state.composableBuilder(
      column: $state.table.volumetricWeightGrCm3,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get volumeLoadM3 => $state.composableBuilder(
      column: $state.table.volumeLoadM3,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get cementQuantityKg => $state.composableBuilder(
      column: $state.table.cementQuantityKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get coarseAggregateKg => $state.composableBuilder(
      column: $state.table.coarseAggregateKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get fineAggregateKg => $state.composableBuilder(
      column: $state.table.fineAggregateKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get waterKg => $state.composableBuilder(
      column: $state.table.waterKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get additives => $state.composableBuilder(
      column: $state.table.additives,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalLoadKg => $state.composableBuilder(
      column: $state.table.totalLoadKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalLoadVolumetricWeightRelation =>
      $state.composableBuilder(
          column: $state.table.totalLoadVolumetricWeightRelation,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter concreteSamplesRefs(
      ComposableFilter Function($$ConcreteSamplesTableFilterComposer f) f) {
    final $$ConcreteSamplesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.concreteSamples,
            getReferencedColumn: (t) => t.concreteVolumetricWeightId,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteSamplesTableFilterComposer(ComposerState($state.db,
                    $state.db.concreteSamples, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ConcreteVolumetricWeightsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ConcreteVolumetricWeightsTable> {
  $$ConcreteVolumetricWeightsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tareWeightGr => $state.composableBuilder(
      column: $state.table.tareWeightGr,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get materialTareWeightGr => $state.composableBuilder(
      column: $state.table.materialTareWeightGr,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get materialWeightGr => $state.composableBuilder(
      column: $state.table.materialWeightGr,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get tareVolumeCm3 => $state.composableBuilder(
      column: $state.table.tareVolumeCm3,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get volumetricWeightGrCm3 => $state.composableBuilder(
      column: $state.table.volumetricWeightGrCm3,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get volumeLoadM3 => $state.composableBuilder(
      column: $state.table.volumeLoadM3,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get cementQuantityKg => $state.composableBuilder(
      column: $state.table.cementQuantityKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get coarseAggregateKg => $state.composableBuilder(
      column: $state.table.coarseAggregateKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get fineAggregateKg => $state.composableBuilder(
      column: $state.table.fineAggregateKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get waterKg => $state.composableBuilder(
      column: $state.table.waterKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get additives => $state.composableBuilder(
      column: $state.table.additives,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalLoadKg => $state.composableBuilder(
      column: $state.table.totalLoadKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalLoadVolumetricWeightRelation =>
      $state.composableBuilder(
          column: $state.table.totalLoadVolumetricWeightRelation,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ConcreteTestingOrdersTableInsertCompanionBuilder
    = ConcreteTestingOrdersCompanion Function({
  Value<int> id,
  required String designResistance,
  required int slumpingCm,
  required int totalVolumeM3,
  required int tmaMm,
  required String designAge,
  required DateTime testingDate,
  required int customerId,
  required int buildingSiteId,
  Value<int?> siteResidentId,
});
typedef $$ConcreteTestingOrdersTableUpdateCompanionBuilder
    = ConcreteTestingOrdersCompanion Function({
  Value<int> id,
  Value<String> designResistance,
  Value<int> slumpingCm,
  Value<int> totalVolumeM3,
  Value<int> tmaMm,
  Value<String> designAge,
  Value<DateTime> testingDate,
  Value<int> customerId,
  Value<int> buildingSiteId,
  Value<int?> siteResidentId,
});

class $$ConcreteTestingOrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConcreteTestingOrdersTable,
    ConcreteTestingOrder,
    $$ConcreteTestingOrdersTableFilterComposer,
    $$ConcreteTestingOrdersTableOrderingComposer,
    $$ConcreteTestingOrdersTableProcessedTableManager,
    $$ConcreteTestingOrdersTableInsertCompanionBuilder,
    $$ConcreteTestingOrdersTableUpdateCompanionBuilder> {
  $$ConcreteTestingOrdersTableTableManager(
      _$AppDatabase db, $ConcreteTestingOrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ConcreteTestingOrdersTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ConcreteTestingOrdersTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ConcreteTestingOrdersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> designResistance = const Value.absent(),
            Value<int> slumpingCm = const Value.absent(),
            Value<int> totalVolumeM3 = const Value.absent(),
            Value<int> tmaMm = const Value.absent(),
            Value<String> designAge = const Value.absent(),
            Value<DateTime> testingDate = const Value.absent(),
            Value<int> customerId = const Value.absent(),
            Value<int> buildingSiteId = const Value.absent(),
            Value<int?> siteResidentId = const Value.absent(),
          }) =>
              ConcreteTestingOrdersCompanion(
            id: id,
            designResistance: designResistance,
            slumpingCm: slumpingCm,
            totalVolumeM3: totalVolumeM3,
            tmaMm: tmaMm,
            designAge: designAge,
            testingDate: testingDate,
            customerId: customerId,
            buildingSiteId: buildingSiteId,
            siteResidentId: siteResidentId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String designResistance,
            required int slumpingCm,
            required int totalVolumeM3,
            required int tmaMm,
            required String designAge,
            required DateTime testingDate,
            required int customerId,
            required int buildingSiteId,
            Value<int?> siteResidentId = const Value.absent(),
          }) =>
              ConcreteTestingOrdersCompanion.insert(
            id: id,
            designResistance: designResistance,
            slumpingCm: slumpingCm,
            totalVolumeM3: totalVolumeM3,
            tmaMm: tmaMm,
            designAge: designAge,
            testingDate: testingDate,
            customerId: customerId,
            buildingSiteId: buildingSiteId,
            siteResidentId: siteResidentId,
          ),
        ));
}

class $$ConcreteTestingOrdersTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ConcreteTestingOrdersTable,
        ConcreteTestingOrder,
        $$ConcreteTestingOrdersTableFilterComposer,
        $$ConcreteTestingOrdersTableOrderingComposer,
        $$ConcreteTestingOrdersTableProcessedTableManager,
        $$ConcreteTestingOrdersTableInsertCompanionBuilder,
        $$ConcreteTestingOrdersTableUpdateCompanionBuilder> {
  $$ConcreteTestingOrdersTableProcessedTableManager(super.$state);
}

class $$ConcreteTestingOrdersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ConcreteTestingOrdersTable> {
  $$ConcreteTestingOrdersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get designResistance => $state.composableBuilder(
      column: $state.table.designResistance,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get slumpingCm => $state.composableBuilder(
      column: $state.table.slumpingCm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalVolumeM3 => $state.composableBuilder(
      column: $state.table.totalVolumeM3,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get tmaMm => $state.composableBuilder(
      column: $state.table.tmaMm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get designAge => $state.composableBuilder(
      column: $state.table.designAge,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get testingDate => $state.composableBuilder(
      column: $state.table.testingDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableFilterComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$BuildingSitesTableFilterComposer get buildingSiteId {
    final $$BuildingSitesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buildingSiteId,
        referencedTable: $state.db.buildingSites,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$BuildingSitesTableFilterComposer(ComposerState($state.db,
                $state.db.buildingSites, joinBuilder, parentComposers)));
    return composer;
  }

  $$SiteResidentsTableFilterComposer get siteResidentId {
    final $$SiteResidentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.siteResidentId,
        referencedTable: $state.db.siteResidents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SiteResidentsTableFilterComposer(ComposerState($state.db,
                $state.db.siteResidents, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter concreteSamplesRefs(
      ComposableFilter Function($$ConcreteSamplesTableFilterComposer f) f) {
    final $$ConcreteSamplesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.concreteSamples,
            getReferencedColumn: (t) => t.concreteTestingOrderId,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteSamplesTableFilterComposer(ComposerState($state.db,
                    $state.db.concreteSamples, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ConcreteTestingOrdersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ConcreteTestingOrdersTable> {
  $$ConcreteTestingOrdersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get designResistance => $state.composableBuilder(
      column: $state.table.designResistance,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get slumpingCm => $state.composableBuilder(
      column: $state.table.slumpingCm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalVolumeM3 => $state.composableBuilder(
      column: $state.table.totalVolumeM3,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get tmaMm => $state.composableBuilder(
      column: $state.table.tmaMm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get designAge => $state.composableBuilder(
      column: $state.table.designAge,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get testingDate => $state.composableBuilder(
      column: $state.table.testingDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableOrderingComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$BuildingSitesTableOrderingComposer get buildingSiteId {
    final $$BuildingSitesTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.buildingSiteId,
            referencedTable: $state.db.buildingSites,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$BuildingSitesTableOrderingComposer(ComposerState($state.db,
                    $state.db.buildingSites, joinBuilder, parentComposers)));
    return composer;
  }

  $$SiteResidentsTableOrderingComposer get siteResidentId {
    final $$SiteResidentsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.siteResidentId,
            referencedTable: $state.db.siteResidents,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$SiteResidentsTableOrderingComposer(ComposerState($state.db,
                    $state.db.siteResidents, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ConcreteSamplesTableInsertCompanionBuilder = ConcreteSamplesCompanion
    Function({
  Value<int> id,
  required String remission,
  required double volume,
  required String plantTime,
  required String buildingSiteTime,
  required double realSlumpingCm,
  required double temperatureCelsius,
  required String location,
  required int concreteTestingOrderId,
  Value<int?> concreteVolumetricWeightId,
});
typedef $$ConcreteSamplesTableUpdateCompanionBuilder = ConcreteSamplesCompanion
    Function({
  Value<int> id,
  Value<String> remission,
  Value<double> volume,
  Value<String> plantTime,
  Value<String> buildingSiteTime,
  Value<double> realSlumpingCm,
  Value<double> temperatureCelsius,
  Value<String> location,
  Value<int> concreteTestingOrderId,
  Value<int?> concreteVolumetricWeightId,
});

class $$ConcreteSamplesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConcreteSamplesTable,
    ConcreteSample,
    $$ConcreteSamplesTableFilterComposer,
    $$ConcreteSamplesTableOrderingComposer,
    $$ConcreteSamplesTableProcessedTableManager,
    $$ConcreteSamplesTableInsertCompanionBuilder,
    $$ConcreteSamplesTableUpdateCompanionBuilder> {
  $$ConcreteSamplesTableTableManager(
      _$AppDatabase db, $ConcreteSamplesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ConcreteSamplesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ConcreteSamplesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ConcreteSamplesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> remission = const Value.absent(),
            Value<double> volume = const Value.absent(),
            Value<String> plantTime = const Value.absent(),
            Value<String> buildingSiteTime = const Value.absent(),
            Value<double> realSlumpingCm = const Value.absent(),
            Value<double> temperatureCelsius = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<int> concreteTestingOrderId = const Value.absent(),
            Value<int?> concreteVolumetricWeightId = const Value.absent(),
          }) =>
              ConcreteSamplesCompanion(
            id: id,
            remission: remission,
            volume: volume,
            plantTime: plantTime,
            buildingSiteTime: buildingSiteTime,
            realSlumpingCm: realSlumpingCm,
            temperatureCelsius: temperatureCelsius,
            location: location,
            concreteTestingOrderId: concreteTestingOrderId,
            concreteVolumetricWeightId: concreteVolumetricWeightId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String remission,
            required double volume,
            required String plantTime,
            required String buildingSiteTime,
            required double realSlumpingCm,
            required double temperatureCelsius,
            required String location,
            required int concreteTestingOrderId,
            Value<int?> concreteVolumetricWeightId = const Value.absent(),
          }) =>
              ConcreteSamplesCompanion.insert(
            id: id,
            remission: remission,
            volume: volume,
            plantTime: plantTime,
            buildingSiteTime: buildingSiteTime,
            realSlumpingCm: realSlumpingCm,
            temperatureCelsius: temperatureCelsius,
            location: location,
            concreteTestingOrderId: concreteTestingOrderId,
            concreteVolumetricWeightId: concreteVolumetricWeightId,
          ),
        ));
}

class $$ConcreteSamplesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $ConcreteSamplesTable,
    ConcreteSample,
    $$ConcreteSamplesTableFilterComposer,
    $$ConcreteSamplesTableOrderingComposer,
    $$ConcreteSamplesTableProcessedTableManager,
    $$ConcreteSamplesTableInsertCompanionBuilder,
    $$ConcreteSamplesTableUpdateCompanionBuilder> {
  $$ConcreteSamplesTableProcessedTableManager(super.$state);
}

class $$ConcreteSamplesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ConcreteSamplesTable> {
  $$ConcreteSamplesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get remission => $state.composableBuilder(
      column: $state.table.remission,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get volume => $state.composableBuilder(
      column: $state.table.volume,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get plantTime => $state.composableBuilder(
      column: $state.table.plantTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get buildingSiteTime => $state.composableBuilder(
      column: $state.table.buildingSiteTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get realSlumpingCm => $state.composableBuilder(
      column: $state.table.realSlumpingCm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get temperatureCelsius => $state.composableBuilder(
      column: $state.table.temperatureCelsius,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ConcreteTestingOrdersTableFilterComposer get concreteTestingOrderId {
    final $$ConcreteTestingOrdersTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.concreteTestingOrderId,
            referencedTable: $state.db.concreteTestingOrders,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteTestingOrdersTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.concreteTestingOrders,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }

  $$ConcreteVolumetricWeightsTableFilterComposer
      get concreteVolumetricWeightId {
    final $$ConcreteVolumetricWeightsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.concreteVolumetricWeightId,
            referencedTable: $state.db.concreteVolumetricWeights,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteVolumetricWeightsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.concreteVolumetricWeights,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }

  ComposableFilter concreteCylindersRefs(
      ComposableFilter Function($$ConcreteCylindersTableFilterComposer f) f) {
    final $$ConcreteCylindersTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.concreteCylinders,
            getReferencedColumn: (t) => t.concreteSampleId,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteCylindersTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.concreteCylinders,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$ConcreteSamplesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ConcreteSamplesTable> {
  $$ConcreteSamplesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get remission => $state.composableBuilder(
      column: $state.table.remission,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get volume => $state.composableBuilder(
      column: $state.table.volume,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get plantTime => $state.composableBuilder(
      column: $state.table.plantTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get buildingSiteTime => $state.composableBuilder(
      column: $state.table.buildingSiteTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get realSlumpingCm => $state.composableBuilder(
      column: $state.table.realSlumpingCm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get temperatureCelsius => $state.composableBuilder(
      column: $state.table.temperatureCelsius,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ConcreteTestingOrdersTableOrderingComposer get concreteTestingOrderId {
    final $$ConcreteTestingOrdersTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.concreteTestingOrderId,
            referencedTable: $state.db.concreteTestingOrders,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteTestingOrdersTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.concreteTestingOrders,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }

  $$ConcreteVolumetricWeightsTableOrderingComposer
      get concreteVolumetricWeightId {
    final $$ConcreteVolumetricWeightsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.concreteVolumetricWeightId,
            referencedTable: $state.db.concreteVolumetricWeights,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteVolumetricWeightsTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.concreteVolumetricWeights,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

typedef $$ConcreteCylindersTableInsertCompanionBuilder
    = ConcreteCylindersCompanion Function({
  Value<int> id,
  required int buildingSiteSampleNumber,
  required int testingAgeDays,
  required int testingDate,
  Value<double?> totalLoadKg,
  Value<double?> diameterCm,
  Value<double?> resistanceKgfCm2,
  Value<double?> median,
  Value<double?> percentage,
  required int concreteSampleId,
});
typedef $$ConcreteCylindersTableUpdateCompanionBuilder
    = ConcreteCylindersCompanion Function({
  Value<int> id,
  Value<int> buildingSiteSampleNumber,
  Value<int> testingAgeDays,
  Value<int> testingDate,
  Value<double?> totalLoadKg,
  Value<double?> diameterCm,
  Value<double?> resistanceKgfCm2,
  Value<double?> median,
  Value<double?> percentage,
  Value<int> concreteSampleId,
});

class $$ConcreteCylindersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConcreteCylindersTable,
    ConcreteCylinder,
    $$ConcreteCylindersTableFilterComposer,
    $$ConcreteCylindersTableOrderingComposer,
    $$ConcreteCylindersTableProcessedTableManager,
    $$ConcreteCylindersTableInsertCompanionBuilder,
    $$ConcreteCylindersTableUpdateCompanionBuilder> {
  $$ConcreteCylindersTableTableManager(
      _$AppDatabase db, $ConcreteCylindersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ConcreteCylindersTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$ConcreteCylindersTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ConcreteCylindersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> buildingSiteSampleNumber = const Value.absent(),
            Value<int> testingAgeDays = const Value.absent(),
            Value<int> testingDate = const Value.absent(),
            Value<double?> totalLoadKg = const Value.absent(),
            Value<double?> diameterCm = const Value.absent(),
            Value<double?> resistanceKgfCm2 = const Value.absent(),
            Value<double?> median = const Value.absent(),
            Value<double?> percentage = const Value.absent(),
            Value<int> concreteSampleId = const Value.absent(),
          }) =>
              ConcreteCylindersCompanion(
            id: id,
            buildingSiteSampleNumber: buildingSiteSampleNumber,
            testingAgeDays: testingAgeDays,
            testingDate: testingDate,
            totalLoadKg: totalLoadKg,
            diameterCm: diameterCm,
            resistanceKgfCm2: resistanceKgfCm2,
            median: median,
            percentage: percentage,
            concreteSampleId: concreteSampleId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int buildingSiteSampleNumber,
            required int testingAgeDays,
            required int testingDate,
            Value<double?> totalLoadKg = const Value.absent(),
            Value<double?> diameterCm = const Value.absent(),
            Value<double?> resistanceKgfCm2 = const Value.absent(),
            Value<double?> median = const Value.absent(),
            Value<double?> percentage = const Value.absent(),
            required int concreteSampleId,
          }) =>
              ConcreteCylindersCompanion.insert(
            id: id,
            buildingSiteSampleNumber: buildingSiteSampleNumber,
            testingAgeDays: testingAgeDays,
            testingDate: testingDate,
            totalLoadKg: totalLoadKg,
            diameterCm: diameterCm,
            resistanceKgfCm2: resistanceKgfCm2,
            median: median,
            percentage: percentage,
            concreteSampleId: concreteSampleId,
          ),
        ));
}

class $$ConcreteCylindersTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ConcreteCylindersTable,
        ConcreteCylinder,
        $$ConcreteCylindersTableFilterComposer,
        $$ConcreteCylindersTableOrderingComposer,
        $$ConcreteCylindersTableProcessedTableManager,
        $$ConcreteCylindersTableInsertCompanionBuilder,
        $$ConcreteCylindersTableUpdateCompanionBuilder> {
  $$ConcreteCylindersTableProcessedTableManager(super.$state);
}

class $$ConcreteCylindersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ConcreteCylindersTable> {
  $$ConcreteCylindersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get buildingSiteSampleNumber => $state.composableBuilder(
      column: $state.table.buildingSiteSampleNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get testingAgeDays => $state.composableBuilder(
      column: $state.table.testingAgeDays,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get testingDate => $state.composableBuilder(
      column: $state.table.testingDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalLoadKg => $state.composableBuilder(
      column: $state.table.totalLoadKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get diameterCm => $state.composableBuilder(
      column: $state.table.diameterCm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get resistanceKgfCm2 => $state.composableBuilder(
      column: $state.table.resistanceKgfCm2,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get median => $state.composableBuilder(
      column: $state.table.median,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ConcreteSamplesTableFilterComposer get concreteSampleId {
    final $$ConcreteSamplesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.concreteSampleId,
            referencedTable: $state.db.concreteSamples,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteSamplesTableFilterComposer(ComposerState($state.db,
                    $state.db.concreteSamples, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ConcreteCylindersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ConcreteCylindersTable> {
  $$ConcreteCylindersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get buildingSiteSampleNumber => $state.composableBuilder(
      column: $state.table.buildingSiteSampleNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get testingAgeDays => $state.composableBuilder(
      column: $state.table.testingAgeDays,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get testingDate => $state.composableBuilder(
      column: $state.table.testingDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalLoadKg => $state.composableBuilder(
      column: $state.table.totalLoadKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get diameterCm => $state.composableBuilder(
      column: $state.table.diameterCm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get resistanceKgfCm2 => $state.composableBuilder(
      column: $state.table.resistanceKgfCm2,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get median => $state.composableBuilder(
      column: $state.table.median,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ConcreteSamplesTableOrderingComposer get concreteSampleId {
    final $$ConcreteSamplesTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.concreteSampleId,
            referencedTable: $state.db.concreteSamples,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ConcreteSamplesTableOrderingComposer(ComposerState($state.db,
                    $state.db.concreteSamples, joinBuilder, parentComposers)));
    return composer;
  }
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$SiteResidentsTableTableManager get siteResidents =>
      $$SiteResidentsTableTableManager(_db, _db.siteResidents);
  $$BuildingSitesTableTableManager get buildingSites =>
      $$BuildingSitesTableTableManager(_db, _db.buildingSites);
  $$ConcreteVolumetricWeightsTableTableManager get concreteVolumetricWeights =>
      $$ConcreteVolumetricWeightsTableTableManager(
          _db, _db.concreteVolumetricWeights);
  $$ConcreteTestingOrdersTableTableManager get concreteTestingOrders =>
      $$ConcreteTestingOrdersTableTableManager(_db, _db.concreteTestingOrders);
  $$ConcreteSamplesTableTableManager get concreteSamples =>
      $$ConcreteSamplesTableTableManager(_db, _db.concreteSamples);
  $$ConcreteCylindersTableTableManager get concreteCylinders =>
      $$ConcreteCylindersTableTableManager(_db, _db.concreteCylinders);
}
