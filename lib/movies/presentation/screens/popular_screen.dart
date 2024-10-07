import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../controllers/movies_bloc.dart';
import '../controllers/movies_state.dart';
import '../controllers/movies_events.dart';
import 'movie_detail_screen.dart';

class PopularMoviesScreen extends StatelessWidget {
  const PopularMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoviesBloc>()..add(GetPopularMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text('Popular Movies'),
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            // Handling different states
            switch (state.popularState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());

              case RequestState.loaded:
                final movies = state.popularMovies;

                // Check if movies are empty
                if (movies.isEmpty) {
                  return const Center(
                      child: Text('No Popular Movies Available'));
                }

                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(id: movie.id),
                          ),
                        );
                      },
                      child: Material(
                        type: MaterialType.transparency,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Movie Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  imageUrl: movie.backdropPath != null
                                      ? ApiConstance.imageUrl(
                                          movie.backdropPath)
                                      : 'https://via.placeholder.com/150',
                                  // Fallback image
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[850]!,
                                    highlightColor: Colors.grey[800]!,
                                    child: Container(color: Colors.black),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                      movie.title,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,

                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2.0,
                                            horizontal: 8.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red[800],
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Text(
                                            movie.releaseDate.split('-')[0],
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 20.0,
                                          color: AppColors.gold,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          movie.voteAverage.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 90,
                                      width: 208,
                                      child: Text(
                                        '${movie.overview.substring(0,110)}...'
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );

              case RequestState.error:
                return Center(child: Text(state.nowPlayingMessage));

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
