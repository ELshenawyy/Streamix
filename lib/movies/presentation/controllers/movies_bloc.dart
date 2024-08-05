import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/core/useCases/base_use_cases.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/presentation/controllers/movies_events.dart';
import 'package:movie_app/movies/presentation/controllers/movies_state.dart';

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
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getNowPlayingMoviesUseCase(const NoParameter());
    result.fold(
      (l) => emit(state.copyWith(
          nowPlayingState: RequestState.error,
          nowPlayingMessage: l.errMessage)),
      (r) => emit(
        state.copyWith(
            nowPlayingMovies: r, nowPlayingState: RequestState.loaded),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(const NoParameter());
    result.fold(
      (l) => emit(state.copyWith(
          popularState: RequestState.error, popularMessage: l.errMessage)),
      (r) => emit(
        state.copyWith(
          popularMovies: r,
          popularState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMoviesUseCase(const NoParameter());
    result.fold(
        (l) => emit(MoviesState(
            topRatedState: RequestState.error,
            topRatedMessage: l.errMessage)),
        (r) => emit(MoviesState(
            topRatedMovies: r, topRatedState: RequestState.loaded)));
  }
}
