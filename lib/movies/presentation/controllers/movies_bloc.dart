import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movie_app/core/useCases/base_use_cases.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/presentation/controllers/movies_events.dart';
import 'package:movie_app/movies/presentation/controllers/movies_state.dart';
import '../../domain/entities/movies.dart';
import '../../domain/use_case/get_now_playing_movies_use_case.dart';
import '../../domain/use_case/get_popular_movies_use_case.dart';
import '../../domain/use_case/get_top_rated_movies_use_case.dart';

class MoviesBloc extends Bloc<MoviesEvents, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(const MoviesState()) {
    on<FetchAllMoviesEvent>(_fetchAllMovies);
  }

  FutureOr<void> _fetchAllMovies(
      FetchAllMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(
      nowPlayingState: RequestState.loading,
      popularState: RequestState.loading,
      topRatedState: RequestState.loading,
    ));

    // Fetch movies concurrently
    final nowPlayingFuture = getNowPlayingMoviesUseCase(const NoParameter());
    final popularFuture = getPopularMoviesUseCase(const NoParameter());
    final topRatedFuture = getTopRatedMoviesUseCase(const NoParameter());

    // Wait for all futures to complete
    final results =
        await Future.wait([nowPlayingFuture, popularFuture, topRatedFuture]);

    results.forEach((result) {
      result.fold(
        (failure) => emit(state.copyWith(
          nowPlayingState: RequestState.error,
          popularState: RequestState.error,
          topRatedState: RequestState.error,
          nowPlayingMessage: failure.errMessage,
          popularMessage: failure.errMessage,
          topRatedMessage: failure.errMessage,
        )),
        (movies) {
          if (movies is List<Movie>) {
            if (state.nowPlayingState == RequestState.loading) {
              emit(state.copyWith(
                nowPlayingMovies: movies,
                nowPlayingState: RequestState.loaded,
              ));
            } else if (state.popularState == RequestState.loading) {
              emit(state.copyWith(
                popularMovies: movies,
                popularState: RequestState.loaded,
              ));
            } else if (state.topRatedState == RequestState.loading) {
              emit(state.copyWith(
                topRatedMovies: movies,
                topRatedState: RequestState.loaded,
              ));
            }
          }
        },
      );
    });
  }
}
