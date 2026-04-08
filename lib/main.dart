import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/sources/api_client.dart';
import 'logic/home_cubit.dart';
import 'logic/search_cubit.dart';
import 'logic/detail_cubit.dart';
import 'logic/reader_cubit.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const MangaMintApp());
}

class MangaMintApp extends StatelessWidget {
  const MangaMintApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiClient()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit(context.read<ApiClient>())),
          BlocProvider(create: (context) => SearchCubit(context.read<ApiClient>())),
          BlocProvider(create: (context) => DetailCubit(context.read<ApiClient>())),
          BlocProvider(create: (context) => ReaderCubit(context.read<ApiClient>())),
        ],
        child: MaterialApp(
          title: 'MangaMint',
          theme: ThemeData.dark().copyWith(
            primaryColor: Colors.teal,
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1F1F1F),
              elevation: 0,
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
