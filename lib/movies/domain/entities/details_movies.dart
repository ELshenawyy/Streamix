import 'package:equatable/equatable.dart%20';

import 'genres.dart';

class DetailsMovies extends Equatable {
  final String backdropPath;
  final List<Genres> genres;
  final int id;
  final String overview;
  final int runtime;
  final int releaseDate;
  final String title;
  final int voteAverage;

  const DetailsMovies(
      {required this.backdropPath,
      required this.genres,
      required this.id,
      required this.overview,
      required this.runtime,
      required this.releaseDate,
      required this.title,
      required this.voteAverage});

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        overview,
        override,
        runtime,
        releaseDate,
        title,
        voteAverage
      ];
}
