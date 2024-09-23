import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/utils/styles.dart';
import 'manager/favoutite_screen_provider.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
   String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    final favoriteProduct =
        Provider.of<FavoriteMovieProvider>(context).favoriteMovie;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Favorite', style: AppStyles.colorPageTitle(context)),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: favoriteProduct!.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(5),
              width: 182.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 205.h,
                        width: 182.w,
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),

                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: favoriteProduct[index]['image'].startsWith('/')
                              ? baseUrl + favoriteProduct[index]['image']
                              : favoriteProduct[index]['image'],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 160.h,
                        left: 120.w,
                        child: IconButton(
                          onPressed: () async {
                            await Provider.of<FavoriteMovieProvider>(context,
                                listen: false)
                                .removeFavoriteMovie(
                                favoriteProduct[index]['id']);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: const Color(0xffEB5757),
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    favoriteProduct[index]['title'],
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.colorMovieTitle(context),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
