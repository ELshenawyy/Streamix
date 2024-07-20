import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/movies.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';

import '../../../core/error/failures.dart';

class GetPopularMoviesUseCase {
  final BaseMovieRepository baseMovieRepository;

  GetPopularMoviesUseCase(this.baseMovieRepository);

  Future<Either<Failure, List<Movie>>> execute() async {
    return await baseMovieRepository.getPopularMovies();
  }
}
