import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/movies.dart';

import '../../../core/error/failures.dart';

abstract class BaseMovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
}
