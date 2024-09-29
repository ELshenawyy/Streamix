import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movies_state.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/services/service_locator.dart';
import '../../../favourits/presentation/controller/favoutite_screen_provider.dart';
import '../controllers/movies_events.dart';
import 'movie_detail_screen.dart';

class PopularAndTopRatedMoviesScreen extends StatelessWidget {
  const PopularAndTopRatedMoviesScreen({super.key, required this.isPopular});

  final bool isPopular;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoviesBloc>()
        ..add(isPopular ? GetPopularMoviesEvent() : GetTopRatedMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isPopular ? 'Popular Movies' : 'Top Rated Movies'),
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (isPopular ? state.popularState : state.topRatedState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case RequestState.loaded:
                final movies =
                isPopular ? state.popularMovies : state.topRatedMovies;

                if (movies.isEmpty) {
                  return Center(
                    child: Text(
                      isPopular
                          ? 'No Popular Movies Available'
                          : 'No Top Rated Movies Available',
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(id: movie.id)));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                height: MediaQuery.of(context).size.height,
                                // ignore: unnecessary_null_comparison
                                imageUrl: movie.backdropPath != null
                                    ? ApiConstance.imageUrl(movie.backdropPath)
                                    : 'https://via.placeholder.com/150', // Fallback image URL
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[850]!,
                                      highlightColor: Colors.grey[800]!,
                                      child: Container(
                                        color: Colors.black,
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: IconButton(
                                icon: Icon(
                                  Provider.of<FavoriteMovieProvider>(context)
                                      .isFavoriteMovie(movie.id.toString())
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final favoriteMovieProvider =
                                  Provider.of<FavoriteMovieProvider>(
                                      context,
                                      listen: false);
                                  if (favoriteMovieProvider
                                      .isFavoriteMovie(movie.id.toString())) {
                                    favoriteMovieProvider
                                        .removeFavoriteMovie(movie.id.toString());
                                  } else {
                                    favoriteMovieProvider.addFavoriteMovie(
                                      movie.id.toString(),
                                      movie.title,
                                      movie.backdropPath ?? '',
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );

              case RequestState.error:
                return Center(
                  child: Text(state.nowPlayingMessage),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
