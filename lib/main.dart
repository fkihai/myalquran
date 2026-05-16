import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myalquran/core/constant/color.dart';
import 'package:myalquran/core/network/dio_client.dart';
import 'package:myalquran/core/routes/app_router.dart';
import 'package:myalquran/core/db/database_manager.dart';
import 'package:myalquran/data/datasources/local_datasource.dart';
import 'package:myalquran/data/datasources/remote_datasource.dart';
import 'package:myalquran/data/repositories/quran_repository_impl.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DatabaseManager>(
          create: (_) => DatabaseManager.instance,
        ),
        RepositoryProvider<LocalDatasource>(
          create: (ctx) => LocalDatasource(ctx.read<DatabaseManager>()),
        ),
        RepositoryProvider<RemoteDatasource>(
            create: (ctx) => RemoteDatasource(DioClient())),
        RepositoryProvider<QuranRepository>(
          create: (ctx) => QuranRepositoryImpl(
            ctx.read<LocalDatasource>(),
            ctx.read<RemoteDatasource>(),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) {
        return MaterialApp.router(
          title: "My Alqur'an",
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: appLight,
        );
      },
      child: const Scaffold(),
    );
  }
}
