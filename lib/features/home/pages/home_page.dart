import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myalquran/core/constant/color.dart';
import 'package:myalquran/core/routes/route_names.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_bloc.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_state.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_bloc.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_event.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_state.dart';
import 'package:myalquran/features/home/widgets/list_bookmark.dart';
import 'package:myalquran/features/home/widgets/list_surah.dart';
import 'package:myalquran/features/home/widgets/search_field.dart';
import 'package:myalquran/shared/widgets/text_custom.dart';

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
                SearchField(onChange: (value) {
                  context.read<SurahListBloc>().add(FilterSurahEvent(value));
                }),
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
                            return ListSurahWidget(surahList: state.allSurah);
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
                          return ListBookmarkWidget(
                              bookmarks: state.allBookmark);
                        } else {
                          return const SizedBox();
                        }
                      })
                    ],
                  ),
                ),
                BlocBuilder<SurahListBloc, SurahListState>(
                    builder: (context, state) {
                  if (state is SurahListLoaded && state.lastRead != null) {
                    return InkWell(
                      onTap: () {
                        context.push(
                          Routes.toDetailSurah(
                            state.lastRead!.surahNumber,
                            verseIndex: state.lastRead!.verseIndex - 1,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          leading: const Icon(Icons.book),
                          title: const TextCustom('Lanjutkan Membaca'),
                          subtitle: TextCustom(
                            "QS. ${state.lastRead?.surahNameLatin}: Ayat ${state.lastRead?.verseIndex}",
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
