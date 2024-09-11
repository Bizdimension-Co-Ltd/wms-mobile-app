import 'package:drift/drift.dart';

class UsersTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get password => text()();
  TextColumn get remember => text()();
  IntColumn get isDefault => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class BranchTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get branchId => integer()();
  TextColumn get name => text()();
  IntColumn get isDefault => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class WarehouseTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get isDefault => integer().withDefault(const Constant(0))();
  IntColumn get branchId => integer().withDefault(const Constant(0))();
  IntColumn get businessPlaceID =>
      integer().nullable().withDefault(const Constant(0))();
  TextColumn get defaultBin =>
      text().nullable().withDefault(const Constant(""))();
  TextColumn get enableBinLocation =>
      text().nullable().withDefault(const Constant("tNO"))();
  TextColumn get inactive =>
      text().nullable().withDefault(const Constant(""))();
  DateTimeColumn get createdAt => dateTime().nullable()();

  IntColumn get branch =>
      integer().nullable().references(BranchTable, #branchId)();
}

class BinLocationTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get absEntry => integer()();
  TextColumn get binCode => text().nullable()();
  IntColumn get isDefault =>
      integer().nullable().withDefault(const Constant(0))();
  TextColumn get isSystemBin =>
      text().nullable().withDefault(const Constant(""))();
  TextColumn get warehouseCode => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  TextColumn get batchRestrictions => text().nullable()();

  TextColumn get warehouse =>
      text().nullable().references(WarehouseTable, #code)();
}

class ItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get uoMGroupEntry => integer().nullable()();
  TextColumn get inventoryUOM => text().nullable()();
  IntColumn get iunventoryUoMEntry => integer().nullable()();
  TextColumn get purchaseItem => text().nullable()();
  TextColumn get saleItem => text().nullable()();
  TextColumn get inventoryItem => text().nullable()();
  TextColumn get isManageBatch => text().nullable()();
  TextColumn get isManageSerial => text().nullable()();

  TextColumn get uoMGroupDefinitionCollection => text().nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();
}

class UnitOfMeasurementTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get uoMGroupEntry => integer().nullable()();
  IntColumn get absEntry => integer()();
  IntColumn get alternateUoM => integer()();
  RealColumn get alternateQuantity => real().nullable()();
  RealColumn get baseQuantity => real().nullable()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get isDefault => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}
