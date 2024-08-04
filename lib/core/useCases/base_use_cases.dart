import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';

abstract class BaseUseCases<T> {
  Future<Either<Failure, T>> call();
}
