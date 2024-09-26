import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/movies/presentation/screens/movies_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/styles.dart';
import '../../../favourits/presentation/favoutite_screen.dart';
import '../../../search/presentation/screens/search_view.dart';
import '../manager/navigation_provider.dart';

class CurvedNavigationBarScreen extends StatefulWidget {
  const CurvedNavigationBarScreen({super.key});

  @override
  State<CurvedNavigationBarScreen> createState() =>
      _CurvedNavigationBarScreenState();
}

class _CurvedNavigationBarScreenState extends State<CurvedNavigationBarScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = <Widget>[
    const MoviesScreen(),
    FavoriteScreen(),
    const SearchView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[Provider.of<NavigationProvider>(context).currentPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.h,
        backgroundColor: const Color(0xffEB5757),
        key: _bottomNavigationKey,
        animationCurve: Easing.legacyDecelerate,
        animationDuration: const Duration(seconds: 1),
        color: Theme.of(context).scaffoldBackgroundColor,
        items: [
          CurvedNavigationBarItem(
            child: Icon(
              Icons.home_outlined,
              size: 24.sp,
            ),
            label: 'Home',
            labelStyle: AppStyles.style6(context),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.favorite_border_rounded,
              size: 24.sp,
            ),
            label: 'Favorite',
            labelStyle: AppStyles.style6(context),

          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.search,
              size: 24.sp,
            ),
            label: 'Search',
            labelStyle: AppStyles.style6(context),
          ),
        ],
        onTap: (index) {
          Provider.of<NavigationProvider>(context, listen: false)
              .setCurrentPageIndex(index);
        },
      ),
    );
  }
}
