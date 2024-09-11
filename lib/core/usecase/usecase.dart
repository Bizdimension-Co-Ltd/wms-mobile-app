import 'package:dartz/dartz.dart';
import '/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class DatabseUseCase<T, Q> {
  Future<List<T>> get();
  Future<T?> find(Q params);
  Future<T> create(T params);
  Future<T> update(T params);
  Future<void> delete(Q params);
  Future<void> deleteAll();
}

abstract class GetUseCase<Type> {
  Future<Either<Failure, Type>> call();
}
