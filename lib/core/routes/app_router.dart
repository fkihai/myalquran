import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myalquran/core/routes/route_names.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';
import 'package:myalquran/domain/usecase/get_all_surah.dart';
import 'package:myalquran/features/home/bloc/home_bloc.dart';
import 'package:myalquran/features/home/pages/home_page.dart';
import 'package:myalquran/features/surah/bloc/surah_bloc.dart';
import 'package:myalquran/features/surah/pages/surah_page.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (context, state) => BlocProvider(
        create: (context) {
          // usecase
          final getAllSurah = GetAllSurah(
            quranRepository: context.read<QuranRepository>(),
          );
          return HomeBloc(getAllSurah);
        },
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: Routes.surah,
      builder: (context, state) => BlocProvider(
        create: (context) => SurahBloc(),
        child: const SurahPage(),
      ),
    )
  ],
);
