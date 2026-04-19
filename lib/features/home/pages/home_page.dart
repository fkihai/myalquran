import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_bloc.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_state.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_bloc.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_state.dart';
import 'package:myalquran/features/home/widgets/surah.dart';
import 'package:myalquran/shared/widgets/text_custom.dart';

import '../../../app/modules/widget/search_field.dart';
import '../../../core/constant/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            width: 140.w,
            "assets/img/logo-appbar.png",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Al Qur'an",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: appGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Reading Surah",
                  style: TextStyle(
                    fontSize: 20,
                    color: appBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                const SearchField(),
                SizedBox(height: 10.h),
                TabBar.secondary(
                  indicatorColor: appBlueLight1,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        height: 30.h,
                        child: const Text(
                          'Surah',
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        height: 30.h,
                        child: const Text(
                          'Bookmark',
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocBuilder<SurahListBloc, SurahListState>(
                        builder: (context, state) {
                          if (state is SurahListLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is SurahListLoaded) {
                            return SurahWidget(surahList: state.allSurah);
                          } else if (state is SurahListError) {
                            return Center(child: TextCustom(state.message));
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      BlocBuilder<BookmarkBloc, BookmarkState>(
                          builder: (context, state) {
                        if (state is BookmarkLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is BookmarkLoaded) {
                          return const SizedBox();
                        } else {
                          return const SizedBox();
                        }
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
