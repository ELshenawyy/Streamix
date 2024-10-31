import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/global/resources/app_color.dart';
import '../../../search/presentation/controller/history_bloc.dart';
import '../../../search/presentation/controller/history_events.dart';
import '../../../search/presentation/controller/history_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search History',
          style: GoogleFonts.poppins(fontSize: 22.sp),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<HistoryBloc>().add(ClearHistory());
        },
        label: Text(
          'Clear All',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontSize: 15.sp,
          ),
        ),
        icon: Icon(Icons.delete,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.gold),
            );
          } else if (state is HistoryLoaded) {
            if (state.history.isEmpty) {
              return Center(
                child: Text(
                  'No search history found.',
                  style: GoogleFonts.poppins(
                    color: AppColors.gold,
                    fontSize: 18.sp,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final entry = state.history[index];
                return ListTile(
                  title: Text(entry.query), // Display the movie name
                  subtitle: Text(
                    'Searched on: ${entry.timestamp.toLocal().toString().split('.')[0]}',
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Failed to load search history.',
                style: GoogleFonts.poppins(
                  color: AppColors.gold,
                  fontSize: 18.sp,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
