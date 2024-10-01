import 'package:flutter/material.dart';

import '../screens/watch_movies.dart';

class WatchNowButton extends StatelessWidget {
  final int movieId;

  const WatchNowButton({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WatchMovieScreen(movieId: movieId),
          ),
        );
      },
      child: const Text('Watch Movie'),
    );
  }
}
