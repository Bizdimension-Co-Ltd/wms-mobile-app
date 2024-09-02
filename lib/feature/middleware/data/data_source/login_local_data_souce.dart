import 'package:drift/drift.dart';
import 'package:wms_mobile/databases/database.dart';
import 'package:wms_mobile/feature/middleware/data/model/login_model.dart';

abstract class LoginLocalDataSource {
  Future<List<dynamic>> gets();
  Future<dynamic> find(String username);
  Future<dynamic> create(LoginModel entity);
  Future<dynamic> update(LoginModel entity);
  Future<dynamic> remove(String username);
  Future<dynamic> removeAll(String username);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final AppDatabase database;

  LoginLocalDataSourceImpl(this.database);

  @override
  Future<void> create(LoginModel entity) async {
    try {
      await database.into(database.usersTable).insert(UsersTableCompanion(
            username: Value(entity.username),
            password: Value(entity.password),
            remember: Value('0'),
          ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> remove(String username) async {
    try {
      database.deleteWhere(
          database.usersTable, (user) => user.username.equals(username));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> removeAll(String username) async {
    try {
      database.deleteAll(database.usersTable);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> update(LoginModel entity) async {
    try {
      database.updateWhere(
        database.usersTable,
        where: (user) => user.username.equals(entity.usernme),
        entity: UsersTableCompanion(password: Value(entity.password)),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<dynamic> find(String username) async {
    return database.findOne(
        database.usersTable, (u) => u.username.equals(username));
  }

  @override
  Future<List> gets() async {
    return database.getAll(database.usersTable);
  }
}
