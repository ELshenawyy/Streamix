import 'package:movie_app/movies/domain/entities/movies.dart';

abstract class BaseMovieRepository {
  Future<List<Movie>> getNowPlayingMovies();

  Future<List<Movie>> getPopularMovies();

  Future<List<Movie>> getTopRatedMovies();
}
