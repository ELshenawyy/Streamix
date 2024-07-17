import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String backdropPath;
  final int id;
  final int voteAverage;
  final List<int> genreIds;
  final String overview;

  const Movie({
    required this.title,
    required this.backdropPath,
    required this.id,
    required this.voteAverage,
    required this.genreIds,
    required this.overview,
  });

  @override
  List<Object?> get props =>
      [id, title, backdropPath, genreIds, overview, voteAverage];
}
