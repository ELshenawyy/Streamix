import 'package:equatable/equatable.dart%20';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/domain/entities/details_movies.dart';

class MovieDetailsState extends Equatable {
  final DetailsMovies? moviesDetails;
  final RequestState moviesDetailsState;
  final String moviesDetailsMessage;

  const MovieDetailsState(
      {this.moviesDetails,
      this.moviesDetailsState = RequestState.loading,
      this.moviesDetailsMessage = ''});

  MovieDetailsState copyWith({
    DetailsMovies? moviesDetails,
    RequestState? moviesDetailsState,
    String? moviesDetailsMessage,
  }) {
    return MovieDetailsState(
        moviesDetails: moviesDetails ?? this.moviesDetails,
        moviesDetailsState: moviesDetailsState ?? this.moviesDetailsState,
        moviesDetailsMessage:
            moviesDetailsMessage ?? this.moviesDetailsMessage);
  }

  @override
  List<Object?> get props => [
        moviesDetailsState,
        moviesDetails,
        moviesDetailsMessage,
      ];
}
