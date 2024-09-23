class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";

  static String imageUrl(String path) => '$baseImageUrl$path';
  static const String apiKey = "6048f044002b094be1fcd444206d566b";
  static const String nowPlayingMoviePath =
      "$baseUrl/movie/now_playing?api_key=$apiKey";
  static const String popularMoviePath =
      "$baseUrl/movie/popular?api_key=$apiKey";
  static const String topRatedMoviePath =
      "$baseUrl/movie/top_rated?api_key=$apiKey";

  static String detailsMoviePath(int movieId) =>
      "$baseUrl/movie/$movieId?api_key=$apiKey";

  static String recommendationsMoviePath(int movieId) =>
      "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";

  static String multiSearchBaseUrl(String query) =>
      "$baseUrl/search/multi?api_key=$apiKey&query=$query";
}
