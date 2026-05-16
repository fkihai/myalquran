import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myalquran/core/constant/color.dart';
import 'package:myalquran/domain/entities/verses.dart';
import 'package:myalquran/features/surah/bloc/surah_bloc.dart';
import 'package:myalquran/features/surah/bloc/surah_state.dart';
import 'package:myalquran/features/surah/bloc/surah_event.dart';
import 'package:myalquran/features/surah/widgets/modal_verses.dart';
import 'package:myalquran/shared/widgets/text_custom.dart';
import 'package:quran/quran.dart' as quran;
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../domain/entities/surah.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> with TickerProviderStateMixin {
  late AutoScrollController autoScrollController;
  TabController? tabController;
  bool _isFirstScrollDone = false;

  @override
  void initState() {
    super.initState();
    autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurahBloc, SurahState>(
      listener: (context, state) {
        if (tabController != null) {
          final targetIndex = state.allSurah
              .indexWhere((s) => s.number == state.currentSurahNumber);

          if (targetIndex != -1 && tabController!.index != targetIndex) {
            tabController!.animateTo(targetIndex);
          }
        }
      },
      child: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          if (state.isLoading && state.allSurah.isEmpty) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.errorMessage != null && state.allSurah.isEmpty) {
            return Scaffold(
              body: Center(child: TextCustom(state.errorMessage!)),
            );
          }

          // Trigger auto-scroll once when data is ready
          if (!_isFirstScrollDone &&
              state.currentVerseNumber != null &&
              state.verseList != null &&
              !state.isLoading) {
            _isFirstScrollDone = true;
            final scrollIndex = state.currentVerseNumber! - 1;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              autoScrollController.scrollToIndex(
                scrollIndex,
                preferPosition: AutoScrollPosition.begin,
              );
            });
          }

          final initialIndex = state.verseList != null
              ? state.allSurah
                  .indexWhere((s) => s.number == state.currentSurahNumber)
              : 0;

          // Ensure tabController is initialized if it's null or length changed
          if (tabController == null ||
              tabController!.length != state.allSurah.length) {
            tabController = TabController(
              length: state.allSurah.length,
              vsync: this,
              initialIndex: initialIndex != -1 ? initialIndex : 0,
            );
          }

          final currentSurah = state.allSurah.firstWhere(
            (s) => s.number == state.currentSurahNumber,
            orElse: () => state.allSurah.isNotEmpty
                ? state.allSurah.first
                : const Surah(
                    id: 0,
                    number: 0,
                    nameArabic: '',
                    nameLatin: '',
                    nameTransliteration: '',
                    numberOfAyahs: 0,
                    revelationType: '',
                  ),
          );

          return Scaffold(
            appBar: AppBar(
              title: Image.asset(width: 130.w, 'assets/img/logo-appbar.png'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar.secondary(
                    isScrollable: true,
                    controller: tabController,
                    onTap: (index) {
                      // Fetch detail for the selected Surah
                      final surahNumber = state.allSurah[index].number;
                      context
                          .read<SurahBloc>()
                          .add(LoadSurahEvent(surahNumber: surahNumber));
                    },
                    tabs: state.allSurah
                        .map((s) => Tab(
                              child: SizedBox(
                                height: 30.h,
                                child: Center(
                                  child: TextCustom(
                                    s.nameTransliteration,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: state.allSurah.map((surah) {
                      // If this is the active tab and data matches the current surah
                      if (state.verseList != null &&
                          state.currentSurahNumber == surah.number) {
                        return ListView.builder(
                          controller: autoScrollController,
                          itemCount: state.verseList!.length,
                          itemBuilder: (context, index) {
                            final verse = state.verseList![index];
                            return AutoScrollTag(
                              key: ValueKey(index),
                              controller: autoScrollController,
                              index: index,
                              child: Column(
                                children: [
                                  // Surah Title and Basmalah at the start of the list
                                  if (index == 0) ...[
                                    _buildSurahTitle(currentSurah),
                                    _buildBasmalah(currentSurah.number),
                                  ],
                                  _buildVerseItem(
                                    verse,
                                    surah.nameTransliteration,
                                    state,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      // Show loading spinner for specific tab content
                      return const Center(
                        child: CircularProgressIndicator(color: appBlueLight1),
                      );
                    }).toList(),
                  ),
                ),

                // note: // Temporarily disabled because audio source URLs are no longer accessible.
                // if (state.verseList != null) _bottomBar(currentSurah)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSurahTitle(Surah surah) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.blue.shade300,
        title: TextCustom(
          surah.nameLatin,
          color: appWhite,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TextCustom(
          '${surah.numberOfAyahs} Ayat | ${surah.revelationType}',
          color: appWhite,
        ),
        trailing: TextCustom(
          surah.nameArabic,
          fontFamily: 'Lpmq',
          fontSize: 30.sp,
          color: appWhite,
        ),
      ),
    );
  }

  Widget _buildBasmalah(int nomor) {
    if (nomor != 1 && nomor != 9) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
            child: TextCustom(
              'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
              fontFamily: 'Lpmq',
              fontWeight: FontWeight.bold,
              color: appBlack,
              fontSize: 25.sp,
            ),
          ),
          const Divider(thickness: 0.6, color: appBlack),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _buildVerseItem(Verse verse, String surahName, SurahState state) {
    final bool isBookmarked = state.bookmarks.any((b) =>
        b.surahId == state.currentSurahNumber &&
        b.verseNumber == verse.numberInSurah);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                color: appBlack,
                onPressed: () => ModalVerses.show(
                  context: context,
                  surahName: surahName,
                  verseNumber: verse.numberInSurah,
                  isBookmarked: isBookmarked,
                  onLastRead: () {
                    context.read<SurahBloc>().add(
                          AddLastReadEvent(
                            surahId: state.currentSurahNumber!,
                            verseNumber: verse.numberInSurah,
                            juzNumber: verse.juz,
                            surahName: surahName,
                          ),
                        );
                  },
                  onBookmark: () {
                    context.read<SurahBloc>().add(
                          AddBookmarkEvent(
                            surahId: state.currentSurahNumber!,
                            verseNumber: verse.numberInSurah,
                            juzNumber: verse.juz,
                            surahName: surahName,
                          ),
                        );
                  },
                ),
                icon: const Icon(Icons.more_vert),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                text: '${verse.textUthmani} ',
                                style: TextStyle(
                                  fontFamily: 'Lpmq',
                                  color: appBlueLight1,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 2.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: quran
                                        .getVerseEndSymbol(verse.numberInSurah),
                                    style: TextStyle(
                                      fontFamily: 'Lpmq',
                                      color: appBlueLight1,
                                      fontSize: 27.sp,
                                      fontWeight: FontWeight.bold,
                                      height: 2.3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextCustom(
                          verse.translation,
                          fontSize: 13.sp,
                          color: appBlueLight1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.6, color: appBlack),
        ],
      ),
    );
  }

  Widget _bottomBar(Surah surah) {
    return Container(
      width: double.infinity,
      height: 75.h,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 2,
        )
      ]),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Putar Surah',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                surah.nameTransliteration,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(width: 1.0, color: Colors.blue.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.play_arrow, color: Colors.green.shade200),
                  const Text('Putar'),
                  SizedBox(width: 5.w)
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
