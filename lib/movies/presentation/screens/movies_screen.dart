import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/presentation/screens/popular_screen.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'package:movie_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movies_events.dart';
import 'package:movie_app/movies/presentation/screens/top_rated_screen.dart';
import '../../../core/services/service_locator.dart';
import '../component/now_playing_component.dart';
import '../component/popular_movies_component.dart';
import '../component/top_rated_movies_component.dart';

class MoviesScreen extends StatelessWidget {
  final int movieId;

  const MoviesScreen({super.key, this.movieId = 1});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        body: CustomScrollView(
          key: const Key('movieScrollView'),
          slivers: [
            const SliverAppBar(
              expandedHeight: 60.0,
              floating: false,
              pinned: false,
              stretch: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                title: Text('Movies'),
              ),

            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const NowPlayingComponent(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.popular,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PopularMoviesScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.seeMore,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopularMoviesComponent(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.topRated,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TopRatedMoviesScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.seeMore,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TopRatedMovies(),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
