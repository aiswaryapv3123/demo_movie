import 'package:demo_movie/l10n/l10n.dart';
import 'package:demo_movie/src/bloc/bloc.dart';
import 'package:demo_movie/src/bloc/events.dart';
import 'package:demo_movie/src/provider/locale_provider.dart';
import 'package:demo_movie/src/screens/home_page.dart';
import 'package:demo_movie/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadData();
    // movieBloc.add(MovieData());
    // movieBloc.add(MovieData());
    // trendingmovieBloc.add(TrendingMovieData());
    // genreBloc.add(GenresData());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
    builder: (context, child) {
    final provider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode:ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      locale: provider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: HomePage(),
      // BlocProvider(
      //   create: (context) => movieBloc,
      //   child: HomePage(),
      // ),
    );
    },
    );
  }
}
