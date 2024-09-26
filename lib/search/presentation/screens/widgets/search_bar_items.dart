import 'package:flutter/material.dart';


import '../../../../core/global/resources/app_color.dart';
import '../../../../core/global/resources/strings_manger.dart';
import '../../../../core/global/resources/styles_manager.dart';
import 'cancel_text_button.dart';

class SearchBarItems extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? clearSearch;
  final FocusNode focusNode;

  const SearchBarItems({
    required this.controller,
    required this.clearSearch,
    super.key, required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              cursorColor: AppColors.gold,
              style: getMediumStyle(fontSize:16).copyWith(
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 6,
                ),
                hintText: '${AppString.search} ${AppString.appName}',
                hintStyle: getMediumStyle(fontSize: 14).copyWith(
                  color: AppColors.grey,
                ),
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: AppColors.grey,
                filled: true,
                fillColor: AppColors.white,
                border: _outlineInputBorder(),
                enabledBorder: _outlineInputBorder(),
                focusedBorder: _outlineInputBorder(),
              ),
            ),
          ),
          CancelTextButton(onPressed: clearSearch),
        ],
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        16,
      ),
      borderSide: BorderSide.none,
    );
  }
}