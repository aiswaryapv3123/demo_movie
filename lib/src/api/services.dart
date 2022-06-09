import 'dart:convert';
import 'dart:io';

import 'package:demo_movie/src/db/data_base.dart';
import 'package:demo_movie/src/models/get_genres_model.dart';
import 'package:demo_movie/src/models/get_movies_model.dart';
import 'package:demo_movie/src/models/movie_model.dart';
import 'package:demo_movie/src/models/trending_movies_model.dart';
import 'package:demo_movie/src/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MovieRepo {
  final provider = MovieServices();

  Future<List<Movie>> fetchMovies() {
    return provider.getMovies();
  }

  Future<List<Movie>> fetchTrendingMovies() {
    return provider.getTrendingMovies();
  }

  Future<GetGenresModel> fetchGenres() {
    print("Genres data2");
    return provider.getGenres();
  }
}

class MovieServices {
  late List<Movie> moviesList;
  Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(Uri.parse(Url.movies));
      MoviesModel movies = moviesModelFromJson(response.body);
      print("Data movies");
      print(movies.results);
      for (int i = 0; i < movies.results!.length; i++) {
        final movie = Movie(
          title: movies.results![i].title,
          posterPath: movies.results![i].posterPath,
          voteAverage: movies.results![i].voteAverage,
          voteCount: movies.results![i].voteCount,
          overview: movies.results![i].overview,
          releaseDate: movies.results![i].releaseDate,
        );
        MovieDatabase.instance.create(movie, tableMovie);
        // refreshNotes();
        // print("Movie DATABASE");
        // print("---------------");
        // print(MovieDatabase.instance);
      }
    } on SocketException {
      print("NO Internet");
    } catch (e) {
      print("Error ");
      print(e);
    }
    moviesList = await MovieDatabase.instance.readAllMovies(tableMovie);
    return moviesList;
  }

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse(Url.trending));
      TrendingMoviesModel trendingMovies =
          trendingMoviesModelFromJson(response.body);
      for (int i = 0; i < trendingMovies.results!.length; i++) {
        final movie = Movie(
          title: trendingMovies.results![i].title ??
              trendingMovies.results![i].name ??
              "null",
          posterPath: trendingMovies.results![i].posterPath ?? "",
          voteAverage: trendingMovies.results![i].voteAverage ?? 0.0,
          voteCount: trendingMovies.results![i].voteCount ?? 0,
          overview: trendingMovies.results![i].overview ?? " ",
          releaseDate: trendingMovies.results![i].releaseDate ?? DateTime.now(),
        );
        MovieDatabase.instance.create(movie, tableTrendingMovie);
      }
    } on SocketException {
      print("Trending Movies - NO Internet");
    } catch (e) {
      print("Trending Movies - Error ");
      print(e);
    }
    moviesList = await MovieDatabase.instance.readAllMovies(tableTrendingMovie);
    print("Trending Movies from DB");
    for (int i = 0; i < moviesList.length; i++) {
      print(moviesList[i].title ?? "None ");
    }
    return moviesList;
  }

  Future<GetGenresModel> getGenres() async {
    Uri uri = Uri.parse(Url.genres);
    var response = await http.get(uri);
    print("response");
    print(response.body);
    GetGenresModel genresData = getGenresModelFromJson(response.body);
    print("Data");
    print(genresData);
    return genresData;
  }
}
