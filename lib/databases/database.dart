import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'database_schema.dart';

part 'database.g.dart';

const List<Type> tables = [
  UsersTable,
  BranchTable,
  WarehouseTable,
  BinLocationTable,
];

@DriftDatabase(tables: tables)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'wms_database');
  }

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
