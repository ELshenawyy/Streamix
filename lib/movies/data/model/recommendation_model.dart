import 'package:movie_app/movies/domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({
     super.backdropPath,
    required super.id,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        backdropPath: json['backdrop_path'] ?? '/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg',
        id: json['id'],
      );
}
