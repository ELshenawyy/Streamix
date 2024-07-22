import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movies_events.dart';
import 'package:movie_app/movies/presentation/controllers/movies_state.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) {
      return MoviesBloc(getIt())..add(GetNowPlayingMoviesEvent());
    }, child: BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        return const Scaffold();
      },
    ));
  }
}