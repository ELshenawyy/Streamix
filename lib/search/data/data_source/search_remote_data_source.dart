import 'package:dio/dio.dart';
import 'package:movie_app/core/network/error_movie_model.dart';


import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constance.dart';
import '../../../movies/data/model/movie_model.dart';
import '../../domain/use_case/get_movie_search_use_case.dart';
import 'base_search_remote_data_source.dart';

class SearchRemoteDataSource extends BaseSearchRemoteDataSource {
  @override
  Future<List<MovieModel>> getMoviesSearch(SearchMoviesParams params) async {
    final response = await Dio().get(
      ApiConstance.searchMoviesBaseUrl(
        params.query,
      ),
    );
    return getMovieDataResponse(response);
  }

  // get data response method for movies
  List<MovieModel> getMovieDataResponse(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
          (response.data["results"] as List).map(
                (e) => MovieModel.fromJson(e),
          ));
    } else {
      throw ServerException(
        errorMovieModel: ErrorMovieModel.fromJson(response.data),
      );
    }
  }
}