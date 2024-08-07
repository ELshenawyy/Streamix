import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_event.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_state.dart';

import '../../../core/utils/enums.dart';

class MovieDetailsBloc extends Bloc<MoviesDetailsEvents, MovieDetailsState> {
  MovieDetailsBloc(this.getMovieDetailsUseCase)
      : super(const MovieDetailsState()) {
    on<GetDetailsMovieEvent>(_getDetailsMovieEvent);
  }

  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  FutureOr<void> _getDetailsMovieEvent(
      GetDetailsMovieEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await getMovieDetailsUseCase(MovieDetailsParameter(movieId: event.id));

    result.fold(
      (l) => emit(state.copyWith(
          moviesDetailsState: RequestState.error,
          moviesDetailsMessage: l.errMessage)),
      (r) => emit(
        state.copyWith(
            moviesDetails: r, moviesDetailsState: RequestState.loaded),
      ),
    );
  }
}
