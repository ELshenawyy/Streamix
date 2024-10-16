import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:movie_app/watch_movies/screens/watch_movies.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_event.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_state.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../favourits/presentation/controller/favoutite_screen_provider.dart';
import '../../domain/entities/genres.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<MovieDetailsBloc>()
          ..add(
            GetDetailsMovieEvent(id),
          )
          ..add(
            GetRecommendedMoviesEvent(id),
          ),
        child: const MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.moviesDetailsState) {
          case RequestState.loading:
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.gold,
            ));
          case RequestState.loaded:
            final movieDetails = state.moviesDetails;
            if (movieDetails == null) {
              return const Center(child: Text("Movie details unavailable."));
            }

            return CustomScrollView(
              key: const Key('movieDetailScrollView'),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 800),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 1.0, 1.0],
                          ).createShader(
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: movieDetails.backdropPath != null
                            ? CachedNetworkImage(
                                width: MediaQuery.of(context).size.width,
                                imageUrl: ApiConstance.imageUrl(
                                    movieDetails.backdropPath),
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250.0,
                                color: Colors.grey,
                                child: const Center(
                                  child: Text(
                                    'Image not available',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 280,
                                child: Text(
                                  movieDetails.title ?? 'Title Unavailable',
                                  style: GoogleFonts.poppins(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              PlayButtonWithHover(
                                movieId: movieDetails.id,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  movieDetails.releaseDate.split('-')[0] ??
                                      'N/A',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Row(children: [
                                SvgPicture.asset(
                                  "assets/icons/Star_fill.svg",
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  movieDetails.voteAverage != null
                                      ? movieDetails.voteAverage
                                          .toStringAsFixed(1)
                                      : 'N/A',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Provider.of<FavoriteMovieProvider>(context)
                                            .isFavoriteMovie(state
                                                .moviesDetails!.id
                                                .toString())
                                        ? Icons.favorite
                                        : Icons.favorite_border_rounded,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                                  onPressed: () async {
                                    final favoriteMovieProvider =
                                        Provider.of<FavoriteMovieProvider>(
                                            context,
                                            listen: false);
                                    if (favoriteMovieProvider.isFavoriteMovie(
                                        state.moviesDetails!.id.toString())) {
                                      favoriteMovieProvider.removeFavoriteMovie(
                                          state.moviesDetails!.id.toString());
                                    } else {
                                      favoriteMovieProvider.addFavoriteMovie(
                                        state.moviesDetails!.id.toString(),
                                        state.moviesDetails!.title,
                                        state.moviesDetails!.backdropPath ?? '',
                                      );
                                    }
                                  },
                                ),
                              ]),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25),
                              Text(
                                _showDuration(movieDetails.runtime),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            '${movieDetails.overview ?? 'No overview available'}...', //TODO
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${AppStrings.genres}: ${_showGenres(movieDetails.genres)}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color!
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: _showRecommendations(state),
                ),
              ],
            );
          case RequestState.error:
            return Center(
              child: Text(state.moviesDetailsMessage),
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    return genres.isNotEmpty
        ? genres.map((genre) => genre.name).join(', ')
        : 'No genres';
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }

  Widget _showRecommendations(MovieDetailsState state) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final recommendation = state.moviesRecommendation[index];
          return FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailScreen(id: recommendation.id),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: CachedNetworkImage(
                  imageUrl: ApiConstance.imageUrl(recommendation.backdropPath!),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      height: 170.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        childCount: state.moviesRecommendation.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 2,
      ),
    );
  }
}

class PlayButtonWithHover extends StatefulWidget {
  final int movieId;

  const PlayButtonWithHover({Key? key, required this.movieId})
      : super(key: key);

  @override
  _PlayButtonWithHoverState createState() => _PlayButtonWithHoverState();
}

class _PlayButtonWithHoverState extends State<PlayButtonWithHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onHover(true),
      onExit: (event) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          if (widget.movieId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WatchMovieScreen(movieId: widget.movieId),
              ),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _isHovered ? 50 : 40,
          // Increase size on hover
          height: _isHovered ? 50 : 40,
          // Increase size on hover
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.red.withOpacity(0.8), Colors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.play_circle_fill,
              size: _isHovered ? 30 : 40, // Increase icon size on hover
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
