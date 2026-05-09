import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myalquran/core/routes/route_names.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';
import 'package:myalquran/domain/usecase/get_all_bookmark.dart';
import 'package:myalquran/domain/usecase/get_all_surah.dart';
import 'package:myalquran/domain/usecase/get_detail_surah.dart';
import 'package:myalquran/domain/usecase/get_last_read.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_bloc.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_event.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_bloc.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_event.dart';
import 'package:myalquran/features/home/pages/home_page.dart';
import 'package:myalquran/features/surah/bloc/surah_bloc.dart';
import 'package:myalquran/features/surah/bloc/surah_event.dart';
import 'package:myalquran/features/surah/pages/surah_page.dart';
import 'package:myalquran/shared/widgets/text_custom.dart';
import 'package:quran/surah_data.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              // usecase
              final getAllSurah = GetAllSurah(
                quranRepository: context.read<QuranRepository>(),
              );
              final getLastRead = GetLastRead(
                quranRepository: context.read<QuranRepository>(),
              );
              return SurahListBloc(getAllSurah, getLastRead)
                ..add(FetchSurahEvent());
            },
          ),
          BlocProvider(
            create: (context) {
              // usecase
              final getAllBookmark = GetAllBookmark(
                  quranRepository: context.read<QuranRepository>());
              final getLastRead =
                  GetLastRead(quranRepository: context.read<QuranRepository>());

              return BookmarkBloc(getAllBookmark, getLastRead)
                ..add(LoadAllBookmark());
            },
          ),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: Routes.surah,
      builder: (context, state) {
        final int? nomorSurah =
            int.tryParse(state.pathParameters['nomor'] ?? "");
        final int? verseIndex =
            int.tryParse(state.uri.queryParameters['verseIndex'] ?? "");

        if (nomorSurah == null || nomorSurah == 0) {
          return const NotFoundPage();
        }

        return BlocProvider(
          create: (context) {
            final getDetailSurah = GetDetailSurah(
              quranRepository: context.read<QuranRepository>(),
            );
            final getAllSurah = GetAllSurah(
              quranRepository: context.read<QuranRepository>(),
            );

            return SurahBloc(
              getDetailSurah: getDetailSurah,
              getAllSurah: getAllSurah,
            )..add(LoadSurahEvent(surahNumber: nomorSurah));
          },
          child: SurahPage(verseIndex: verseIndex),
        );
      },
    )
  ],
);

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextCustom(
          "404 \nPage Not Found",
          textAlign: TextAlign.center,
          fontSize: 25.sp,
        ),
      ),
    );
  }
}
