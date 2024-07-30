import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/movies.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';

import '../../../core/error/failures.dart';

class GetNowPlayingMoviesUseCase {
  final BaseMovieRepository baseMovieRepository;

  GetNowPlayingMoviesUseCase(this.baseMovieRepository);

  Future<Either<Failure, List<Movie>>> execute() async {
    return await baseMovieRepository.getNowPlayingMovies();
  }
}
