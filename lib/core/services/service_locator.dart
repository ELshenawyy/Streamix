import 'package:get_it/get_it.dart';
import 'package:movie_app/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movie_app/movies/data/repository/movie_repository.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:movie_app/movies/presentation/controllers/movie_detailes_bloc.dart';

import '../../movies/domain/use_case/get_movie_details_use_case.dart';
import '../../movies/domain/use_case/get_now_playing_movies_use_case.dart';
import '../../movies/domain/use_case/get_popular_movies_use_case.dart';
import '../../movies/domain/use_case/get_top_rated_movies_use_case.dart';
import '../../movies/presentation/controllers/movies_bloc.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    /// RemoteDataSource

    getIt.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());

    /// Repository
    getIt.registerLazySingleton<BaseMovieRepository>(
        () => MovieRepository(baseMovieRemoteDataSource: getIt()));

    /// Use cases
    getIt.registerLazySingleton(() => GetNowPlayingMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTopRatedMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetMovieDetailsUseCase(getIt()));

    /// Bloc
    getIt.registerFactory<MoviesBloc>(
        () => MoviesBloc(getIt(), getIt(), getIt()));
    () => MovieDetailsBloc(getIt());
  }
}
