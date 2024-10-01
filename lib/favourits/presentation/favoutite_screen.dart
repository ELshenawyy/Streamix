import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../core/utils/styles.dart';
import 'controller/favoutite_screen_provider.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch favorite movies
    Provider.of<FavoriteMovieProvider>(context, listen: false)
        .fetchFavoriteMovie();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteMovieProvider>(context);
    final favoriteProduct = favoriteProvider.favoriteMovie;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Favorite', style: AppStyles.colorPageTitle(context)),
      ),
      body: favoriteProduct == null || favoriteProduct.isEmpty
          ? const Center(child: Text('No favorites added yet'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: favoriteProduct.length,
              itemBuilder: (context, index) {
                return buildFavoriteItem(context, favoriteProduct[index]);
              },
            ),
    );
  }

  Widget buildFavoriteItem(BuildContext context, Map<String, dynamic> movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width: 182.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 230.h,
                width: 182.w,
                child: InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: movie['image'].startsWith('/')
                          ? ApiConstance.baseImageUrl + movie['image']
                          : movie['image'],
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          id: int.parse(movie['id']),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 175.h,
                left: 120.w,
                child: IconButton(
                  onPressed: () async {
                    await Provider.of<FavoriteMovieProvider>(context,
                            listen: false)
                        .removeFavoriteMovie(movie['id']);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: const Color(0xffEB5757),
                    size: 26.sp,
                  ),
                ),
              ),
            ],
          ),
          Text(
            movie['title'],
            overflow: TextOverflow.ellipsis,
            style: AppStyles.colorMovieTitle(context),
          ),
        ],
      ),
    );
  }
}
