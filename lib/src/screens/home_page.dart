import 'dart:async';
import 'dart:io';

import 'package:demo_movie/src/api/services.dart';
import 'package:demo_movie/src/bloc/bloc.dart';
import 'package:demo_movie/src/bloc/states.dart';
import 'package:demo_movie/src/bloc/events.dart';
import 'package:demo_movie/src/db/data_base.dart';
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
import 'package:demo_movie/src/widgets/movie_now_playing_list.dart';
import 'package:demo_movie/src/widgets/movie_trending_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<GetGenresModel>? futureGenres;
  final MovieBloc trendingmovieBloc = MovieBloc();
  final MovieBloc movieBloc = MovieBloc();
  late List<Movie> movies;
  bool? online;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadData();
    // movieBloc.add(MovieData());
    movieBloc.add(MovieData());
    trendingmovieBloc.add(TrendingMovieData());
    futureGenres = getGenres();
    // refreshNotes();
  }

  Future refreshNotes() async {
    // setState(() => isLoading = true);
    movies = await MovieDatabase.instance.readAllMovies(tableMovie);
    print("Moviessssss");
    print("------------");
    for (int i = 0; i < movies.length; i++) {
      print(movies[i].title);
    }

    // setState(() => isLoading = false);
  }

  Future<void> refreshMovies() async {
    try {
      final response = await http.get(Uri.parse(Url.movies
          // "https://api.themoviedb.org/3/discover/movie?api_key=6baea5ef838664a28d1e5b5e8ca1635b"
          ));
      MoviesModel movies = moviesModelFromJson(response.body);
      print("Data movies");
      print(movies);
      print(movies.results);
      print(movies.totalResults);
      movies.results ?? print("Nothing");
      for (int i = 0; i < movies.results!.length; i++) {
        final movie = Movie(
          title: movies.results![i].title,
          posterPath: movies.results![i].posterPath,
          voteAverage: movies.results![i].voteAverage,
          overview: movies.results![i].overview,
          releaseDate: movies.results![i].releaseDate,
        );
        MovieDatabase.instance.create(movie, tableMovie);
        // refreshNotes();
        print("Movie DATABASE");
        print("---------------");
        print(MovieDatabase.instance);
      }
      setState(() {});
    } on SocketException {
      print("NO Internet");
    } catch (e) {
      print("Error ");
      print(e);
    }
    // moviesList = await MovieDatabase.instance.readAllMovies();
    // print("Moviessssss");
    // print("------------");
    // for (int i = 0; i < moviesList.length; i++) {
    //   print(moviesList[i].title);
    // }
    // return moviesList;
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
          leading: Container(),
          elevation: 4,
          actions: const [
            MovieAppBar(
              title: "Demo Movie",
              leftIcon: Icon(Icons.menu_rounded),
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
                                left: screenWidth(context, dividedBy: 30)),
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
                                  height: screenHeight(context, dividedBy: 30),
                                ),
                                BlocProvider(
                                  create: (context) => trendingmovieBloc,
                                  child: BlocBuilder<MovieBloc, MovieStates>(
                                      builder: (BuildContext context,
                                          MovieStates state) {
                                    if (state is TrendingErrorState) {
                                      return Container(
                                        height: screenHeight(context, dividedBy: 7),
                                        width: screenWidth(context, dividedBy: 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color:Constants.colors[3]
                                        ),
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
                                // BlocBuilder<MovieBloc, MovieStates>(
                                //     builder: (BuildContext context, MovieStates state) {
                                //   if (state is TrendingErrorState) {
                                //     return SizedBox(
                                //       width: screenWidth(context, dividedBy: 1),
                                //       height: screenHeight(context, dividedBy: 1),
                                //       child: Center(
                                //         child: Text(state.error.toString(),
                                //             style: Theme.of(context).textTheme.bodyLarge),
                                //       ),
                                //     );
                                //   }
                                //   if (state is TrendingLoadedState) {
                                //     List<Result> trendingMovieList = state.moviesData.results!;
                                //     return SizedBox(
                                //       width: MediaQuery.of(context).size.width,
                                //       child: Column(
                                //         children: [
                                //           if (trendingMovieList.isNotEmpty)
                                //             MovieTrendingList(
                                //               movieList: trendingMovieList,
                                //             ),
                                //           // CategoriesList(),
                                //         ],
                                //       ),
                                //     );
                                //   }
                                //   return Container(
                                //     width: screenWidth(context, dividedBy: 1),
                                //     height: screenHeight(context, dividedBy: 7),
                                //     color: Colors.white,
                                //     child: const Center(
                                //       child: SizedBox(
                                //         width: 18,
                                //         height: 18,
                                //         child: CircularProgressIndicator(
                                //           strokeWidth: 2,
                                //           valueColor: AlwaysStoppedAnimation<Color>(
                                //             Colors.white,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   );
                                // }),

                                /// futurebuilder
                                SizedBox(
                                  width: screenWidth(context, dividedBy: 1),
                                  // height: screenHeight(context, dividedBy: 1),
                                  // color: Colors.pink,
                                  child: FutureBuilder<GetGenresModel>(
                                    future: futureGenres,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 1),
                                          height: screenHeight(context,
                                              dividedBy: 20),
                                          child: snapshot.data!.genres != null
                                              ? ListView.builder(
                                                  itemCount: snapshot
                                                      .data!.genres!.length,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  // physics: const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (ctx, index) {
                                                    return Row(
                                                      children: [
                                                        BuildButton(
                                                          label: snapshot
                                                                  .data!
                                                                  .genres![
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          onTap: () {},
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth(
                                                              context,
                                                              dividedBy: 60),
                                                        ),
                                                        // Text(snapshot.data!.genres![index].name ??
                                                        //     "")
                                                      ],
                                                    );
                                                  },
                                                )
                                              : const Text("No Data"),
                                        );
                                      } else if (snapshot.hasError) {
                                        print(snapshot.error);
                                        return Text("${snapshot.error}");
                                      }
                                      // To show a spinner while loading
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: const Center(
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.pink,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // BlocBuilder<MovieBloc, MovieStates>(
                                //     builder: (BuildContext context, MovieStates state) {
                                //   if (state is GenresErrorState) {
                                //     return SizedBox(
                                //       width: screenWidth(context, dividedBy: 1),
                                //       height: screenHeight(context, dividedBy: 1),
                                //       child: Center(
                                //         child: Text(state.error.toString(),
                                //             style: Theme.of(context).textTheme.bodyLarge),
                                //       ),
                                //     );
                                //   }
                                //   if (state is GenresLoadedState) {
                                //     List<Genre> genreList = state.genresData.genres!;
                                //     return SizedBox(
                                //       width: MediaQuery.of(context).size.width,
                                //       child: Column(
                                //         children: [
                                //           if (genreList.isNotEmpty) Text("dfjdhsfsfdshfjd"),
                                //           // MovieTrendingList(
                                //           //   movieList: trendingMovieList,
                                //           // ),
                                //           // CategoriesList(),
                                //         ],
                                //       ),
                                //     );
                                //   }
                                //   return SizedBox(
                                //     width: screenWidth(context, dividedBy: 1),
                                //     height: screenHeight(context, dividedBy: 7),
                                //     child: const Center(
                                //       child: SizedBox(
                                //         width: 18,
                                //         height: 18,
                                //         child: CircularProgressIndicator(
                                //           strokeWidth: 2,
                                //           valueColor: AlwaysStoppedAnimation<Color>(
                                //             Colors.white,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   );
                                // }),
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
