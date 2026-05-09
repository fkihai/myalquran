import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myalquran/core/constant/color.dart';
import 'package:myalquran/features/surah/bloc/surah_bloc.dart';
import 'package:myalquran/features/surah/bloc/surah_state.dart';
import 'package:myalquran/features/surah/bloc/surah_event.dart';
import 'package:myalquran/shared/widgets/text_custom.dart';
import 'package:quran/quran.dart' as quran;

class SurahPage extends StatelessWidget {
  const SurahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahBloc, SurahState>(
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

        final initialIndex = state.detailSurah != null
            ? state.allSurah
                .indexWhere((s) => s.nomor == state.detailSurah!.nomor)
            : 0;

        return DefaultTabController(
          length: state.allSurah.length,
          initialIndex: initialIndex != -1 ? initialIndex : 0,
          child: Scaffold(
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
                    onTap: (index) {
                      final surahNumber = state.allSurah[index].nomor;
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
                                    s.nameLatin,
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
                    physics: const NeverScrollableScrollPhysics(),
                    children: state.allSurah.map((surah) {
                      if (state.detailSurah != null &&
                          state.detailSurah!.nomor == surah.nomor) {
                        return ListView.builder(
                          itemCount: state.detailSurah!.verses.length,
                          itemBuilder: (context, index) {
                            final verse = state.detailSurah!.verses[index];
                            return Column(
                              children: [
                                if (index == 0) ...[
                                  _buildSurahTitle(surah),
                                  _buildBasmalah(surah.nomor),
                                ],
                                _buildVerseItem(verse),
                              ],
                            );
                          },
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(color: appBlueLight1),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSurahTitle(dynamic surah) {
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
          '${surah.totalVerses} Ayat | ${surah.revalationPlace}',
          color: appWhite,
        ),
        trailing: TextCustom(
          surah.name,
          // fontFamily: 'Lpmq',
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
              // fontFamily: 'Lpmq',
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

  Widget _buildVerseItem(dynamic verse) {
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
                onPressed: () {
                  // TODO: Implement more options / bookmark
                },
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
                                text: '${verse.ar} ',
                                style: TextStyle(
                                  fontFamily: 'Lpmq',
                                  color: appBlueLight1,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 2.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: quran.getVerseEndSymbol(verse.nomor),
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
                          verse.tr,
                          fontSize: 13.sp,
                          color: appBlueLight1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextCustom(
                          verse.idn,
                          fontSize: 13.sp,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const Divider(thickness: 0.6, color: appBlack),
        ],
      ),
    );
  }
}
