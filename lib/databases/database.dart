import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'database_schema.dart';

part 'database.g.dart';

const List<Type> tables = [
  UsersTable,
  BranchTable,
  WarehouseTable,
  BinLocationTable,
  ItemTable,
  UnitOfMeasurementTable
];

@DriftDatabase(tables: tables)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'wms_database');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // onCreate is called when the database is created for the first time
        onCreate: (Migrator m) async {
          await m.createAll(); // Creates all defined tables
        },
        // onUpgrade is called when the database version is incremented
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            // If upgrading from version 1, create the new table
            await m.createTable(itemTable);
            await m.createTable(unitOfMeasurementTable);
          }
          // Add more conditions here if further versions are added in the future
        },
        // Additional setup before the database is opened, if needed
        beforeOpen: (details) async {
          // You can perform actions here before the database is opened, like seeding initial data
          if (details.wasCreated) {
            // Database was just created, handle any initial setup here
          }
        },
      );

  // Method to get all records from a specific table
  Future<List<D>> getAll<T extends Table, D extends DataClass>(
    TableInfo<T, D> table, {
    int? take = 10, // Optional limit parameter
    int skip = 0, // Optional offset parameter with a default of 0
    List<Expression<bool>>? filters, // Optional list of filter expressions
  }) async {
    final query = select(table)..limit(take ?? 10, offset: skip);

    if (filters != null && filters.isNotEmpty) {
      query.where((tbl) => filters.reduce((value, element) => value & element));
    }
    return (query).get();
  }

  // Method to find a single record based on a condition
  Future<D?> findOne<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    Expression<bool> Function(T table) where,
  ) async {
    return (select(table)..where(where)).getSingleOrNull();
  }

  // Dynamic update method to update records in any table
  Future<int> updateWhere<T extends Table, D extends DataClass>(
    TableInfo<T, D> table, {
    required Expression<bool> Function(T table) where,
    required Insertable<D> entity,
  }) async {
    return (update(table)..where(where)).write(entity);
  }

  // Dynamic delete method to remove records from any table
  Future<int> deleteWhere<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    Expression<bool> Function(T table) where,
  ) async {
    return (delete(table)..where(where)).go();
  }

  // Method to delete all records from a specific table
  Future<int> deleteAll<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
  ) async {
    return delete(table).go();
  }
}
