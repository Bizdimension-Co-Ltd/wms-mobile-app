// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rememberMeta =
      const VerificationMeta('remember');
  @override
  late final GeneratedColumn<String> remember = GeneratedColumn<String>(
      'remember', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<int> isDefault = GeneratedColumn<int>(
      'is_default', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, password, remember, isDefault, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_table';
  @override
  VerificationContext validateIntegrity(Insertable<UsersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('remember')) {
      context.handle(_rememberMeta,
          remember.isAcceptableOrUnknown(data['remember']!, _rememberMeta));
    } else if (isInserting) {
      context.missing(_rememberMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      remember: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remember'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  final int id;
  final String username;
  final String password;
  final String remember;
  final int isDefault;
  final DateTime? createdAt;
  const UsersTableData(
      {required this.id,
      required this.username,
      required this.password,
      required this.remember,
      required this.isDefault,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['remember'] = Variable<String>(remember);
    map['is_default'] = Variable<int>(isDefault);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      remember: Value(remember),
      isDefault: Value(isDefault),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory UsersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      remember: serializer.fromJson<String>(json['remember']),
      isDefault: serializer.fromJson<int>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'remember': serializer.toJson<String>(remember),
      'isDefault': serializer.toJson<int>(isDefault),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  UsersTableData copyWith(
          {int? id,
          String? username,
          String? password,
          String? remember,
          int? isDefault,
          Value<DateTime?> createdAt = const Value.absent()}) =>
      UsersTableData(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        remember: remember ?? this.remember,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      remember: data.remember.present ? data.remember.value : this.remember,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('remember: $remember, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, username, password, remember, isDefault, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.remember == this.remember &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> remember;
  final Value<int> isDefault;
  final Value<DateTime?> createdAt;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.remember = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersTableCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    required String remember,
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : username = Value(username),
        password = Value(password),
        remember = Value(remember);
  static Insertable<UsersTableData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? remember,
    Expression<int>? isDefault,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (remember != null) 'remember': remember,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<String>? remember,
      Value<int>? isDefault,
      Value<DateTime?>? createdAt}) {
    return UsersTableCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      remember: remember ?? this.remember,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (remember.present) {
      map['remember'] = Variable<String>(remember.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<int>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('remember: $remember, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BranchTableTable extends BranchTable
    with TableInfo<$BranchTableTable, BranchTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<int> branchId = GeneratedColumn<int>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<int> isDefault = GeneratedColumn<int>(
      'is_default', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, branchId, name, isDefault, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branch_table';
  @override
  VerificationContext validateIntegrity(Insertable<BranchTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BranchTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BranchTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}branch_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $BranchTableTable createAlias(String alias) {
    return $BranchTableTable(attachedDatabase, alias);
  }
}

class BranchTableData extends DataClass implements Insertable<BranchTableData> {
  final int id;
  final int branchId;
  final String name;
  final int isDefault;
  final DateTime? createdAt;
  const BranchTableData(
      {required this.id,
      required this.branchId,
      required this.name,
      required this.isDefault,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['branch_id'] = Variable<int>(branchId);
    map['name'] = Variable<String>(name);
    map['is_default'] = Variable<int>(isDefault);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  BranchTableCompanion toCompanion(bool nullToAbsent) {
    return BranchTableCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      isDefault: Value(isDefault),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory BranchTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BranchTableData(
      id: serializer.fromJson<int>(json['id']),
      branchId: serializer.fromJson<int>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      isDefault: serializer.fromJson<int>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'branchId': serializer.toJson<int>(branchId),
      'name': serializer.toJson<String>(name),
      'isDefault': serializer.toJson<int>(isDefault),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  BranchTableData copyWith(
          {int? id,
          int? branchId,
          String? name,
          int? isDefault,
          Value<DateTime?> createdAt = const Value.absent()}) =>
      BranchTableData(
        id: id ?? this.id,
        branchId: branchId ?? this.branchId,
        name: name ?? this.name,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  BranchTableData copyWithCompanion(BranchTableCompanion data) {
    return BranchTableData(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BranchTableData(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, branchId, name, isDefault, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BranchTableData &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt);
}

class BranchTableCompanion extends UpdateCompanion<BranchTableData> {
  final Value<int> id;
  final Value<int> branchId;
  final Value<String> name;
  final Value<int> isDefault;
  final Value<DateTime?> createdAt;
  const BranchTableCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BranchTableCompanion.insert({
    this.id = const Value.absent(),
    required int branchId,
    required String name,
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : branchId = Value(branchId),
        name = Value(name);
  static Insertable<BranchTableData> custom({
    Expression<int>? id,
    Expression<int>? branchId,
    Expression<String>? name,
    Expression<int>? isDefault,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BranchTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? branchId,
      Value<String>? name,
      Value<int>? isDefault,
      Value<DateTime?>? createdAt}) {
    return BranchTableCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<int>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<int>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchTableCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WarehouseTableTable extends WarehouseTable
    with TableInfo<$WarehouseTableTable, WarehouseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WarehouseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<int> isDefault = GeneratedColumn<int>(
      'is_default', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<int> branchId = GeneratedColumn<int>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _businessPlaceIDMeta =
      const VerificationMeta('businessPlaceID');
  @override
  late final GeneratedColumn<int> businessPlaceID = GeneratedColumn<int>(
      'business_place_i_d', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _defaultBinMeta =
      const VerificationMeta('defaultBin');
  @override
  late final GeneratedColumn<String> defaultBin = GeneratedColumn<String>(
      'default_bin', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _enableBinLocationMeta =
      const VerificationMeta('enableBinLocation');
  @override
  late final GeneratedColumn<String> enableBinLocation =
      GeneratedColumn<String>('enable_bin_location', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant("tNO"));
  static const VerificationMeta _inactiveMeta =
      const VerificationMeta('inactive');
  @override
  late final GeneratedColumn<String> inactive = GeneratedColumn<String>(
      'inactive', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _branchMeta = const VerificationMeta('branch');
  @override
  late final GeneratedColumn<int> branch = GeneratedColumn<int>(
      'branch', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES branch_table (branch_id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        name,
        isDefault,
        branchId,
        businessPlaceID,
        defaultBin,
        enableBinLocation,
        inactive,
        createdAt,
        branch
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'warehouse_table';
  @override
  VerificationContext validateIntegrity(Insertable<WarehouseTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    }
    if (data.containsKey('business_place_i_d')) {
      context.handle(
          _businessPlaceIDMeta,
          businessPlaceID.isAcceptableOrUnknown(
              data['business_place_i_d']!, _businessPlaceIDMeta));
    }
    if (data.containsKey('default_bin')) {
      context.handle(
          _defaultBinMeta,
          defaultBin.isAcceptableOrUnknown(
              data['default_bin']!, _defaultBinMeta));
    }
    if (data.containsKey('enable_bin_location')) {
      context.handle(
          _enableBinLocationMeta,
          enableBinLocation.isAcceptableOrUnknown(
              data['enable_bin_location']!, _enableBinLocationMeta));
    }
    if (data.containsKey('inactive')) {
      context.handle(_inactiveMeta,
          inactive.isAcceptableOrUnknown(data['inactive']!, _inactiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('branch')) {
      context.handle(_branchMeta,
          branch.isAcceptableOrUnknown(data['branch']!, _branchMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WarehouseTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WarehouseTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_default'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}branch_id'])!,
      businessPlaceID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}business_place_i_d']),
      defaultBin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}default_bin']),
      enableBinLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}enable_bin_location']),
      inactive: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}inactive']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      branch: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}branch']),
    );
  }

  @override
  $WarehouseTableTable createAlias(String alias) {
    return $WarehouseTableTable(attachedDatabase, alias);
  }
}

class WarehouseTableData extends DataClass
    implements Insertable<WarehouseTableData> {
  final int id;
  final String code;
  final String name;
  final int isDefault;
  final int branchId;
  final int? businessPlaceID;
  final String? defaultBin;
  final String? enableBinLocation;
  final String? inactive;
  final DateTime? createdAt;
  final int? branch;
  const WarehouseTableData(
      {required this.id,
      required this.code,
      required this.name,
      required this.isDefault,
      required this.branchId,
      this.businessPlaceID,
      this.defaultBin,
      this.enableBinLocation,
      this.inactive,
      this.createdAt,
      this.branch});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['is_default'] = Variable<int>(isDefault);
    map['branch_id'] = Variable<int>(branchId);
    if (!nullToAbsent || businessPlaceID != null) {
      map['business_place_i_d'] = Variable<int>(businessPlaceID);
    }
    if (!nullToAbsent || defaultBin != null) {
      map['default_bin'] = Variable<String>(defaultBin);
    }
    if (!nullToAbsent || enableBinLocation != null) {
      map['enable_bin_location'] = Variable<String>(enableBinLocation);
    }
    if (!nullToAbsent || inactive != null) {
      map['inactive'] = Variable<String>(inactive);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || branch != null) {
      map['branch'] = Variable<int>(branch);
    }
    return map;
  }

  WarehouseTableCompanion toCompanion(bool nullToAbsent) {
    return WarehouseTableCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      isDefault: Value(isDefault),
      branchId: Value(branchId),
      businessPlaceID: businessPlaceID == null && nullToAbsent
          ? const Value.absent()
          : Value(businessPlaceID),
      defaultBin: defaultBin == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultBin),
      enableBinLocation: enableBinLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(enableBinLocation),
      inactive: inactive == null && nullToAbsent
          ? const Value.absent()
          : Value(inactive),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      branch:
          branch == null && nullToAbsent ? const Value.absent() : Value(branch),
    );
  }

  factory WarehouseTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WarehouseTableData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      isDefault: serializer.fromJson<int>(json['isDefault']),
      branchId: serializer.fromJson<int>(json['branchId']),
      businessPlaceID: serializer.fromJson<int?>(json['businessPlaceID']),
      defaultBin: serializer.fromJson<String?>(json['defaultBin']),
      enableBinLocation:
          serializer.fromJson<String?>(json['enableBinLocation']),
      inactive: serializer.fromJson<String?>(json['inactive']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      branch: serializer.fromJson<int?>(json['branch']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'isDefault': serializer.toJson<int>(isDefault),
      'branchId': serializer.toJson<int>(branchId),
      'businessPlaceID': serializer.toJson<int?>(businessPlaceID),
      'defaultBin': serializer.toJson<String?>(defaultBin),
      'enableBinLocation': serializer.toJson<String?>(enableBinLocation),
      'inactive': serializer.toJson<String?>(inactive),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'branch': serializer.toJson<int?>(branch),
    };
  }

  WarehouseTableData copyWith(
          {int? id,
          String? code,
          String? name,
          int? isDefault,
          int? branchId,
          Value<int?> businessPlaceID = const Value.absent(),
          Value<String?> defaultBin = const Value.absent(),
          Value<String?> enableBinLocation = const Value.absent(),
          Value<String?> inactive = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<int?> branch = const Value.absent()}) =>
      WarehouseTableData(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        isDefault: isDefault ?? this.isDefault,
        branchId: branchId ?? this.branchId,
        businessPlaceID: businessPlaceID.present
            ? businessPlaceID.value
            : this.businessPlaceID,
        defaultBin: defaultBin.present ? defaultBin.value : this.defaultBin,
        enableBinLocation: enableBinLocation.present
            ? enableBinLocation.value
            : this.enableBinLocation,
        inactive: inactive.present ? inactive.value : this.inactive,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        branch: branch.present ? branch.value : this.branch,
      );
  WarehouseTableData copyWithCompanion(WarehouseTableCompanion data) {
    return WarehouseTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      businessPlaceID: data.businessPlaceID.present
          ? data.businessPlaceID.value
          : this.businessPlaceID,
      defaultBin:
          data.defaultBin.present ? data.defaultBin.value : this.defaultBin,
      enableBinLocation: data.enableBinLocation.present
          ? data.enableBinLocation.value
          : this.enableBinLocation,
      inactive: data.inactive.present ? data.inactive.value : this.inactive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      branch: data.branch.present ? data.branch.value : this.branch,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WarehouseTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('branchId: $branchId, ')
          ..write('businessPlaceID: $businessPlaceID, ')
          ..write('defaultBin: $defaultBin, ')
          ..write('enableBinLocation: $enableBinLocation, ')
          ..write('inactive: $inactive, ')
          ..write('createdAt: $createdAt, ')
          ..write('branch: $branch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      code,
      name,
      isDefault,
      branchId,
      businessPlaceID,
      defaultBin,
      enableBinLocation,
      inactive,
      createdAt,
      branch);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WarehouseTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.isDefault == this.isDefault &&
          other.branchId == this.branchId &&
          other.businessPlaceID == this.businessPlaceID &&
          other.defaultBin == this.defaultBin &&
          other.enableBinLocation == this.enableBinLocation &&
          other.inactive == this.inactive &&
          other.createdAt == this.createdAt &&
          other.branch == this.branch);
}

class WarehouseTableCompanion extends UpdateCompanion<WarehouseTableData> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> isDefault;
  final Value<int> branchId;
  final Value<int?> businessPlaceID;
  final Value<String?> defaultBin;
  final Value<String?> enableBinLocation;
  final Value<String?> inactive;
  final Value<DateTime?> createdAt;
  final Value<int?> branch;
  const WarehouseTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.branchId = const Value.absent(),
    this.businessPlaceID = const Value.absent(),
    this.defaultBin = const Value.absent(),
    this.enableBinLocation = const Value.absent(),
    this.inactive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.branch = const Value.absent(),
  });
  WarehouseTableCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.isDefault = const Value.absent(),
    this.branchId = const Value.absent(),
    this.businessPlaceID = const Value.absent(),
    this.defaultBin = const Value.absent(),
    this.enableBinLocation = const Value.absent(),
    this.inactive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.branch = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<WarehouseTableData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? isDefault,
    Expression<int>? branchId,
    Expression<int>? businessPlaceID,
    Expression<String>? defaultBin,
    Expression<String>? enableBinLocation,
    Expression<String>? inactive,
    Expression<DateTime>? createdAt,
    Expression<int>? branch,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (isDefault != null) 'is_default': isDefault,
      if (branchId != null) 'branch_id': branchId,
      if (businessPlaceID != null) 'business_place_i_d': businessPlaceID,
      if (defaultBin != null) 'default_bin': defaultBin,
      if (enableBinLocation != null) 'enable_bin_location': enableBinLocation,
      if (inactive != null) 'inactive': inactive,
      if (createdAt != null) 'created_at': createdAt,
      if (branch != null) 'branch': branch,
    });
  }

  WarehouseTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? name,
      Value<int>? isDefault,
      Value<int>? branchId,
      Value<int?>? businessPlaceID,
      Value<String?>? defaultBin,
      Value<String?>? enableBinLocation,
      Value<String?>? inactive,
      Value<DateTime?>? createdAt,
      Value<int?>? branch}) {
    return WarehouseTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      branchId: branchId ?? this.branchId,
      businessPlaceID: businessPlaceID ?? this.businessPlaceID,
      defaultBin: defaultBin ?? this.defaultBin,
      enableBinLocation: enableBinLocation ?? this.enableBinLocation,
      inactive: inactive ?? this.inactive,
      createdAt: createdAt ?? this.createdAt,
      branch: branch ?? this.branch,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<int>(isDefault.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<int>(branchId.value);
    }
    if (businessPlaceID.present) {
      map['business_place_i_d'] = Variable<int>(businessPlaceID.value);
    }
    if (defaultBin.present) {
      map['default_bin'] = Variable<String>(defaultBin.value);
    }
    if (enableBinLocation.present) {
      map['enable_bin_location'] = Variable<String>(enableBinLocation.value);
    }
    if (inactive.present) {
      map['inactive'] = Variable<String>(inactive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (branch.present) {
      map['branch'] = Variable<int>(branch.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WarehouseTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('branchId: $branchId, ')
          ..write('businessPlaceID: $businessPlaceID, ')
          ..write('defaultBin: $defaultBin, ')
          ..write('enableBinLocation: $enableBinLocation, ')
          ..write('inactive: $inactive, ')
          ..write('createdAt: $createdAt, ')
          ..write('branch: $branch')
          ..write(')'))
        .toString();
  }
}

class $BinLocationTableTable extends BinLocationTable
    with TableInfo<$BinLocationTableTable, BinLocationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BinLocationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _absEntryMeta =
      const VerificationMeta('absEntry');
  @override
  late final GeneratedColumn<int> absEntry = GeneratedColumn<int>(
      'abs_entry', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _binCodeMeta =
      const VerificationMeta('binCode');
  @override
  late final GeneratedColumn<String> binCode = GeneratedColumn<String>(
      'bin_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<int> isDefault = GeneratedColumn<int>(
      'is_default', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isSystemBinMeta =
      const VerificationMeta('isSystemBin');
  @override
  late final GeneratedColumn<String> isSystemBin = GeneratedColumn<String>(
      'is_system_bin', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _warehouseCodeMeta =
      const VerificationMeta('warehouseCode');
  @override
  late final GeneratedColumn<String> warehouseCode = GeneratedColumn<String>(
      'warehouse_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _batchRestrictionsMeta =
      const VerificationMeta('batchRestrictions');
  @override
  late final GeneratedColumn<String> batchRestrictions =
      GeneratedColumn<String>('batch_restrictions', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _warehouseMeta =
      const VerificationMeta('warehouse');
  @override
  late final GeneratedColumn<String> warehouse = GeneratedColumn<String>(
      'warehouse', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES warehouse_table (code)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        absEntry,
        binCode,
        isDefault,
        isSystemBin,
        warehouseCode,
        createdAt,
        batchRestrictions,
        warehouse
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bin_location_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<BinLocationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('abs_entry')) {
      context.handle(_absEntryMeta,
          absEntry.isAcceptableOrUnknown(data['abs_entry']!, _absEntryMeta));
    } else if (isInserting) {
      context.missing(_absEntryMeta);
    }
    if (data.containsKey('bin_code')) {
      context.handle(_binCodeMeta,
          binCode.isAcceptableOrUnknown(data['bin_code']!, _binCodeMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('is_system_bin')) {
      context.handle(
          _isSystemBinMeta,
          isSystemBin.isAcceptableOrUnknown(
              data['is_system_bin']!, _isSystemBinMeta));
    }
    if (data.containsKey('warehouse_code')) {
      context.handle(
          _warehouseCodeMeta,
          warehouseCode.isAcceptableOrUnknown(
              data['warehouse_code']!, _warehouseCodeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('batch_restrictions')) {
      context.handle(
          _batchRestrictionsMeta,
          batchRestrictions.isAcceptableOrUnknown(
              data['batch_restrictions']!, _batchRestrictionsMeta));
    }
    if (data.containsKey('warehouse')) {
      context.handle(_warehouseMeta,
          warehouse.isAcceptableOrUnknown(data['warehouse']!, _warehouseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BinLocationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BinLocationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      absEntry: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}abs_entry'])!,
      binCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bin_code']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_default']),
      isSystemBin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}is_system_bin']),
      warehouseCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_code']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      batchRestrictions: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}batch_restrictions']),
      warehouse: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse']),
    );
  }

  @override
  $BinLocationTableTable createAlias(String alias) {
    return $BinLocationTableTable(attachedDatabase, alias);
  }
}

class BinLocationTableData extends DataClass
    implements Insertable<BinLocationTableData> {
  final int id;
  final int absEntry;
  final String? binCode;
  final int? isDefault;
  final String? isSystemBin;
  final String? warehouseCode;
  final DateTime? createdAt;
  final String? batchRestrictions;
  final String? warehouse;
  const BinLocationTableData(
      {required this.id,
      required this.absEntry,
      this.binCode,
      this.isDefault,
      this.isSystemBin,
      this.warehouseCode,
      this.createdAt,
      this.batchRestrictions,
      this.warehouse});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['abs_entry'] = Variable<int>(absEntry);
    if (!nullToAbsent || binCode != null) {
      map['bin_code'] = Variable<String>(binCode);
    }
    if (!nullToAbsent || isDefault != null) {
      map['is_default'] = Variable<int>(isDefault);
    }
    if (!nullToAbsent || isSystemBin != null) {
      map['is_system_bin'] = Variable<String>(isSystemBin);
    }
    if (!nullToAbsent || warehouseCode != null) {
      map['warehouse_code'] = Variable<String>(warehouseCode);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || batchRestrictions != null) {
      map['batch_restrictions'] = Variable<String>(batchRestrictions);
    }
    if (!nullToAbsent || warehouse != null) {
      map['warehouse'] = Variable<String>(warehouse);
    }
    return map;
  }

  BinLocationTableCompanion toCompanion(bool nullToAbsent) {
    return BinLocationTableCompanion(
      id: Value(id),
      absEntry: Value(absEntry),
      binCode: binCode == null && nullToAbsent
          ? const Value.absent()
          : Value(binCode),
      isDefault: isDefault == null && nullToAbsent
          ? const Value.absent()
          : Value(isDefault),
      isSystemBin: isSystemBin == null && nullToAbsent
          ? const Value.absent()
          : Value(isSystemBin),
      warehouseCode: warehouseCode == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseCode),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      batchRestrictions: batchRestrictions == null && nullToAbsent
          ? const Value.absent()
          : Value(batchRestrictions),
      warehouse: warehouse == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouse),
    );
  }

  factory BinLocationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BinLocationTableData(
      id: serializer.fromJson<int>(json['id']),
      absEntry: serializer.fromJson<int>(json['absEntry']),
      binCode: serializer.fromJson<String?>(json['binCode']),
      isDefault: serializer.fromJson<int?>(json['isDefault']),
      isSystemBin: serializer.fromJson<String?>(json['isSystemBin']),
      warehouseCode: serializer.fromJson<String?>(json['warehouseCode']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      batchRestrictions:
          serializer.fromJson<String?>(json['batchRestrictions']),
      warehouse: serializer.fromJson<String?>(json['warehouse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'absEntry': serializer.toJson<int>(absEntry),
      'binCode': serializer.toJson<String?>(binCode),
      'isDefault': serializer.toJson<int?>(isDefault),
      'isSystemBin': serializer.toJson<String?>(isSystemBin),
      'warehouseCode': serializer.toJson<String?>(warehouseCode),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'batchRestrictions': serializer.toJson<String?>(batchRestrictions),
      'warehouse': serializer.toJson<String?>(warehouse),
    };
  }

  BinLocationTableData copyWith(
          {int? id,
          int? absEntry,
          Value<String?> binCode = const Value.absent(),
          Value<int?> isDefault = const Value.absent(),
          Value<String?> isSystemBin = const Value.absent(),
          Value<String?> warehouseCode = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> batchRestrictions = const Value.absent(),
          Value<String?> warehouse = const Value.absent()}) =>
      BinLocationTableData(
        id: id ?? this.id,
        absEntry: absEntry ?? this.absEntry,
        binCode: binCode.present ? binCode.value : this.binCode,
        isDefault: isDefault.present ? isDefault.value : this.isDefault,
        isSystemBin: isSystemBin.present ? isSystemBin.value : this.isSystemBin,
        warehouseCode:
            warehouseCode.present ? warehouseCode.value : this.warehouseCode,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        batchRestrictions: batchRestrictions.present
            ? batchRestrictions.value
            : this.batchRestrictions,
        warehouse: warehouse.present ? warehouse.value : this.warehouse,
      );
  BinLocationTableData copyWithCompanion(BinLocationTableCompanion data) {
    return BinLocationTableData(
      id: data.id.present ? data.id.value : this.id,
      absEntry: data.absEntry.present ? data.absEntry.value : this.absEntry,
      binCode: data.binCode.present ? data.binCode.value : this.binCode,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isSystemBin:
          data.isSystemBin.present ? data.isSystemBin.value : this.isSystemBin,
      warehouseCode: data.warehouseCode.present
          ? data.warehouseCode.value
          : this.warehouseCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      batchRestrictions: data.batchRestrictions.present
          ? data.batchRestrictions.value
          : this.batchRestrictions,
      warehouse: data.warehouse.present ? data.warehouse.value : this.warehouse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BinLocationTableData(')
          ..write('id: $id, ')
          ..write('absEntry: $absEntry, ')
          ..write('binCode: $binCode, ')
          ..write('isDefault: $isDefault, ')
          ..write('isSystemBin: $isSystemBin, ')
          ..write('warehouseCode: $warehouseCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('batchRestrictions: $batchRestrictions, ')
          ..write('warehouse: $warehouse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, absEntry, binCode, isDefault, isSystemBin,
      warehouseCode, createdAt, batchRestrictions, warehouse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BinLocationTableData &&
          other.id == this.id &&
          other.absEntry == this.absEntry &&
          other.binCode == this.binCode &&
          other.isDefault == this.isDefault &&
          other.isSystemBin == this.isSystemBin &&
          other.warehouseCode == this.warehouseCode &&
          other.createdAt == this.createdAt &&
          other.batchRestrictions == this.batchRestrictions &&
          other.warehouse == this.warehouse);
}

class BinLocationTableCompanion extends UpdateCompanion<BinLocationTableData> {
  final Value<int> id;
  final Value<int> absEntry;
  final Value<String?> binCode;
  final Value<int?> isDefault;
  final Value<String?> isSystemBin;
  final Value<String?> warehouseCode;
  final Value<DateTime?> createdAt;
  final Value<String?> batchRestrictions;
  final Value<String?> warehouse;
  const BinLocationTableCompanion({
    this.id = const Value.absent(),
    this.absEntry = const Value.absent(),
    this.binCode = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isSystemBin = const Value.absent(),
    this.warehouseCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.batchRestrictions = const Value.absent(),
    this.warehouse = const Value.absent(),
  });
  BinLocationTableCompanion.insert({
    this.id = const Value.absent(),
    required int absEntry,
    this.binCode = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isSystemBin = const Value.absent(),
    this.warehouseCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.batchRestrictions = const Value.absent(),
    this.warehouse = const Value.absent(),
  }) : absEntry = Value(absEntry);
  static Insertable<BinLocationTableData> custom({
    Expression<int>? id,
    Expression<int>? absEntry,
    Expression<String>? binCode,
    Expression<int>? isDefault,
    Expression<String>? isSystemBin,
    Expression<String>? warehouseCode,
    Expression<DateTime>? createdAt,
    Expression<String>? batchRestrictions,
    Expression<String>? warehouse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (absEntry != null) 'abs_entry': absEntry,
      if (binCode != null) 'bin_code': binCode,
      if (isDefault != null) 'is_default': isDefault,
      if (isSystemBin != null) 'is_system_bin': isSystemBin,
      if (warehouseCode != null) 'warehouse_code': warehouseCode,
      if (createdAt != null) 'created_at': createdAt,
      if (batchRestrictions != null) 'batch_restrictions': batchRestrictions,
      if (warehouse != null) 'warehouse': warehouse,
    });
  }

  BinLocationTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? absEntry,
      Value<String?>? binCode,
      Value<int?>? isDefault,
      Value<String?>? isSystemBin,
      Value<String?>? warehouseCode,
      Value<DateTime?>? createdAt,
      Value<String?>? batchRestrictions,
      Value<String?>? warehouse}) {
    return BinLocationTableCompanion(
      id: id ?? this.id,
      absEntry: absEntry ?? this.absEntry,
      binCode: binCode ?? this.binCode,
      isDefault: isDefault ?? this.isDefault,
      isSystemBin: isSystemBin ?? this.isSystemBin,
      warehouseCode: warehouseCode ?? this.warehouseCode,
      createdAt: createdAt ?? this.createdAt,
      batchRestrictions: batchRestrictions ?? this.batchRestrictions,
      warehouse: warehouse ?? this.warehouse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (absEntry.present) {
      map['abs_entry'] = Variable<int>(absEntry.value);
    }
    if (binCode.present) {
      map['bin_code'] = Variable<String>(binCode.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<int>(isDefault.value);
    }
    if (isSystemBin.present) {
      map['is_system_bin'] = Variable<String>(isSystemBin.value);
    }
    if (warehouseCode.present) {
      map['warehouse_code'] = Variable<String>(warehouseCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (batchRestrictions.present) {
      map['batch_restrictions'] = Variable<String>(batchRestrictions.value);
    }
    if (warehouse.present) {
      map['warehouse'] = Variable<String>(warehouse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BinLocationTableCompanion(')
          ..write('id: $id, ')
          ..write('absEntry: $absEntry, ')
          ..write('binCode: $binCode, ')
          ..write('isDefault: $isDefault, ')
          ..write('isSystemBin: $isSystemBin, ')
          ..write('warehouseCode: $warehouseCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('batchRestrictions: $batchRestrictions, ')
          ..write('warehouse: $warehouse')
          ..write(')'))
        .toString();
  }
}

class $ItemTableTable extends ItemTable
    with TableInfo<$ItemTableTable, ItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uoMGroupEntryMeta =
      const VerificationMeta('uoMGroupEntry');
  @override
  late final GeneratedColumn<int> uoMGroupEntry = GeneratedColumn<int>(
      'uo_m_group_entry', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _inventoryUOMMeta =
      const VerificationMeta('inventoryUOM');
  @override
  late final GeneratedColumn<String> inventoryUOM = GeneratedColumn<String>(
      'inventory_u_o_m', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iunventoryUoMEntryMeta =
      const VerificationMeta('iunventoryUoMEntry');
  @override
  late final GeneratedColumn<int> iunventoryUoMEntry = GeneratedColumn<int>(
      'iunventory_uo_m_entry', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _purchaseItemMeta =
      const VerificationMeta('purchaseItem');
  @override
  late final GeneratedColumn<String> purchaseItem = GeneratedColumn<String>(
      'purchase_item', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _saleItemMeta =
      const VerificationMeta('saleItem');
  @override
  late final GeneratedColumn<String> saleItem = GeneratedColumn<String>(
      'sale_item', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _inventoryItemMeta =
      const VerificationMeta('inventoryItem');
  @override
  late final GeneratedColumn<String> inventoryItem = GeneratedColumn<String>(
      'inventory_item', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isManageBatchMeta =
      const VerificationMeta('isManageBatch');
  @override
  late final GeneratedColumn<String> isManageBatch = GeneratedColumn<String>(
      'is_manage_batch', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isManageSerialMeta =
      const VerificationMeta('isManageSerial');
  @override
  late final GeneratedColumn<String> isManageSerial = GeneratedColumn<String>(
      'is_manage_serial', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uoMGroupDefinitionCollectionMeta =
      const VerificationMeta('uoMGroupDefinitionCollection');
  @override
  late final GeneratedColumn<String> uoMGroupDefinitionCollection =
      GeneratedColumn<String>(
          'uo_m_group_definition_collection', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        name,
        uoMGroupEntry,
        inventoryUOM,
        iunventoryUoMEntry,
        purchaseItem,
        saleItem,
        inventoryItem,
        isManageBatch,
        isManageSerial,
        uoMGroupDefinitionCollection,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_table';
  @override
  VerificationContext validateIntegrity(Insertable<ItemTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('uo_m_group_entry')) {
      context.handle(
          _uoMGroupEntryMeta,
          uoMGroupEntry.isAcceptableOrUnknown(
              data['uo_m_group_entry']!, _uoMGroupEntryMeta));
    }
    if (data.containsKey('inventory_u_o_m')) {
      context.handle(
          _inventoryUOMMeta,
          inventoryUOM.isAcceptableOrUnknown(
              data['inventory_u_o_m']!, _inventoryUOMMeta));
    }
    if (data.containsKey('iunventory_uo_m_entry')) {
      context.handle(
          _iunventoryUoMEntryMeta,
          iunventoryUoMEntry.isAcceptableOrUnknown(
              data['iunventory_uo_m_entry']!, _iunventoryUoMEntryMeta));
    }
    if (data.containsKey('purchase_item')) {
      context.handle(
          _purchaseItemMeta,
          purchaseItem.isAcceptableOrUnknown(
              data['purchase_item']!, _purchaseItemMeta));
    }
    if (data.containsKey('sale_item')) {
      context.handle(_saleItemMeta,
          saleItem.isAcceptableOrUnknown(data['sale_item']!, _saleItemMeta));
    }
    if (data.containsKey('inventory_item')) {
      context.handle(
          _inventoryItemMeta,
          inventoryItem.isAcceptableOrUnknown(
              data['inventory_item']!, _inventoryItemMeta));
    }
    if (data.containsKey('is_manage_batch')) {
      context.handle(
          _isManageBatchMeta,
          isManageBatch.isAcceptableOrUnknown(
              data['is_manage_batch']!, _isManageBatchMeta));
    }
    if (data.containsKey('is_manage_serial')) {
      context.handle(
          _isManageSerialMeta,
          isManageSerial.isAcceptableOrUnknown(
              data['is_manage_serial']!, _isManageSerialMeta));
    }
    if (data.containsKey('uo_m_group_definition_collection')) {
      context.handle(
          _uoMGroupDefinitionCollectionMeta,
          uoMGroupDefinitionCollection.isAcceptableOrUnknown(
              data['uo_m_group_definition_collection']!,
              _uoMGroupDefinitionCollectionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      uoMGroupEntry: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uo_m_group_entry']),
      inventoryUOM: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}inventory_u_o_m']),
      iunventoryUoMEntry: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}iunventory_uo_m_entry']),
      purchaseItem: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}purchase_item']),
      saleItem: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_item']),
      inventoryItem: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}inventory_item']),
      isManageBatch: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}is_manage_batch']),
      isManageSerial: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}is_manage_serial']),
      uoMGroupDefinitionCollection: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}uo_m_group_definition_collection']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $ItemTableTable createAlias(String alias) {
    return $ItemTableTable(attachedDatabase, alias);
  }
}

class ItemTableData extends DataClass implements Insertable<ItemTableData> {
  final int id;
  final String code;
  final String name;
  final int? uoMGroupEntry;
  final String? inventoryUOM;
  final int? iunventoryUoMEntry;
  final String? purchaseItem;
  final String? saleItem;
  final String? inventoryItem;
  final String? isManageBatch;
  final String? isManageSerial;
  final String? uoMGroupDefinitionCollection;
  final DateTime? createdAt;
  const ItemTableData(
      {required this.id,
      required this.code,
      required this.name,
      this.uoMGroupEntry,
      this.inventoryUOM,
      this.iunventoryUoMEntry,
      this.purchaseItem,
      this.saleItem,
      this.inventoryItem,
      this.isManageBatch,
      this.isManageSerial,
      this.uoMGroupDefinitionCollection,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || uoMGroupEntry != null) {
      map['uo_m_group_entry'] = Variable<int>(uoMGroupEntry);
    }
    if (!nullToAbsent || inventoryUOM != null) {
      map['inventory_u_o_m'] = Variable<String>(inventoryUOM);
    }
    if (!nullToAbsent || iunventoryUoMEntry != null) {
      map['iunventory_uo_m_entry'] = Variable<int>(iunventoryUoMEntry);
    }
    if (!nullToAbsent || purchaseItem != null) {
      map['purchase_item'] = Variable<String>(purchaseItem);
    }
    if (!nullToAbsent || saleItem != null) {
      map['sale_item'] = Variable<String>(saleItem);
    }
    if (!nullToAbsent || inventoryItem != null) {
      map['inventory_item'] = Variable<String>(inventoryItem);
    }
    if (!nullToAbsent || isManageBatch != null) {
      map['is_manage_batch'] = Variable<String>(isManageBatch);
    }
    if (!nullToAbsent || isManageSerial != null) {
      map['is_manage_serial'] = Variable<String>(isManageSerial);
    }
    if (!nullToAbsent || uoMGroupDefinitionCollection != null) {
      map['uo_m_group_definition_collection'] =
          Variable<String>(uoMGroupDefinitionCollection);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  ItemTableCompanion toCompanion(bool nullToAbsent) {
    return ItemTableCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      uoMGroupEntry: uoMGroupEntry == null && nullToAbsent
          ? const Value.absent()
          : Value(uoMGroupEntry),
      inventoryUOM: inventoryUOM == null && nullToAbsent
          ? const Value.absent()
          : Value(inventoryUOM),
      iunventoryUoMEntry: iunventoryUoMEntry == null && nullToAbsent
          ? const Value.absent()
          : Value(iunventoryUoMEntry),
      purchaseItem: purchaseItem == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseItem),
      saleItem: saleItem == null && nullToAbsent
          ? const Value.absent()
          : Value(saleItem),
      inventoryItem: inventoryItem == null && nullToAbsent
          ? const Value.absent()
          : Value(inventoryItem),
      isManageBatch: isManageBatch == null && nullToAbsent
          ? const Value.absent()
          : Value(isManageBatch),
      isManageSerial: isManageSerial == null && nullToAbsent
          ? const Value.absent()
          : Value(isManageSerial),
      uoMGroupDefinitionCollection:
          uoMGroupDefinitionCollection == null && nullToAbsent
              ? const Value.absent()
              : Value(uoMGroupDefinitionCollection),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory ItemTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemTableData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      uoMGroupEntry: serializer.fromJson<int?>(json['uoMGroupEntry']),
      inventoryUOM: serializer.fromJson<String?>(json['inventoryUOM']),
      iunventoryUoMEntry: serializer.fromJson<int?>(json['iunventoryUoMEntry']),
      purchaseItem: serializer.fromJson<String?>(json['purchaseItem']),
      saleItem: serializer.fromJson<String?>(json['saleItem']),
      inventoryItem: serializer.fromJson<String?>(json['inventoryItem']),
      isManageBatch: serializer.fromJson<String?>(json['isManageBatch']),
      isManageSerial: serializer.fromJson<String?>(json['isManageSerial']),
      uoMGroupDefinitionCollection:
          serializer.fromJson<String?>(json['uoMGroupDefinitionCollection']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'uoMGroupEntry': serializer.toJson<int?>(uoMGroupEntry),
      'inventoryUOM': serializer.toJson<String?>(inventoryUOM),
      'iunventoryUoMEntry': serializer.toJson<int?>(iunventoryUoMEntry),
      'purchaseItem': serializer.toJson<String?>(purchaseItem),
      'saleItem': serializer.toJson<String?>(saleItem),
      'inventoryItem': serializer.toJson<String?>(inventoryItem),
      'isManageBatch': serializer.toJson<String?>(isManageBatch),
      'isManageSerial': serializer.toJson<String?>(isManageSerial),
      'uoMGroupDefinitionCollection':
          serializer.toJson<String?>(uoMGroupDefinitionCollection),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  ItemTableData copyWith(
          {int? id,
          String? code,
          String? name,
          Value<int?> uoMGroupEntry = const Value.absent(),
          Value<String?> inventoryUOM = const Value.absent(),
          Value<int?> iunventoryUoMEntry = const Value.absent(),
          Value<String?> purchaseItem = const Value.absent(),
          Value<String?> saleItem = const Value.absent(),
          Value<String?> inventoryItem = const Value.absent(),
          Value<String?> isManageBatch = const Value.absent(),
          Value<String?> isManageSerial = const Value.absent(),
          Value<String?> uoMGroupDefinitionCollection = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      ItemTableData(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        uoMGroupEntry:
            uoMGroupEntry.present ? uoMGroupEntry.value : this.uoMGroupEntry,
        inventoryUOM:
            inventoryUOM.present ? inventoryUOM.value : this.inventoryUOM,
        iunventoryUoMEntry: iunventoryUoMEntry.present
            ? iunventoryUoMEntry.value
            : this.iunventoryUoMEntry,
        purchaseItem:
            purchaseItem.present ? purchaseItem.value : this.purchaseItem,
        saleItem: saleItem.present ? saleItem.value : this.saleItem,
        inventoryItem:
            inventoryItem.present ? inventoryItem.value : this.inventoryItem,
        isManageBatch:
            isManageBatch.present ? isManageBatch.value : this.isManageBatch,
        isManageSerial:
            isManageSerial.present ? isManageSerial.value : this.isManageSerial,
        uoMGroupDefinitionCollection: uoMGroupDefinitionCollection.present
            ? uoMGroupDefinitionCollection.value
            : this.uoMGroupDefinitionCollection,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  ItemTableData copyWithCompanion(ItemTableCompanion data) {
    return ItemTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      uoMGroupEntry: data.uoMGroupEntry.present
          ? data.uoMGroupEntry.value
          : this.uoMGroupEntry,
      inventoryUOM: data.inventoryUOM.present
          ? data.inventoryUOM.value
          : this.inventoryUOM,
      iunventoryUoMEntry: data.iunventoryUoMEntry.present
          ? data.iunventoryUoMEntry.value
          : this.iunventoryUoMEntry,
      purchaseItem: data.purchaseItem.present
          ? data.purchaseItem.value
          : this.purchaseItem,
      saleItem: data.saleItem.present ? data.saleItem.value : this.saleItem,
      inventoryItem: data.inventoryItem.present
          ? data.inventoryItem.value
          : this.inventoryItem,
      isManageBatch: data.isManageBatch.present
          ? data.isManageBatch.value
          : this.isManageBatch,
      isManageSerial: data.isManageSerial.present
          ? data.isManageSerial.value
          : this.isManageSerial,
      uoMGroupDefinitionCollection: data.uoMGroupDefinitionCollection.present
          ? data.uoMGroupDefinitionCollection.value
          : this.uoMGroupDefinitionCollection,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('uoMGroupEntry: $uoMGroupEntry, ')
          ..write('inventoryUOM: $inventoryUOM, ')
          ..write('iunventoryUoMEntry: $iunventoryUoMEntry, ')
          ..write('purchaseItem: $purchaseItem, ')
          ..write('saleItem: $saleItem, ')
          ..write('inventoryItem: $inventoryItem, ')
          ..write('isManageBatch: $isManageBatch, ')
          ..write('isManageSerial: $isManageSerial, ')
          ..write(
              'uoMGroupDefinitionCollection: $uoMGroupDefinitionCollection, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      code,
      name,
      uoMGroupEntry,
      inventoryUOM,
      iunventoryUoMEntry,
      purchaseItem,
      saleItem,
      inventoryItem,
      isManageBatch,
      isManageSerial,
      uoMGroupDefinitionCollection,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.uoMGroupEntry == this.uoMGroupEntry &&
          other.inventoryUOM == this.inventoryUOM &&
          other.iunventoryUoMEntry == this.iunventoryUoMEntry &&
          other.purchaseItem == this.purchaseItem &&
          other.saleItem == this.saleItem &&
          other.inventoryItem == this.inventoryItem &&
          other.isManageBatch == this.isManageBatch &&
          other.isManageSerial == this.isManageSerial &&
          other.uoMGroupDefinitionCollection ==
              this.uoMGroupDefinitionCollection &&
          other.createdAt == this.createdAt);
}

class ItemTableCompanion extends UpdateCompanion<ItemTableData> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int?> uoMGroupEntry;
  final Value<String?> inventoryUOM;
  final Value<int?> iunventoryUoMEntry;
  final Value<String?> purchaseItem;
  final Value<String?> saleItem;
  final Value<String?> inventoryItem;
  final Value<String?> isManageBatch;
  final Value<String?> isManageSerial;
  final Value<String?> uoMGroupDefinitionCollection;
  final Value<DateTime?> createdAt;
  const ItemTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.uoMGroupEntry = const Value.absent(),
    this.inventoryUOM = const Value.absent(),
    this.iunventoryUoMEntry = const Value.absent(),
    this.purchaseItem = const Value.absent(),
    this.saleItem = const Value.absent(),
    this.inventoryItem = const Value.absent(),
    this.isManageBatch = const Value.absent(),
    this.isManageSerial = const Value.absent(),
    this.uoMGroupDefinitionCollection = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ItemTableCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.uoMGroupEntry = const Value.absent(),
    this.inventoryUOM = const Value.absent(),
    this.iunventoryUoMEntry = const Value.absent(),
    this.purchaseItem = const Value.absent(),
    this.saleItem = const Value.absent(),
    this.inventoryItem = const Value.absent(),
    this.isManageBatch = const Value.absent(),
    this.isManageSerial = const Value.absent(),
    this.uoMGroupDefinitionCollection = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<ItemTableData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? uoMGroupEntry,
    Expression<String>? inventoryUOM,
    Expression<int>? iunventoryUoMEntry,
    Expression<String>? purchaseItem,
    Expression<String>? saleItem,
    Expression<String>? inventoryItem,
    Expression<String>? isManageBatch,
    Expression<String>? isManageSerial,
    Expression<String>? uoMGroupDefinitionCollection,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (uoMGroupEntry != null) 'uo_m_group_entry': uoMGroupEntry,
      if (inventoryUOM != null) 'inventory_u_o_m': inventoryUOM,
      if (iunventoryUoMEntry != null)
        'iunventory_uo_m_entry': iunventoryUoMEntry,
      if (purchaseItem != null) 'purchase_item': purchaseItem,
      if (saleItem != null) 'sale_item': saleItem,
      if (inventoryItem != null) 'inventory_item': inventoryItem,
      if (isManageBatch != null) 'is_manage_batch': isManageBatch,
      if (isManageSerial != null) 'is_manage_serial': isManageSerial,
      if (uoMGroupDefinitionCollection != null)
        'uo_m_group_definition_collection': uoMGroupDefinitionCollection,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ItemTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? name,
      Value<int?>? uoMGroupEntry,
      Value<String?>? inventoryUOM,
      Value<int?>? iunventoryUoMEntry,
      Value<String?>? purchaseItem,
      Value<String?>? saleItem,
      Value<String?>? inventoryItem,
      Value<String?>? isManageBatch,
      Value<String?>? isManageSerial,
      Value<String?>? uoMGroupDefinitionCollection,
      Value<DateTime?>? createdAt}) {
    return ItemTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      uoMGroupEntry: uoMGroupEntry ?? this.uoMGroupEntry,
      inventoryUOM: inventoryUOM ?? this.inventoryUOM,
      iunventoryUoMEntry: iunventoryUoMEntry ?? this.iunventoryUoMEntry,
      purchaseItem: purchaseItem ?? this.purchaseItem,
      saleItem: saleItem ?? this.saleItem,
      inventoryItem: inventoryItem ?? this.inventoryItem,
      isManageBatch: isManageBatch ?? this.isManageBatch,
      isManageSerial: isManageSerial ?? this.isManageSerial,
      uoMGroupDefinitionCollection:
          uoMGroupDefinitionCollection ?? this.uoMGroupDefinitionCollection,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (uoMGroupEntry.present) {
      map['uo_m_group_entry'] = Variable<int>(uoMGroupEntry.value);
    }
    if (inventoryUOM.present) {
      map['inventory_u_o_m'] = Variable<String>(inventoryUOM.value);
    }
    if (iunventoryUoMEntry.present) {
      map['iunventory_uo_m_entry'] = Variable<int>(iunventoryUoMEntry.value);
    }
    if (purchaseItem.present) {
      map['purchase_item'] = Variable<String>(purchaseItem.value);
    }
    if (saleItem.present) {
      map['sale_item'] = Variable<String>(saleItem.value);
    }
    if (inventoryItem.present) {
      map['inventory_item'] = Variable<String>(inventoryItem.value);
    }
    if (isManageBatch.present) {
      map['is_manage_batch'] = Variable<String>(isManageBatch.value);
    }
    if (isManageSerial.present) {
      map['is_manage_serial'] = Variable<String>(isManageSerial.value);
    }
    if (uoMGroupDefinitionCollection.present) {
      map['uo_m_group_definition_collection'] =
          Variable<String>(uoMGroupDefinitionCollection.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('uoMGroupEntry: $uoMGroupEntry, ')
          ..write('inventoryUOM: $inventoryUOM, ')
          ..write('iunventoryUoMEntry: $iunventoryUoMEntry, ')
          ..write('purchaseItem: $purchaseItem, ')
          ..write('saleItem: $saleItem, ')
          ..write('inventoryItem: $inventoryItem, ')
          ..write('isManageBatch: $isManageBatch, ')
          ..write('isManageSerial: $isManageSerial, ')
          ..write(
              'uoMGroupDefinitionCollection: $uoMGroupDefinitionCollection, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UnitOfMeasurementTableTable extends UnitOfMeasurementTable
    with TableInfo<$UnitOfMeasurementTableTable, UnitOfMeasurementTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitOfMeasurementTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uoMGroupEntryMeta =
      const VerificationMeta('uoMGroupEntry');
  @override
  late final GeneratedColumn<int> uoMGroupEntry = GeneratedColumn<int>(
      'uo_m_group_entry', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _absEntryMeta =
      const VerificationMeta('absEntry');
  @override
  late final GeneratedColumn<int> absEntry = GeneratedColumn<int>(
      'abs_entry', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _alternateUoMMeta =
      const VerificationMeta('alternateUoM');
  @override
  late final GeneratedColumn<int> alternateUoM = GeneratedColumn<int>(
      'alternate_uo_m', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _alternateQuantityMeta =
      const VerificationMeta('alternateQuantity');
  @override
  late final GeneratedColumn<double> alternateQuantity =
      GeneratedColumn<double>('alternate_quantity', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _baseQuantityMeta =
      const VerificationMeta('baseQuantity');
  @override
  late final GeneratedColumn<double> baseQuantity = GeneratedColumn<double>(
      'base_quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<int> isDefault = GeneratedColumn<int>(
      'is_default', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uoMGroupEntry,
        absEntry,
        alternateUoM,
        alternateQuantity,
        baseQuantity,
        code,
        name,
        isDefault,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unit_of_measurement_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UnitOfMeasurementTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uo_m_group_entry')) {
      context.handle(
          _uoMGroupEntryMeta,
          uoMGroupEntry.isAcceptableOrUnknown(
              data['uo_m_group_entry']!, _uoMGroupEntryMeta));
    }
    if (data.containsKey('abs_entry')) {
      context.handle(_absEntryMeta,
          absEntry.isAcceptableOrUnknown(data['abs_entry']!, _absEntryMeta));
    } else if (isInserting) {
      context.missing(_absEntryMeta);
    }
    if (data.containsKey('alternate_uo_m')) {
      context.handle(
          _alternateUoMMeta,
          alternateUoM.isAcceptableOrUnknown(
              data['alternate_uo_m']!, _alternateUoMMeta));
    } else if (isInserting) {
      context.missing(_alternateUoMMeta);
    }
    if (data.containsKey('alternate_quantity')) {
      context.handle(
          _alternateQuantityMeta,
          alternateQuantity.isAcceptableOrUnknown(
              data['alternate_quantity']!, _alternateQuantityMeta));
    }
    if (data.containsKey('base_quantity')) {
      context.handle(
          _baseQuantityMeta,
          baseQuantity.isAcceptableOrUnknown(
              data['base_quantity']!, _baseQuantityMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnitOfMeasurementTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitOfMeasurementTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uoMGroupEntry: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uo_m_group_entry']),
      absEntry: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}abs_entry'])!,
      alternateUoM: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}alternate_uo_m'])!,
      alternateQuantity: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}alternate_quantity']),
      baseQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}base_quantity']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $UnitOfMeasurementTableTable createAlias(String alias) {
    return $UnitOfMeasurementTableTable(attachedDatabase, alias);
  }
}

class UnitOfMeasurementTableData extends DataClass
    implements Insertable<UnitOfMeasurementTableData> {
  final int id;
  final int? uoMGroupEntry;
  final int absEntry;
  final int alternateUoM;
  final double? alternateQuantity;
  final double? baseQuantity;
  final String code;
  final String name;
  final int isDefault;
  final DateTime? createdAt;
  const UnitOfMeasurementTableData(
      {required this.id,
      this.uoMGroupEntry,
      required this.absEntry,
      required this.alternateUoM,
      this.alternateQuantity,
      this.baseQuantity,
      required this.code,
      required this.name,
      required this.isDefault,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || uoMGroupEntry != null) {
      map['uo_m_group_entry'] = Variable<int>(uoMGroupEntry);
    }
    map['abs_entry'] = Variable<int>(absEntry);
    map['alternate_uo_m'] = Variable<int>(alternateUoM);
    if (!nullToAbsent || alternateQuantity != null) {
      map['alternate_quantity'] = Variable<double>(alternateQuantity);
    }
    if (!nullToAbsent || baseQuantity != null) {
      map['base_quantity'] = Variable<double>(baseQuantity);
    }
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['is_default'] = Variable<int>(isDefault);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  UnitOfMeasurementTableCompanion toCompanion(bool nullToAbsent) {
    return UnitOfMeasurementTableCompanion(
      id: Value(id),
      uoMGroupEntry: uoMGroupEntry == null && nullToAbsent
          ? const Value.absent()
          : Value(uoMGroupEntry),
      absEntry: Value(absEntry),
      alternateUoM: Value(alternateUoM),
      alternateQuantity: alternateQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(alternateQuantity),
      baseQuantity: baseQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(baseQuantity),
      code: Value(code),
      name: Value(name),
      isDefault: Value(isDefault),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory UnitOfMeasurementTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitOfMeasurementTableData(
      id: serializer.fromJson<int>(json['id']),
      uoMGroupEntry: serializer.fromJson<int?>(json['uoMGroupEntry']),
      absEntry: serializer.fromJson<int>(json['absEntry']),
      alternateUoM: serializer.fromJson<int>(json['alternateUoM']),
      alternateQuantity:
          serializer.fromJson<double?>(json['alternateQuantity']),
      baseQuantity: serializer.fromJson<double?>(json['baseQuantity']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      isDefault: serializer.fromJson<int>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uoMGroupEntry': serializer.toJson<int?>(uoMGroupEntry),
      'absEntry': serializer.toJson<int>(absEntry),
      'alternateUoM': serializer.toJson<int>(alternateUoM),
      'alternateQuantity': serializer.toJson<double?>(alternateQuantity),
      'baseQuantity': serializer.toJson<double?>(baseQuantity),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'isDefault': serializer.toJson<int>(isDefault),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  UnitOfMeasurementTableData copyWith(
          {int? id,
          Value<int?> uoMGroupEntry = const Value.absent(),
          int? absEntry,
          int? alternateUoM,
          Value<double?> alternateQuantity = const Value.absent(),
          Value<double?> baseQuantity = const Value.absent(),
          String? code,
          String? name,
          int? isDefault,
          Value<DateTime?> createdAt = const Value.absent()}) =>
      UnitOfMeasurementTableData(
        id: id ?? this.id,
        uoMGroupEntry:
            uoMGroupEntry.present ? uoMGroupEntry.value : this.uoMGroupEntry,
        absEntry: absEntry ?? this.absEntry,
        alternateUoM: alternateUoM ?? this.alternateUoM,
        alternateQuantity: alternateQuantity.present
            ? alternateQuantity.value
            : this.alternateQuantity,
        baseQuantity:
            baseQuantity.present ? baseQuantity.value : this.baseQuantity,
        code: code ?? this.code,
        name: name ?? this.name,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  UnitOfMeasurementTableData copyWithCompanion(
      UnitOfMeasurementTableCompanion data) {
    return UnitOfMeasurementTableData(
      id: data.id.present ? data.id.value : this.id,
      uoMGroupEntry: data.uoMGroupEntry.present
          ? data.uoMGroupEntry.value
          : this.uoMGroupEntry,
      absEntry: data.absEntry.present ? data.absEntry.value : this.absEntry,
      alternateUoM: data.alternateUoM.present
          ? data.alternateUoM.value
          : this.alternateUoM,
      alternateQuantity: data.alternateQuantity.present
          ? data.alternateQuantity.value
          : this.alternateQuantity,
      baseQuantity: data.baseQuantity.present
          ? data.baseQuantity.value
          : this.baseQuantity,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitOfMeasurementTableData(')
          ..write('id: $id, ')
          ..write('uoMGroupEntry: $uoMGroupEntry, ')
          ..write('absEntry: $absEntry, ')
          ..write('alternateUoM: $alternateUoM, ')
          ..write('alternateQuantity: $alternateQuantity, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uoMGroupEntry, absEntry, alternateUoM,
      alternateQuantity, baseQuantity, code, name, isDefault, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitOfMeasurementTableData &&
          other.id == this.id &&
          other.uoMGroupEntry == this.uoMGroupEntry &&
          other.absEntry == this.absEntry &&
          other.alternateUoM == this.alternateUoM &&
          other.alternateQuantity == this.alternateQuantity &&
          other.baseQuantity == this.baseQuantity &&
          other.code == this.code &&
          other.name == this.name &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt);
}

class UnitOfMeasurementTableCompanion
    extends UpdateCompanion<UnitOfMeasurementTableData> {
  final Value<int> id;
  final Value<int?> uoMGroupEntry;
  final Value<int> absEntry;
  final Value<int> alternateUoM;
  final Value<double?> alternateQuantity;
  final Value<double?> baseQuantity;
  final Value<String> code;
  final Value<String> name;
  final Value<int> isDefault;
  final Value<DateTime?> createdAt;
  const UnitOfMeasurementTableCompanion({
    this.id = const Value.absent(),
    this.uoMGroupEntry = const Value.absent(),
    this.absEntry = const Value.absent(),
    this.alternateUoM = const Value.absent(),
    this.alternateQuantity = const Value.absent(),
    this.baseQuantity = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UnitOfMeasurementTableCompanion.insert({
    this.id = const Value.absent(),
    this.uoMGroupEntry = const Value.absent(),
    required int absEntry,
    required int alternateUoM,
    this.alternateQuantity = const Value.absent(),
    this.baseQuantity = const Value.absent(),
    required String code,
    required String name,
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : absEntry = Value(absEntry),
        alternateUoM = Value(alternateUoM),
        code = Value(code),
        name = Value(name);
  static Insertable<UnitOfMeasurementTableData> custom({
    Expression<int>? id,
    Expression<int>? uoMGroupEntry,
    Expression<int>? absEntry,
    Expression<int>? alternateUoM,
    Expression<double>? alternateQuantity,
    Expression<double>? baseQuantity,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? isDefault,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uoMGroupEntry != null) 'uo_m_group_entry': uoMGroupEntry,
      if (absEntry != null) 'abs_entry': absEntry,
      if (alternateUoM != null) 'alternate_uo_m': alternateUoM,
      if (alternateQuantity != null) 'alternate_quantity': alternateQuantity,
      if (baseQuantity != null) 'base_quantity': baseQuantity,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UnitOfMeasurementTableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? uoMGroupEntry,
      Value<int>? absEntry,
      Value<int>? alternateUoM,
      Value<double?>? alternateQuantity,
      Value<double?>? baseQuantity,
      Value<String>? code,
      Value<String>? name,
      Value<int>? isDefault,
      Value<DateTime?>? createdAt}) {
    return UnitOfMeasurementTableCompanion(
      id: id ?? this.id,
      uoMGroupEntry: uoMGroupEntry ?? this.uoMGroupEntry,
      absEntry: absEntry ?? this.absEntry,
      alternateUoM: alternateUoM ?? this.alternateUoM,
      alternateQuantity: alternateQuantity ?? this.alternateQuantity,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      code: code ?? this.code,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uoMGroupEntry.present) {
      map['uo_m_group_entry'] = Variable<int>(uoMGroupEntry.value);
    }
    if (absEntry.present) {
      map['abs_entry'] = Variable<int>(absEntry.value);
    }
    if (alternateUoM.present) {
      map['alternate_uo_m'] = Variable<int>(alternateUoM.value);
    }
    if (alternateQuantity.present) {
      map['alternate_quantity'] = Variable<double>(alternateQuantity.value);
    }
    if (baseQuantity.present) {
      map['base_quantity'] = Variable<double>(baseQuantity.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<int>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitOfMeasurementTableCompanion(')
          ..write('id: $id, ')
          ..write('uoMGroupEntry: $uoMGroupEntry, ')
          ..write('absEntry: $absEntry, ')
          ..write('alternateUoM: $alternateUoM, ')
          ..write('alternateQuantity: $alternateQuantity, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $BranchTableTable branchTable = $BranchTableTable(this);
  late final $WarehouseTableTable warehouseTable = $WarehouseTableTable(this);
  late final $BinLocationTableTable binLocationTable =
      $BinLocationTableTable(this);
  late final $ItemTableTable itemTable = $ItemTableTable(this);
  late final $UnitOfMeasurementTableTable unitOfMeasurementTable =
      $UnitOfMeasurementTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        usersTable,
        branchTable,
        warehouseTable,
        binLocationTable,
        itemTable,
        unitOfMeasurementTable
      ];
}

typedef $$UsersTableTableCreateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  required String username,
  required String password,
  required String remember,
  Value<int> isDefault,
  Value<DateTime?> createdAt,
});
typedef $$UsersTableTableUpdateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> password,
  Value<String> remember,
  Value<int> isDefault,
  Value<DateTime?> createdAt,
});

class $$UsersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get remember => $state.composableBuilder(
      column: $state.table.remember,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get remember => $state.composableBuilder(
      column: $state.table.remember,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$UsersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (
      UsersTableData,
      BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>
    ),
    UsersTableData,
    PrefetchHooks Function()> {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<String> remember = const Value.absent(),
            Value<int> isDefault = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              UsersTableCompanion(
            id: id,
            username: username,
            password: password,
            remember: remember,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String password,
            required String remember,
            Value<int> isDefault = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              UsersTableCompanion.insert(
            id: id,
            username: username,
            password: password,
            remember: remember,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (
      UsersTableData,
      BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>
    ),
    UsersTableData,
    PrefetchHooks Function()>;
typedef $$BranchTableTableCreateCompanionBuilder = BranchTableCompanion
    Function({
  Value<int> id,
  required int branchId,
  required String name,
  Value<int> isDefault,
  Value<DateTime?> createdAt,
});
typedef $$BranchTableTableUpdateCompanionBuilder = BranchTableCompanion
    Function({
  Value<int> id,
  Value<int> branchId,
  Value<String> name,
  Value<int> isDefault,
  Value<DateTime?> createdAt,
});

final class $$BranchTableTableReferences
    extends BaseReferences<_$AppDatabase, $BranchTableTable, BranchTableData> {
  $$BranchTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WarehouseTableTable, List<WarehouseTableData>>
      _warehouseTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.warehouseTable,
              aliasName: $_aliasNameGenerator(
                  db.branchTable.branchId, db.warehouseTable.branch));

  $$WarehouseTableTableProcessedTableManager get warehouseTableRefs {
    final manager = $$WarehouseTableTableTableManager($_db, $_db.warehouseTable)
        .filter((f) => f.branch.branchId($_item.branchId));

    final cache = $_typedResult.readTableOrNull(_warehouseTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BranchTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BranchTableTable> {
  $$BranchTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get branchId => $state.composableBuilder(
      column: $state.table.branchId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter warehouseTableRefs(
      ComposableFilter Function($$WarehouseTableTableFilterComposer f) f) {
    final $$WarehouseTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $state.db.warehouseTable,
        getReferencedColumn: (t) => t.branch,
        builder: (joinBuilder, parentComposers) =>
            $$WarehouseTableTableFilterComposer(ComposerState($state.db,
                $state.db.warehouseTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$BranchTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BranchTableTable> {
  $$BranchTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get branchId => $state.composableBuilder(
      column: $state.table.branchId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$BranchTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BranchTableTable,
    BranchTableData,
    $$BranchTableTableFilterComposer,
    $$BranchTableTableOrderingComposer,
    $$BranchTableTableCreateCompanionBuilder,
    $$BranchTableTableUpdateCompanionBuilder,
    (BranchTableData, $$BranchTableTableReferences),
    BranchTableData,
    PrefetchHooks Function({bool warehouseTableRefs})> {
  $$BranchTableTableTableManager(_$AppDatabase db, $BranchTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BranchTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BranchTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> branchId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> isDefault = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              BranchTableCompanion(
            id: id,
            branchId: branchId,
            name: name,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int branchId,
            required String name,
            Value<int> isDefault = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              BranchTableCompanion.insert(
            id: id,
            branchId: branchId,
            name: name,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BranchTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({warehouseTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (warehouseTableRefs) db.warehouseTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (warehouseTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BranchTableTableReferences
                            ._warehouseTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BranchTableTableReferences(db, table, p0)
                                .warehouseTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.branch == item.branchId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BranchTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BranchTableTable,
    BranchTableData,
    $$BranchTableTableFilterComposer,
    $$BranchTableTableOrderingComposer,
    $$BranchTableTableCreateCompanionBuilder,
    $$BranchTableTableUpdateCompanionBuilder,
    (BranchTableData, $$BranchTableTableReferences),
    BranchTableData,
    PrefetchHooks Function({bool warehouseTableRefs})>;
typedef $$WarehouseTableTableCreateCompanionBuilder = WarehouseTableCompanion
    Function({
  Value<int> id,
  required String code,
  required String name,
  Value<int> isDefault,
  Value<int> branchId,
  Value<int?> businessPlaceID,
  Value<String?> defaultBin,
  Value<String?> enableBinLocation,
  Value<String?> inactive,
  Value<DateTime?> createdAt,
  Value<int?> branch,
});
typedef $$WarehouseTableTableUpdateCompanionBuilder = WarehouseTableCompanion
    Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
  Value<int> isDefault,
  Value<int> branchId,
  Value<int?> businessPlaceID,
  Value<String?> defaultBin,
  Value<String?> enableBinLocation,
  Value<String?> inactive,
  Value<DateTime?> createdAt,
  Value<int?> branch,
});

final class $$WarehouseTableTableReferences extends BaseReferences<
    _$AppDatabase, $WarehouseTableTable, WarehouseTableData> {
  $$WarehouseTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BranchTableTable _branchTable(_$AppDatabase db) =>
      db.branchTable.createAlias($_aliasNameGenerator(
          db.warehouseTable.branch, db.branchTable.branchId));

  $$BranchTableTableProcessedTableManager? get branch {
    if ($_item.branch == null) return null;
    final manager = $$BranchTableTableTableManager($_db, $_db.branchTable)
        .filter((f) => f.branchId($_item.branch!));
    final item = $_typedResult.readTableOrNull(_branchTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BinLocationTableTable, List<BinLocationTableData>>
      _binLocationTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.binLocationTable,
              aliasName: $_aliasNameGenerator(
                  db.warehouseTable.code, db.binLocationTable.warehouse));

  $$BinLocationTableTableProcessedTableManager get binLocationTableRefs {
    final manager =
        $$BinLocationTableTableTableManager($_db, $_db.binLocationTable)
            .filter((f) => f.warehouse.code($_item.code));

    final cache =
        $_typedResult.readTableOrNull(_binLocationTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WarehouseTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WarehouseTableTable> {
  $$WarehouseTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get branchId => $state.composableBuilder(
      column: $state.table.branchId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get businessPlaceID => $state.composableBuilder(
      column: $state.table.businessPlaceID,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get defaultBin => $state.composableBuilder(
      column: $state.table.defaultBin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get enableBinLocation => $state.composableBuilder(
      column: $state.table.enableBinLocation,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get inactive => $state.composableBuilder(
      column: $state.table.inactive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$BranchTableTableFilterComposer get branch {
    final $$BranchTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branch,
        referencedTable: $state.db.branchTable,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder, parentComposers) =>
            $$BranchTableTableFilterComposer(ComposerState($state.db,
                $state.db.branchTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter binLocationTableRefs(
      ComposableFilter Function($$BinLocationTableTableFilterComposer f) f) {
    final $$BinLocationTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.code,
            referencedTable: $state.db.binLocationTable,
            getReferencedColumn: (t) => t.warehouse,
            builder: (joinBuilder, parentComposers) =>
                $$BinLocationTableTableFilterComposer(ComposerState($state.db,
                    $state.db.binLocationTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$WarehouseTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WarehouseTableTable> {
  $$WarehouseTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get branchId => $state.composableBuilder(
      column: $state.table.branchId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get businessPlaceID => $state.composableBuilder(
      column: $state.table.businessPlaceID,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get defaultBin => $state.composableBuilder(
      column: $state.table.defaultBin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get enableBinLocation => $state.composableBuilder(
      column: $state.table.enableBinLocation,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get inactive => $state.composableBuilder(
      column: $state.table.inactive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$BranchTableTableOrderingComposer get branch {
    final $$BranchTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branch,
        referencedTable: $state.db.branchTable,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder, parentComposers) =>
            $$BranchTableTableOrderingComposer(ComposerState($state.db,
                $state.db.branchTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$WarehouseTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WarehouseTableTable,
    WarehouseTableData,
    $$WarehouseTableTableFilterComposer,
    $$WarehouseTableTableOrderingComposer,
    $$WarehouseTableTableCreateCompanionBuilder,
    $$WarehouseTableTableUpdateCompanionBuilder,
    (WarehouseTableData, $$WarehouseTableTableReferences),
    WarehouseTableData,
    PrefetchHooks Function({bool branch, bool binLocationTableRefs})> {
  $$WarehouseTableTableTableManager(
      _$AppDatabase db, $WarehouseTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WarehouseTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WarehouseTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> isDefault = const Value.absent(),
            Value<int> branchId = const Value.absent(),
            Value<int?> businessPlaceID = const Value.absent(),
            Value<String?> defaultBin = const Value.absent(),
            Value<String?> enableBinLocation = const Value.absent(),
            Value<String?> inactive = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> branch = const Value.absent(),
          }) =>
              WarehouseTableCompanion(
            id: id,
            code: code,
            name: name,
            isDefault: isDefault,
            branchId: branchId,
            businessPlaceID: businessPlaceID,
            defaultBin: defaultBin,
            enableBinLocation: enableBinLocation,
            inactive: inactive,
            createdAt: createdAt,
            branch: branch,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
            Value<int> isDefault = const Value.absent(),
            Value<int> branchId = const Value.absent(),
            Value<int?> businessPlaceID = const Value.absent(),
            Value<String?> defaultBin = const Value.absent(),
            Value<String?> enableBinLocation = const Value.absent(),
            Value<String?> inactive = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> branch = const Value.absent(),
          }) =>
              WarehouseTableCompanion.insert(
            id: id,
            code: code,
            name: name,
            isDefault: isDefault,
            branchId: branchId,
            businessPlaceID: businessPlaceID,
            defaultBin: defaultBin,
            enableBinLocation: enableBinLocation,
            inactive: inactive,
            createdAt: createdAt,
            branch: branch,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WarehouseTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {branch = false, binLocationTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (binLocationTableRefs) db.binLocationTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (branch) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.branch,
                    referencedTable:
                        $$WarehouseTableTableReferences._branchTable(db),
                    referencedColumn: $$WarehouseTableTableReferences
                        ._branchTable(db)
                        .branchId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (binLocationTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$WarehouseTableTableReferences
                            ._binLocationTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WarehouseTableTableReferences(db, table, p0)
                                .binLocationTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.warehouse == item.code),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WarehouseTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WarehouseTableTable,
    WarehouseTableData,
    $$WarehouseTableTableFilterComposer,
    $$WarehouseTableTableOrderingComposer,
    $$WarehouseTableTableCreateCompanionBuilder,
    $$WarehouseTableTableUpdateCompanionBuilder,
    (WarehouseTableData, $$WarehouseTableTableReferences),
    WarehouseTableData,
    PrefetchHooks Function({bool branch, bool binLocationTableRefs})>;
typedef $$BinLocationTableTableCreateCompanionBuilder
    = BinLocationTableCompanion Function({
  Value<int> id,
  required int absEntry,
  Value<String?> binCode,
  Value<int?> isDefault,
  Value<String?> isSystemBin,
  Value<String?> warehouseCode,
  Value<DateTime?> createdAt,
  Value<String?> batchRestrictions,
  Value<String?> warehouse,
});
typedef $$BinLocationTableTableUpdateCompanionBuilder
    = BinLocationTableCompanion Function({
  Value<int> id,
  Value<int> absEntry,
  Value<String?> binCode,
  Value<int?> isDefault,
  Value<String?> isSystemBin,
  Value<String?> warehouseCode,
  Value<DateTime?> createdAt,
  Value<String?> batchRestrictions,
  Value<String?> warehouse,
});

final class $$BinLocationTableTableReferences extends BaseReferences<
    _$AppDatabase, $BinLocationTableTable, BinLocationTableData> {
  $$BinLocationTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WarehouseTableTable _warehouseTable(_$AppDatabase db) =>
      db.warehouseTable.createAlias($_aliasNameGenerator(
          db.binLocationTable.warehouse, db.warehouseTable.code));

  $$WarehouseTableTableProcessedTableManager? get warehouse {
    if ($_item.warehouse == null) return null;
    final manager = $$WarehouseTableTableTableManager($_db, $_db.warehouseTable)
        .filter((f) => f.code($_item.warehouse!));
    final item = $_typedResult.readTableOrNull(_warehouseTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BinLocationTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BinLocationTableTable> {
  $$BinLocationTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get absEntry => $state.composableBuilder(
      column: $state.table.absEntry,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get binCode => $state.composableBuilder(
      column: $state.table.binCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get isSystemBin => $state.composableBuilder(
      column: $state.table.isSystemBin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get warehouseCode => $state.composableBuilder(
      column: $state.table.warehouseCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get batchRestrictions => $state.composableBuilder(
      column: $state.table.batchRestrictions,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$WarehouseTableTableFilterComposer get warehouse {
    final $$WarehouseTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.warehouse,
        referencedTable: $state.db.warehouseTable,
        getReferencedColumn: (t) => t.code,
        builder: (joinBuilder, parentComposers) =>
            $$WarehouseTableTableFilterComposer(ComposerState($state.db,
                $state.db.warehouseTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$BinLocationTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BinLocationTableTable> {
  $$BinLocationTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get absEntry => $state.composableBuilder(
      column: $state.table.absEntry,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get binCode => $state.composableBuilder(
      column: $state.table.binCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get isSystemBin => $state.composableBuilder(
      column: $state.table.isSystemBin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get warehouseCode => $state.composableBuilder(
      column: $state.table.warehouseCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get batchRestrictions => $state.composableBuilder(
      column: $state.table.batchRestrictions,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$WarehouseTableTableOrderingComposer get warehouse {
    final $$WarehouseTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.warehouse,
            referencedTable: $state.db.warehouseTable,
            getReferencedColumn: (t) => t.code,
            builder: (joinBuilder, parentComposers) =>
                $$WarehouseTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.warehouseTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$BinLocationTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BinLocationTableTable,
    BinLocationTableData,
    $$BinLocationTableTableFilterComposer,
    $$BinLocationTableTableOrderingComposer,
    $$BinLocationTableTableCreateCompanionBuilder,
    $$BinLocationTableTableUpdateCompanionBuilder,
    (BinLocationTableData, $$BinLocationTableTableReferences),
    BinLocationTableData,
    PrefetchHooks Function({bool warehouse})> {
  $$BinLocationTableTableTableManager(
      _$AppDatabase db, $BinLocationTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BinLocationTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BinLocationTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> absEntry = const Value.absent(),
            Value<String?> binCode = const Value.absent(),
            Value<int?> isDefault = const Value.absent(),
            Value<String?> isSystemBin = const Value.absent(),
            Value<String?> warehouseCode = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> batchRestrictions = const Value.absent(),
            Value<String?> warehouse = const Value.absent(),
          }) =>
              BinLocationTableCompanion(
            id: id,
            absEntry: absEntry,
            binCode: binCode,
            isDefault: isDefault,
            isSystemBin: isSystemBin,
            warehouseCode: warehouseCode,
            createdAt: createdAt,
            batchRestrictions: batchRestrictions,
            warehouse: warehouse,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int absEntry,
            Value<String?> binCode = const Value.absent(),
            Value<int?> isDefault = const Value.absent(),
            Value<String?> isSystemBin = const Value.absent(),
            Value<String?> warehouseCode = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> batchRestrictions = const Value.absent(),
            Value<String?> warehouse = const Value.absent(),
          }) =>
              BinLocationTableCompanion.insert(
            id: id,
            absEntry: absEntry,
            binCode: binCode,
            isDefault: isDefault,
            isSystemBin: isSystemBin,
            warehouseCode: warehouseCode,
            createdAt: createdAt,
            batchRestrictions: batchRestrictions,
            warehouse: warehouse,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BinLocationTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({warehouse = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (warehouse) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.warehouse,
                    referencedTable:
                        $$BinLocationTableTableReferences._warehouseTable(db),
                    referencedColumn: $$BinLocationTableTableReferences
                        ._warehouseTable(db)
                        .code,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BinLocationTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BinLocationTableTable,
    BinLocationTableData,
    $$BinLocationTableTableFilterComposer,
    $$BinLocationTableTableOrderingComposer,
    $$BinLocationTableTableCreateCompanionBuilder,
    $$BinLocationTableTableUpdateCompanionBuilder,
    (BinLocationTableData, $$BinLocationTableTableReferences),
    BinLocationTableData,
    PrefetchHooks Function({bool warehouse})>;
typedef $$ItemTableTableCreateCompanionBuilder = ItemTableCompanion Function({
  Value<int> id,
  required String code,
  required String name,
  Value<int?> uoMGroupEntry,
  Value<String?> inventoryUOM,
  Value<int?> iunventoryUoMEntry,
  Value<String?> purchaseItem,
  Value<String?> saleItem,
  Value<String?> inventoryItem,
  Value<String?> isManageBatch,
  Value<String?> isManageSerial,
  Value<String?> uoMGroupDefinitionCollection,
  Value<DateTime?> createdAt,
});
typedef $$ItemTableTableUpdateCompanionBuilder = ItemTableCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
  Value<int?> uoMGroupEntry,
  Value<String?> inventoryUOM,
  Value<int?> iunventoryUoMEntry,
  Value<String?> purchaseItem,
  Value<String?> saleItem,
  Value<String?> inventoryItem,
  Value<String?> isManageBatch,
  Value<String?> isManageSerial,
  Value<String?> uoMGroupDefinitionCollection,
  Value<DateTime?> createdAt,
});

class $$ItemTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ItemTableTable> {
  $$ItemTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get uoMGroupEntry => $state.composableBuilder(
      column: $state.table.uoMGroupEntry,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get inventoryUOM => $state.composableBuilder(
      column: $state.table.inventoryUOM,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get iunventoryUoMEntry => $state.composableBuilder(
      column: $state.table.iunventoryUoMEntry,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get purchaseItem => $state.composableBuilder(
      column: $state.table.purchaseItem,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get saleItem => $state.composableBuilder(
      column: $state.table.saleItem,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get inventoryItem => $state.composableBuilder(
      column: $state.table.inventoryItem,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get isManageBatch => $state.composableBuilder(
      column: $state.table.isManageBatch,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get isManageSerial => $state.composableBuilder(
      column: $state.table.isManageSerial,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get uoMGroupDefinitionCollection =>
      $state.composableBuilder(
          column: $state.table.uoMGroupDefinitionCollection,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ItemTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ItemTableTable> {
  $$ItemTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get uoMGroupEntry => $state.composableBuilder(
      column: $state.table.uoMGroupEntry,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get inventoryUOM => $state.composableBuilder(
      column: $state.table.inventoryUOM,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get iunventoryUoMEntry => $state.composableBuilder(
      column: $state.table.iunventoryUoMEntry,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get purchaseItem => $state.composableBuilder(
      column: $state.table.purchaseItem,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get saleItem => $state.composableBuilder(
      column: $state.table.saleItem,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get inventoryItem => $state.composableBuilder(
      column: $state.table.inventoryItem,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get isManageBatch => $state.composableBuilder(
      column: $state.table.isManageBatch,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get isManageSerial => $state.composableBuilder(
      column: $state.table.isManageSerial,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get uoMGroupDefinitionCollection =>
      $state.composableBuilder(
          column: $state.table.uoMGroupDefinitionCollection,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$ItemTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemTableTable,
    ItemTableData,
    $$ItemTableTableFilterComposer,
    $$ItemTableTableOrderingComposer,
    $$ItemTableTableCreateCompanionBuilder,
    $$ItemTableTableUpdateCompanionBuilder,
    (
      ItemTableData,
      BaseReferences<_$AppDatabase, $ItemTableTable, ItemTableData>
    ),
    ItemTableData,
    PrefetchHooks Function()> {
  $$ItemTableTableTableManager(_$AppDatabase db, $ItemTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ItemTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ItemTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> uoMGroupEntry = const Value.absent(),
            Value<String?> inventoryUOM = const Value.absent(),
            Value<int?> iunventoryUoMEntry = const Value.absent(),
            Value<String?> purchaseItem = const Value.absent(),
            Value<String?> saleItem = const Value.absent(),
            Value<String?> inventoryItem = const Value.absent(),
            Value<String?> isManageBatch = const Value.absent(),
            Value<String?> isManageSerial = const Value.absent(),
            Value<String?> uoMGroupDefinitionCollection = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              ItemTableCompanion(
            id: id,
            code: code,
            name: name,
            uoMGroupEntry: uoMGroupEntry,
            inventoryUOM: inventoryUOM,
            iunventoryUoMEntry: iunventoryUoMEntry,
            purchaseItem: purchaseItem,
            saleItem: saleItem,
            inventoryItem: inventoryItem,
            isManageBatch: isManageBatch,
            isManageSerial: isManageSerial,
            uoMGroupDefinitionCollection: uoMGroupDefinitionCollection,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
            Value<int?> uoMGroupEntry = const Value.absent(),
            Value<String?> inventoryUOM = const Value.absent(),
            Value<int?> iunventoryUoMEntry = const Value.absent(),
            Value<String?> purchaseItem = const Value.absent(),
            Value<String?> saleItem = const Value.absent(),
            Value<String?> inventoryItem = const Value.absent(),
            Value<String?> isManageBatch = const Value.absent(),
            Value<String?> isManageSerial = const Value.absent(),
            Value<String?> uoMGroupDefinitionCollection = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              ItemTableCompanion.insert(
            id: id,
            code: code,
            name: name,
            uoMGroupEntry: uoMGroupEntry,
            inventoryUOM: inventoryUOM,
            iunventoryUoMEntry: iunventoryUoMEntry,
            purchaseItem: purchaseItem,
            saleItem: saleItem,
            inventoryItem: inventoryItem,
            isManageBatch: isManageBatch,
            isManageSerial: isManageSerial,
            uoMGroupDefinitionCollection: uoMGroupDefinitionCollection,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItemTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemTableTable,
    ItemTableData,
    $$ItemTableTableFilterComposer,
    $$ItemTableTableOrderingComposer,
    $$ItemTableTableCreateCompanionBuilder,
    $$ItemTableTableUpdateCompanionBuilder,
    (
      ItemTableData,
      BaseReferences<_$AppDatabase, $ItemTableTable, ItemTableData>
    ),
    ItemTableData,
    PrefetchHooks Function()>;
typedef $$UnitOfMeasurementTableTableCreateCompanionBuilder
    = UnitOfMeasurementTableCompanion Function({
  Value<int> id,
  Value<int?> uoMGroupEntry,
  required int absEntry,
  required int alternateUoM,
  Value<double?> alternateQuantity,
  Value<double?> baseQuantity,
  required String code,
  required String name,
  Value<int> isDefault,
  Value<DateTime?> createdAt,
});
typedef $$UnitOfMeasurementTableTableUpdateCompanionBuilder
    = UnitOfMeasurementTableCompanion Function({
  Value<int> id,
  Value<int?> uoMGroupEntry,
  Value<int> absEntry,
  Value<int> alternateUoM,
  Value<double?> alternateQuantity,
  Value<double?> baseQuantity,
  Value<String> code,
  Value<String> name,
  Value<int> isDefault,
  Value<DateTime?> createdAt,
});

class $$UnitOfMeasurementTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UnitOfMeasurementTableTable> {
  $$UnitOfMeasurementTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get uoMGroupEntry => $state.composableBuilder(
      column: $state.table.uoMGroupEntry,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get absEntry => $state.composableBuilder(
      column: $state.table.absEntry,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get alternateUoM => $state.composableBuilder(
      column: $state.table.alternateUoM,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get alternateQuantity => $state.composableBuilder(
      column: $state.table.alternateQuantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get baseQuantity => $state.composableBuilder(
      column: $state.table.baseQuantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UnitOfMeasurementTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UnitOfMeasurementTableTable> {
  $$UnitOfMeasurementTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get uoMGroupEntry => $state.composableBuilder(
      column: $state.table.uoMGroupEntry,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get absEntry => $state.composableBuilder(
      column: $state.table.absEntry,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get alternateUoM => $state.composableBuilder(
      column: $state.table.alternateUoM,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get alternateQuantity => $state.composableBuilder(
      column: $state.table.alternateQuantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get baseQuantity => $state.composableBuilder(
      column: $state.table.baseQuantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get isDefault => $state.composableBuilder(
      column: $state.table.isDefault,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$UnitOfMeasurementTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UnitOfMeasurementTableTable,
    UnitOfMeasurementTableData,
    $$UnitOfMeasurementTableTableFilterComposer,
    $$UnitOfMeasurementTableTableOrderingComposer,
    $$UnitOfMeasurementTableTableCreateCompanionBuilder,
    $$UnitOfMeasurementTableTableUpdateCompanionBuilder,
    (
      UnitOfMeasurementTableData,
      BaseReferences<_$AppDatabase, $UnitOfMeasurementTableTable,
          UnitOfMeasurementTableData>
    ),
    UnitOfMeasurementTableData,
    PrefetchHooks Function()> {
  $$UnitOfMeasurementTableTableTableManager(
      _$AppDatabase db, $UnitOfMeasurementTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$UnitOfMeasurementTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$UnitOfMeasurementTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> uoMGroupEntry = const Value.absent(),
            Value<int> absEntry = const Value.absent(),
            Value<int> alternateUoM = const Value.absent(),
            Value<double?> alternateQuantity = const Value.absent(),
            Value<double?> baseQuantity = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> isDefault = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              UnitOfMeasurementTableCompanion(
            id: id,
            uoMGroupEntry: uoMGroupEntry,
            absEntry: absEntry,
            alternateUoM: alternateUoM,
            alternateQuantity: alternateQuantity,
            baseQuantity: baseQuantity,
            code: code,
            name: name,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> uoMGroupEntry = const Value.absent(),
            required int absEntry,
            required int alternateUoM,
            Value<double?> alternateQuantity = const Value.absent(),
            Value<double?> baseQuantity = const Value.absent(),
            required String code,
            required String name,
            Value<int> isDefault = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              UnitOfMeasurementTableCompanion.insert(
            id: id,
            uoMGroupEntry: uoMGroupEntry,
            absEntry: absEntry,
            alternateUoM: alternateUoM,
            alternateQuantity: alternateQuantity,
            baseQuantity: baseQuantity,
            code: code,
            name: name,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UnitOfMeasurementTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UnitOfMeasurementTableTable,
        UnitOfMeasurementTableData,
        $$UnitOfMeasurementTableTableFilterComposer,
        $$UnitOfMeasurementTableTableOrderingComposer,
        $$UnitOfMeasurementTableTableCreateCompanionBuilder,
        $$UnitOfMeasurementTableTableUpdateCompanionBuilder,
        (
          UnitOfMeasurementTableData,
          BaseReferences<_$AppDatabase, $UnitOfMeasurementTableTable,
              UnitOfMeasurementTableData>
        ),
        UnitOfMeasurementTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$BranchTableTableTableManager get branchTable =>
      $$BranchTableTableTableManager(_db, _db.branchTable);
  $$WarehouseTableTableTableManager get warehouseTable =>
      $$WarehouseTableTableTableManager(_db, _db.warehouseTable);
  $$BinLocationTableTableTableManager get binLocationTable =>
      $$BinLocationTableTableTableManager(_db, _db.binLocationTable);
  $$ItemTableTableTableManager get itemTable =>
      $$ItemTableTableTableManager(_db, _db.itemTable);
  $$UnitOfMeasurementTableTableTableManager get unitOfMeasurementTable =>
      $$UnitOfMeasurementTableTableTableManager(
          _db, _db.unitOfMeasurementTable);
}
