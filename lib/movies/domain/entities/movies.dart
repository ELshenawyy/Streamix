import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String backdropPath;
  final int id;
  final double voteAverage;
  final List<int> genreIds;
  final String overview;
  final String releaseDate;

  const Movie({
    required this.title,
    required this.backdropPath,
    required this.id,
    required this.voteAverage,
    required this.genreIds,
    required this.overview,
    required this.releaseDate,
  });

  @override
  List<Object?> get props =>
      [id, title, backdropPath, genreIds, overview, voteAverage];
}
