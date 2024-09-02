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
  List<GeneratedColumn> get $columns =>
      [id, code, name, isDefault, branchId, createdAt, branch];
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
  final DateTime? createdAt;
  final int? branch;
  const WarehouseTableData(
      {required this.id,
      required this.code,
      required this.name,
      required this.isDefault,
      required this.branchId,
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
          Value<DateTime?> createdAt = const Value.absent(),
          Value<int?> branch = const Value.absent()}) =>
      WarehouseTableData(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        isDefault: isDefault ?? this.isDefault,
        branchId: branchId ?? this.branchId,
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
          ..write('createdAt: $createdAt, ')
          ..write('branch: $branch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, name, isDefault, branchId, createdAt, branch);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WarehouseTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.isDefault == this.isDefault &&
          other.branchId == this.branchId &&
          other.createdAt == this.createdAt &&
          other.branch == this.branch);
}

class WarehouseTableCompanion extends UpdateCompanion<WarehouseTableData> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> isDefault;
  final Value<int> branchId;
  final Value<DateTime?> createdAt;
  final Value<int?> branch;
  const WarehouseTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.branchId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.branch = const Value.absent(),
  });
  WarehouseTableCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.isDefault = const Value.absent(),
    this.branchId = const Value.absent(),
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
    Expression<DateTime>? createdAt,
    Expression<int>? branch,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (isDefault != null) 'is_default': isDefault,
      if (branchId != null) 'branch_id': branchId,
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
      Value<DateTime?>? createdAt,
      Value<int?>? branch}) {
    return WarehouseTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      branchId: branchId ?? this.branchId,
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
  List<GeneratedColumn> get $columns =>
      [id, code, name, isDefault, warehouseCode, createdAt, warehouse];
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
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_default'])!,
      warehouseCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_code']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
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
  final String code;
  final String name;
  final int isDefault;
  final String? warehouseCode;
  final DateTime? createdAt;
  final String? warehouse;
  const BinLocationTableData(
      {required this.id,
      required this.code,
      required this.name,
      required this.isDefault,
      this.warehouseCode,
      this.createdAt,
      this.warehouse});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['is_default'] = Variable<int>(isDefault);
    if (!nullToAbsent || warehouseCode != null) {
      map['warehouse_code'] = Variable<String>(warehouseCode);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || warehouse != null) {
      map['warehouse'] = Variable<String>(warehouse);
    }
    return map;
  }

  BinLocationTableCompanion toCompanion(bool nullToAbsent) {
    return BinLocationTableCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      isDefault: Value(isDefault),
      warehouseCode: warehouseCode == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseCode),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
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
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      isDefault: serializer.fromJson<int>(json['isDefault']),
      warehouseCode: serializer.fromJson<String?>(json['warehouseCode']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      warehouse: serializer.fromJson<String?>(json['warehouse']),
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
      'warehouseCode': serializer.toJson<String?>(warehouseCode),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'warehouse': serializer.toJson<String?>(warehouse),
    };
  }

  BinLocationTableData copyWith(
          {int? id,
          String? code,
          String? name,
          int? isDefault,
          Value<String?> warehouseCode = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> warehouse = const Value.absent()}) =>
      BinLocationTableData(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        isDefault: isDefault ?? this.isDefault,
        warehouseCode:
            warehouseCode.present ? warehouseCode.value : this.warehouseCode,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        warehouse: warehouse.present ? warehouse.value : this.warehouse,
      );
  BinLocationTableData copyWithCompanion(BinLocationTableCompanion data) {
    return BinLocationTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      warehouseCode: data.warehouseCode.present
          ? data.warehouseCode.value
          : this.warehouseCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      warehouse: data.warehouse.present ? data.warehouse.value : this.warehouse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BinLocationTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('warehouseCode: $warehouseCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('warehouse: $warehouse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, code, name, isDefault, warehouseCode, createdAt, warehouse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BinLocationTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.isDefault == this.isDefault &&
          other.warehouseCode == this.warehouseCode &&
          other.createdAt == this.createdAt &&
          other.warehouse == this.warehouse);
}

class BinLocationTableCompanion extends UpdateCompanion<BinLocationTableData> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> isDefault;
  final Value<String?> warehouseCode;
  final Value<DateTime?> createdAt;
  final Value<String?> warehouse;
  const BinLocationTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.warehouseCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.warehouse = const Value.absent(),
  });
  BinLocationTableCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.isDefault = const Value.absent(),
    this.warehouseCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.warehouse = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<BinLocationTableData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? isDefault,
    Expression<String>? warehouseCode,
    Expression<DateTime>? createdAt,
    Expression<String>? warehouse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (isDefault != null) 'is_default': isDefault,
      if (warehouseCode != null) 'warehouse_code': warehouseCode,
      if (createdAt != null) 'created_at': createdAt,
      if (warehouse != null) 'warehouse': warehouse,
    });
  }

  BinLocationTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? name,
      Value<int>? isDefault,
      Value<String?>? warehouseCode,
      Value<DateTime?>? createdAt,
      Value<String?>? warehouse}) {
    return BinLocationTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      warehouseCode: warehouseCode ?? this.warehouseCode,
      createdAt: createdAt ?? this.createdAt,
      warehouse: warehouse ?? this.warehouse,
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
    if (warehouseCode.present) {
      map['warehouse_code'] = Variable<String>(warehouseCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('warehouseCode: $warehouseCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('warehouse: $warehouse')
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
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [usersTable, branchTable, warehouseTable, binLocationTable];
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
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> branch = const Value.absent(),
          }) =>
              WarehouseTableCompanion(
            id: id,
            code: code,
            name: name,
            isDefault: isDefault,
            branchId: branchId,
            createdAt: createdAt,
            branch: branch,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
            Value<int> isDefault = const Value.absent(),
            Value<int> branchId = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> branch = const Value.absent(),
          }) =>
              WarehouseTableCompanion.insert(
            id: id,
            code: code,
            name: name,
            isDefault: isDefault,
            branchId: branchId,
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
  required String code,
  required String name,
  Value<int> isDefault,
  Value<String?> warehouseCode,
  Value<DateTime?> createdAt,
  Value<String?> warehouse,
});
typedef $$BinLocationTableTableUpdateCompanionBuilder
    = BinLocationTableCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
  Value<int> isDefault,
  Value<String?> warehouseCode,
  Value<DateTime?> createdAt,
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

  ColumnFilters<String> get warehouseCode => $state.composableBuilder(
      column: $state.table.warehouseCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
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

  ColumnOrderings<String> get warehouseCode => $state.composableBuilder(
      column: $state.table.warehouseCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
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
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> isDefault = const Value.absent(),
            Value<String?> warehouseCode = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> warehouse = const Value.absent(),
          }) =>
              BinLocationTableCompanion(
            id: id,
            code: code,
            name: name,
            isDefault: isDefault,
            warehouseCode: warehouseCode,
            createdAt: createdAt,
            warehouse: warehouse,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
            Value<int> isDefault = const Value.absent(),
            Value<String?> warehouseCode = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> warehouse = const Value.absent(),
          }) =>
              BinLocationTableCompanion.insert(
            id: id,
            code: code,
            name: name,
            isDefault: isDefault,
            warehouseCode: warehouseCode,
            createdAt: createdAt,
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
}
