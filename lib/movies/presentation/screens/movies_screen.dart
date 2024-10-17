import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
      create: (context) => getIt<MoviesBloc>()..add(FetchAllMoviesEvent()),
      child: Scaffold(
        body: CustomScrollView(
          key: const Key('movieScrollView'),
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight: 60.0.sp,
              floating: false,
              pinned: false,
              stretch: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                title: Text(
                  'Movies',
                  style: GoogleFonts.poppins(
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const NowPlayingComponent(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.popular,
                          style: GoogleFonts.poppins(
                              fontSize: 22, letterSpacing: 1),
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
                            padding: EdgeInsets.all(8.0.sp),
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.seeMore,
                                  style: GoogleFonts.poppins(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color!
                                        .withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color!
                                      .withOpacity(0.6),
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
                    margin: const EdgeInsets.fromLTRB(16.0, 24.0, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.topRated,
                          style: GoogleFonts.poppins(
                              fontSize: 22, letterSpacing: 1),
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
                                  style: GoogleFonts.poppins(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .color!
                                          .withOpacity(0.7)),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color!
                                      .withOpacity(0.6),
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
