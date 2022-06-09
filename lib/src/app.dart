import 'package:demo_movie/src/bloc/bloc.dart';
import 'package:demo_movie/src/bloc/events.dart';
import 'package:demo_movie/src/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final MovieBloc movieBloc = MovieBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadData();
    // movieBloc.add(MovieData());
    movieBloc.add(TrendingMovieData());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF171717),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF171717),
          secondary: const Color(0xFF2E2E2E),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(
              fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      home: HomePage(),
      // BlocProvider(
      //   create: (context) => movieBloc,
      //   child: HomePage(),
      // ),
    );
  }
}
