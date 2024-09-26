import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/global/resources/styles_manager.dart';
import '../../../../../core/global/resources/values_manager.dart';
import '../../../../core/global/resources/app_color.dart';
import '../../../../core/global/resources/strings_manger.dart';
import '../../../../core/global/theme/manager/theme_notifier.dart';

class SearchTitleListView extends StatefulWidget {
  final Function(int) onSearchTypeChanged;

  const SearchTitleListView({super.key, required this.onSearchTypeChanged});

  @override
  SearchTitleListViewState createState() => SearchTitleListViewState();
}

class SearchTitleListViewState extends State<SearchTitleListView> {
  int _selectedIndex = 0;

  final List<String> items = [
    AppString.moviesNav,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            widget.onSearchTypeChanged(_selectedIndex);
          },
          child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: _selectedIndex == index
                      ? AppColors.gold
                      : Colors.transparent,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p2,
                  horizontal: AppPadding.p8,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m8,
                ),
                child: Center(
                  child: Text(
                    items[index],
                    style: getSemiBoldStyle(fontSize: 16.0).copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
