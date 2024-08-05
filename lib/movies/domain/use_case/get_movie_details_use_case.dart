import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart%20';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/useCases/base_use_cases.dart';
import 'package:movie_app/movies/domain/entities/details_movies.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';

class GetMovieDetailsUseCase
    extends BaseUseCases<DetailsMovies, MovieDetailsParameter> {
  final BaseMovieRepository baseMovieRepository;

  GetMovieDetailsUseCase({required this.baseMovieRepository});

  @override
  Future<Either<Failure, DetailsMovies>> call(
      MovieDetailsParameter parameter) async {
    return await baseMovieRepository.getMovieDetails();
  }
}

class MovieDetailsParameter extends Equatable {
  final int id;

  const MovieDetailsParameter({required this.id});

  @override
  List<Object?> get props => [id];
}
