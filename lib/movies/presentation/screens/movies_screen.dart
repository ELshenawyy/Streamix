import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'package:movie_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movies_events.dart';
import '../component/now_playing_component.dart';
import '../component/popular_movies_component.dart';
import '../component/top_rated_movies.dart';

class MoviesScreen extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;

  const MoviesScreen({required this.onThemeChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => getIt<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        body: CustomScrollView(
          key: const Key('movieScrollView'),
          slivers: [
            SliverAppBar(
              expandedHeight: 60.0,
              floating: false,
              pinned: false,
              stretch: true,
              automaticallyImplyLeading: false,
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                title: Text('Movies'),
              ),
              actions: [
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    onThemeChanged(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ],
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
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            /// TODO : NAVIGATION TO POPULAR SCREEN
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.seeMore,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopularMoviesComponent(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(
                      16.0,
                      24.0,
                      16.0,
                      8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.topRated,
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            /// TODO : NAVIGATION TO Top Rated Movies Screen
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.seeMore,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                )
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
