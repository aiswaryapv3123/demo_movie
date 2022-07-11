import 'dart:async';
import 'dart:io';

import 'package:demo_movie/src/api/services.dart';
import 'package:demo_movie/src/bloc/bloc.dart';
import 'package:demo_movie/src/bloc/states.dart';
import 'package:demo_movie/src/bloc/events.dart';
import 'package:demo_movie/src/db/data_base.dart';
import 'package:demo_movie/src/models/genres_model.dart';
import 'package:demo_movie/src/models/get_genres_model.dart';
import 'package:demo_movie/src/models/get_movies_model.dart';
import 'package:demo_movie/src/models/movie_model.dart';
import 'package:demo_movie/src/models/trending_movies_model.dart' as trend;
import 'package:demo_movie/src/utils/constants.dart';
import 'package:demo_movie/src/utils/urls.dart';
import 'package:demo_movie/src/utils/utils.dart';
import 'package:demo_movie/src/widgets/app_bar.dart';
import 'package:demo_movie/src/widgets/build_button.dart';
import 'package:demo_movie/src/widgets/categories_list.dart';
import 'package:demo_movie/src/widgets/genre_tab_view.dart';
import 'package:demo_movie/src/widgets/language_picker_widget.dart';
import 'package:demo_movie/src/widgets/movie_now_playing_list.dart';
import 'package:demo_movie/src/widgets/movie_trending_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<GetGenresModel>? futureGenres;
  final MovieBloc trendingmovieBloc = MovieBloc();
  final MovieBloc movieBloc = MovieBloc();
  final MovieBloc genreBloc = MovieBloc();
  late List<Movie> movies;
  bool? online;
  String genreId = '12';
  List<Movie>? movieByGenreList;
  List<Movie>? movieByGenre;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<MovieBloc>().g;
    // _loadData();
    // movieBloc.add(MovieData());
    movieBloc.add(MovieData());
    trendingmovieBloc.add(TrendingMovieData());
    genreBloc.add(GenresData());
    futureGenres = getGenres();
    getMovieByGenre(genreId);
    // refreshNotes();
  }

  Future getMovieByGenre(String genreId) async {
    movieByGenreList =
        await MovieDatabase.instance.readAllMoviesByGenre(genreId);
    setState(() {
      movieByGenre = movieByGenreList;
    });
  }

  Future<void> refreshMovies() async {
    // setState(() {});
  }

  Future<GetGenresModel> getGenres() async {
    // TODO: implement getMovies
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=6baea5ef838664a28d1e5b5e8ca1635b");
    Response response = await http.get(uri);
    print("response");
    print(response.body);
    GetGenresModel genresData = getGenresModelFromJson(response.body);
    print("Data");
    print(genresData);
    return genresData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
          leading: Container(),
          elevation: 4,
          actions: [
            MovieAppBar(
              title: AppLocalizations.of(context)?.demoMovie ?? "Demo Movie",
              leftIcon: Icon(Icons.menu_rounded),
              rightIcon: LanguagePickerWidget(),
              onTapRightIcon: () {},
            )
          ],
        ),
        body: Builder(
          builder: (BuildContext context) {
            return OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  Timer timer = Timer(Duration(seconds: 3), () {
                    setState(() {
                      online = true;
                    });
                  });
                  return Container(
                    child: Stack(
                      children: [
                        child,
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            color: connected
                                ? Color(0xFF00EE44)
                                : Color(0xFFEE4400),
                            child: connected
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Text(
                                        "OFFLINE",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      SizedBox(
                                        width: 12.0,
                                        height: 12.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 30),
                              right: screenWidth(context, dividedBy: 30),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight(context, dividedBy: 30),
                                ),
                                RefreshIndicator(
                                  onRefresh: refreshMovies,
                                  child: BlocProvider(
                                    create: (context) => movieBloc,
                                    child: BlocBuilder<MovieBloc, MovieStates>(
                                        builder: (BuildContext context,
                                            MovieStates state) {
                                      if (state is MoviesErrorState) {
                                        return Container(
                                          height: screenHeight(context,
                                              dividedBy: 7),
                                          width: screenWidth(context,
                                              dividedBy: 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Constants.colors[3]),
                                          child: Center(
                                            child: Text(state.error.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                          ),
                                        );
                                      }
                                      if (state is MoviesLoadedState) {
                                        List<Movie> movieList = state.movieList;
                                        return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              if (movieList.isNotEmpty)
                                                MovieNowPlayingList(
                                                  movieList: movieList,
                                                ),
                                              // CategoriesList(),
                                            ],
                                          ),
                                        );
                                      }
                                      print("Loading movies state");
                                      return SizedBox(
                                        width:
                                            screenWidth(context, dividedBy: 1),
                                        height:
                                            screenHeight(context, dividedBy: 7),
                                        // color: Colors.red,
                                        child: const Center(
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight(context, dividedBy: 80),
                                ),
                                BlocProvider(
                                  create: (context) => trendingmovieBloc,
                                  child: BlocBuilder<MovieBloc, MovieStates>(
                                      builder: (BuildContext context,
                                          MovieStates state) {
                                    if (state is TrendingErrorState) {
                                      return Container(
                                        height:
                                            screenHeight(context, dividedBy: 7),
                                        width:
                                            screenWidth(context, dividedBy: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Constants.colors[3]),
                                        child: Center(
                                          child: Text(state.error.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                      );
                                    }
                                    if (state is TrendingLoadedState) {
                                      List<Movie> trendingMovieList =
                                          state.moviesData;
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            if (trendingMovieList.isNotEmpty)
                                              MovieTrendingList(
                                                movieList: trendingMovieList,
                                              ),
                                            // CategoriesList(),
                                          ],
                                        ),
                                      );
                                    }
                                    return SizedBox(
                                      width: screenWidth(context, dividedBy: 1),
                                      height:
                                          screenHeight(context, dividedBy: 7),
                                      // color: Colors.white,
                                      child: const Center(
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),

                                ///
                                ///
                                SizedBox(
                                  height: screenHeight(context, dividedBy: 80),
                                ),
                                GenreTabView(
                                  onTapItem: (val) async {
                                    getMovieByGenre(val);
                                  },
                                ),
                                if (movieByGenre != null)
                                  movieByGenre!.isNotEmpty
                                      ? MovieTrendingList(
                                          movieList: movieByGenre,
                                        )
                                      : SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 1),
                                          height: screenHeight(context,
                                              dividedBy: 5),
                                          child: const Center(
                                            child: Text("No Movies"),
                                          ),
                                        ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container());
          },
        ));
  }
}
