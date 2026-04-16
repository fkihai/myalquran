import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalquran/features/surah/bloc/surah_bloc.dart';
import 'package:myalquran/features/surah/bloc/surah_state.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SurahBloc, SurahState>(
        listener: (context, state) {},
        child: const Center(
          child: Text('SurahPage'),
        ),
      ),
    );
  }
}
