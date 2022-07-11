import 'dart:convert';
import 'dart:io';

import 'package:demo_movie/src/db/data_base.dart';
import 'package:demo_movie/src/models/genres_model.dart';
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

  Future<List<GenresModel>> fetchGenres() {
    print("Genres data2");
    return provider.getGenres();
  }
}

class MovieServices {
  late List<Movie> moviesList;
  late List<GenresModel> genreData;
  Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(Uri.parse(Url.movies));
      MoviesModel movies = moviesModelFromJson(response.body);
      print("Data movies");
      print(movies.results!.length);
      print(movies.results);
      print(movies.results![0].genreIds![0]);
      await MovieDatabase.instance.delete(tableMovie);
      for (int i = 0; i < movies.results!.length; i++) {
        final movie = Movie(
          title: movies.results![i].title ?? "null",
          posterPath: movies.results![i].posterPath,
          voteAverage: movies.results![i].voteAverage,
          voteCount: movies.results![i].voteCount,
          overview: movies.results![i].overview,
          releaseDate: movies.results![i].releaseDate,
          genreId1: movies.results![i].genreIds?[0] ?? 0,
          genreId2: movies.results![i].genreIds!.length == 1
              ? 0
              : movies.results![i].genreIds?[1],
          // genreId3: movies.results![i].genreIds!.length < 2
          //     ? 0
          //     : movies.results![i].genreIds?[2] ?? 0
        );
        MovieDatabase.instance.createMovie(movie, tableMovie);
      }
    } on SocketException {
      print("NO Internet");
    } catch (e) {
      print("MOVIE Error ");
      print(e);
    }
    moviesList = await MovieDatabase.instance.readAllMovies(tableMovie);
    print("Movie List Length  ${moviesList.length}");
    return moviesList;
  }

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse(Url.trending));
      TrendingMoviesModel trendingMovies =
          trendingMoviesModelFromJson(response.body);
      print("Trending movies");
      print(trendingMovies.results!.length);
      print(trendingMovies.results);
      await MovieDatabase.instance.delete(tableTrendingMovie);
      for (int i = 0; i < trendingMovies.results!.length; i++) {
        print("-------------------------------");
        print(trendingMovies.results![i].title ?? "NONE");
        print("================================");
        final movie = Movie(
          title: trendingMovies.results![i].title  ??
              trendingMovies.results![i].name ?? "null",
          posterPath: trendingMovies.results![i].posterPath,
          voteAverage: trendingMovies.results![i].voteAverage,
          voteCount: trendingMovies.results![i].voteCount,
          overview: trendingMovies.results![i].overview,
          releaseDate: trendingMovies.results![i].releaseDate ?? DateTime.now(),
          genreId1: trendingMovies.results![i].genreIds?[0] ?? 0,
          genreId2: trendingMovies.results![i].genreIds!.length == 1
              ? 0
              : trendingMovies.results![i].genreIds?[1],
          // title: trendingMovies.results![i].title ??
          //     trendingMovies.results![i].name ??
          //     "null",
          // posterPath: trendingMovies.results![i].posterPath ?? "",
          // voteAverage: trendingMovies.results![i].voteAverage ?? 0.0,
          // voteCount: trendingMovies.results![i].voteCount ?? 0,
          // overview: trendingMovies.results![i].overview ?? " ",
          // releaseDate: trendingMovies.results![i].releaseDate ?? DateTime.now(),
          // genreId1: trendingMovies.results![i].genreIds?[0] ?? 0,
          // genreId2: trendingMovies.results![i].genreIds!.length == 1
          //     ? 0
          //     : trendingMovies.results![i].genreIds?[1],
        );
        MovieDatabase.instance.createMovie(movie, tableTrendingMovie);
      }
    } on SocketException {
      print("Trending Movies - NO Internet");
    } catch (e) {
      print("Trending Movies - Error ");
      print(e);
    }
    moviesList = await MovieDatabase.instance.readAllMovies(tableTrendingMovie);
    print("Trending Movies from DB");
    print("Trending Movie List Length  ${moviesList.length}");
    for (int i = 0; i < moviesList.length; i++) {
      print(moviesList[i].title ?? "None ");
    }
    return moviesList;
  }

  Future<List<GenresModel>> getGenres() async {
    try {
      final response = await http.get(Uri.parse(Url.genres));
      // "https://api.themoviedb.org/3/genre/movie/list?api_key=6baea5ef838664a28d1e5b5e8ca1635b"));
      GetGenresModel genresData = getGenresModelFromJson(response.body);
      await MovieDatabase.instance.delete(tableGenres);
      for (int i = 0; i < genresData.genres!.length; i++) {
        final genre = GenresModel(
          gid: genresData.genres![i].id ?? 0,
          name: genresData.genres![i].name ?? "Name",
        );
        MovieDatabase.instance.createGenre(genre);
      }
    } on SocketException {
      print("Movies Genres  - NO Internet");
    } catch (e) {
      print("Movies Genres  - Error ");
      print(e);
    }

    genreData = await MovieDatabase.instance.readAllGenres();
    // print("Genres from DB");
    // print(genreData);
    // for (int i = 0; i < genreData.length; i++) {
    //   print(genreData[i].name ?? "None ");
    // }

    // movieId = await MovieDatabase.instance.readMovieByGenreId(14, tableMovie);

    return genreData;
  }
}
