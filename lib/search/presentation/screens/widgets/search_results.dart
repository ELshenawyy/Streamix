import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:movie_app/search/presentation/screens/widgets/search_result_items.dart';


import '../../../../../core/global/resources/font_manager.dart';
import '../../../../../core/global/resources/styles_manager.dart';
import '../../../../../core/global/resources/values_manager.dart';
import '../../../../core/global/resources/app_color.dart';
import '../../../../core/global/resources/strings_manger.dart';
import '../../../../movies/domain/entities/movies.dart';

import '../../controller/search_bloc.dart';
import '../../controller/search_state.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return Center(
            child: Text(
              AppString.anythingYouWant,
              style: getMediumStyle(fontSize: FontSize.s16),
            ),
          );
        } else if (state is SearchLoading) {
          return const SizedBox(
            height: AppSize.s100,
            child:  Center(
              child: CircularProgressIndicator(
                color: AppColors.gold,


              ),

            ),
          );

        } else if (state is SearchMoviesSuccess) {
          return _buildMoviesList(state.results);
        } else if (state is SearchMoviesError) {
          return Center(
            child: Text(state.message),
          );
        }
        //  else if (state is SearchPersonsSuccess) {
        //   return _buildPersonsList(state.results);
        // } else if (state is SearchPersonsError) {
        //   return Center(
        //     child: Text(state.message),
        //   );
        // }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMoviesList(List<Movie> results) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          AppString.noResultsFound,
          style: getMediumStyle(fontSize: FontSize.s16),
        ),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final searchEntity = results[index];
        return InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                  id: searchEntity.id,
                ),
              ),
            );
          },
          child: Column(
            children: [
              SearchResultsItem(
                title: searchEntity.title,
                posterPath: searchEntity.posterPath,
                releaseDate: searchEntity.releaseDate,
                voteAverage: searchEntity.voteAverage.toDouble(),
              ),
            ],
          ),
        );
      },
    );
  }



// Widget _buildPersonsList(List<PersonEntity> results) {
//   if (results.isEmpty) {
//     return Center(
//       child: Text(
//         AppString.noResultsFound,
//         style: getMediumStyle(fontSize: FontSize.s16),
//       ),
//     );
//   }
//   return ListView.builder(
//     physics: const BouncingScrollPhysics(),
//     itemCount: results.length,
//     itemBuilder: (context, index) {
//       final searchEntity = results[index];
//       return InkWell(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => PersonDetailView(
//                 id: searchEntity.id,
//               ),
//             ),
//           );
//         },
//         child: Column(
//           children: [
//             SearchResultsItem(item: searchEntity),
//           ],
//         ),
//       );
//     },
//   );
// }
}