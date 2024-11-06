import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/darkmode.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../core/global/resources/app_color.dart';
import '../../core/global/resources/strings_manger.dart';
import '../../core/utils/styles.dart';
import 'controller/favourite_screen_provider.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    // Fetch favorite movies
    _fetchAndSetFavorites();
  }

  Future<void> _fetchAndSetFavorites() async {
    await Provider.of<FavoriteMovieProvider>(context, listen: false)
        .fetchFavoriteMovie();
    _updateFilteredMovies();
  }

  void _updateFilteredMovies() {
    final provider = Provider.of<FavoriteMovieProvider>(context, listen: false);
    setState(() {
      filteredMovies = provider.favoriteMovie ?? [];
    });
  }

  void _filterMovies(String query) {
    final provider = Provider.of<FavoriteMovieProvider>(context, listen: false);
    setState(() {
      filteredMovies = provider.favoriteMovie?.where((movie) {
        return movie['title'].toLowerCase().contains(query.toLowerCase());
      }).toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteMovieProvider>(context);
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Favorites (${favoriteProvider.favoriteMovie?.length})',
          style: GoogleFonts.montserrat(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Search_duotone.svg",
              width: 25,
              height: 25,
              color: darkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: MovieSearchDelegate(onSearch: _filterMovies));
            },
          ),
        ],
      ),
      body: filteredMovies.isEmpty
          ? Center(
          child: Text(AppString.noFavouriteAddedYet,
              style: GoogleFonts.poppins(
                  color: AppColors.gold, fontSize: 18.sp)))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.73,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          return buildFavoriteItem(context, filteredMovies[index]);
        },
      ),
    );
  }

  Widget buildFavoriteItem(BuildContext context, Map<String, dynamic> movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 182.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 180.h,
                width: 182.w,
                child: InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: movie['image'].startsWith('/')
                          ? ApiConstance.baseImageUrl + movie['image']
                          : movie['image'],
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/fallback_image.png'),
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
                bottom: 130.h,
                left: 115.w,
                child: IconButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>( // Show dialog for confirmation
                      context: context,
                      builder: (context) {
                        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

                        return AlertDialog(
                          title: Text(
                            'Remove from Favorites',
                            style: GoogleFonts.montserrat(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to remove this movie from your favorites?',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: isDarkMode ? Colors.white : Colors.grey,
                              ),
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(fontSize: 16.sp),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xffEB5757),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                'Remove',
                                style: GoogleFonts.poppins(fontSize: 16.sp),
                              ),
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
                        );
                      },
                    );

                    if (confirm == true) {
                      await Provider.of<FavoriteMovieProvider>(context, listen: false)
                          .removeFavoriteMovie(movie['id']);

                      // Re-fetch the favorites to ensure we have the latest data
                      _fetchAndSetFavorites();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Movie removed from favorites')),
                      );
                    }
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
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}


class MovieSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  MovieSearchDelegate({required this.onSearch});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
          onSearch(query); // Call the search function with the cleared query
          showSuggestions(context); // Optionally show suggestions
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<FavoriteMovieProvider>(context);
    final suggestions = provider.favoriteMovie!.where((movie) {
      return movie['title'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final movie = suggestions[index];
        return ListTile(
          title: Text(movie['title']),
          onTap: () {
            // Close the search and update the main screen with the selected suggestion
            onSearch(movie['title']);
            close(context, null);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query); // Filter movies based on the current query
    close(context, null); // Close the search delegate
    return Container(); // Just closing the search for simplicity
  }
}
