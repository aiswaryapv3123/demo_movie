import 'dart:io';

import 'package:demo_movie/src/api/services.dart';
import 'package:demo_movie/src/bloc/events.dart';
import 'package:demo_movie/src/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieStates> {
  MovieBloc() : super(MoviesInitialState()) {
    final MovieRepo movieRepository = MovieRepo();

    /// now playing movie
    on<MovieData>((event, emit) async {
      debugPrint("Data from bloc");
      try {
        emit(MoviesLoadingState());
        final movieData = await movieRepository.fetchMovies();
        debugPrint("movieData from bloc");
        debugPrint(movieData.toString());
        // print(movieData.results![0].title ?? "no name");
        emit(MoviesLoadedState(movieList: movieData));
      } on SocketException {
        emit(MoviesErrorState(error: "No internet"));
      } on HttpException {
        emit(MoviesErrorState(
          error: 'No Service Found',
        ));
      } on FormatException {
        emit(MoviesErrorState(
          error: 'Invalid Response format',
        ));
      } catch (e) {
        debugPrint("ERROR  $e ");
        emit(TrendingErrorState(
          error: 'Unknown Error',
        ));
      }
    });


    /// trending movie bloc
    on<TrendingMovieData>((event, emit) async {
      try {
        emit(TrendingLoadingState());
        final trendingMovieData = await movieRepository.fetchTrendingMovies();
        debugPrint("Data from bloc");
        debugPrint(trendingMovieData.toString());
        emit(TrendingLoadedState(moviesData: trendingMovieData));
      } on SocketException {
        emit(TrendingErrorState(error: "No internet"));
      } on HttpException {
        emit(TrendingErrorState(
          error: 'No Service Found',
        ));
      } on FormatException {
        emit(TrendingErrorState(
          error: 'Invalid Response format',
        ));
      } catch (e) {
        emit(TrendingErrorState(
          error: 'Unknown Error',
        ));
      }
    });


    /// movie genres
    on<GenresData>((event, emit) async {

      try {
        emit(GenresLoadingState());
        final genresData = await movieRepository.fetchGenres();
        debugPrint("Data from bloc");
        debugPrint(genresData.toString());
        emit(GenresLoadedState(genresData: genresData));
      } on SocketException {
        emit(GenresErrorState(error: "No internet"));
      } on HttpException {
        emit(GenresErrorState(
          error: 'No Service Found',
        ));
      } on FormatException {
        emit(GenresErrorState(
          error: 'Invalid Response format',
        ));
      } catch (e) {
        print("Unkown Error is ");
        print("---------------------");
        print(e);
        emit(GenresErrorState(
          error: 'Unknown Error',
        ));
      }
    });
  }
}

// class TrendingMovieBloc extends Bloc<MovieEvent, MovieStates> {
//   TrendingMovieBloc() : super(TrendingInitialState()) {
//     final MovieRepo movieRepository = MovieRepo();
//
//     /// trending movie bloc
//     on<TrendingMovieData>((event, emit) async {
//       try {
//         emit(TrendingLoadingState());
//         final trendingMovieData = await movieRepository.fetchTrendingMovies();
//         debugPrint("Data from bloc");
//         debugPrint(trendingMovieData.toString());
//         emit(TrendingLoadedState(moviesData: trendingMovieData));
//       } on SocketException {
//         emit(TrendingErrorState(error: "No internet"));
//       } on HttpException {
//         emit(TrendingErrorState(
//           error: 'No Service Found',
//         ));
//       } on FormatException {
//         emit(TrendingErrorState(
//           error: 'Invalid Response format',
//         ));
//       } catch (e) {
//         emit(TrendingErrorState(
//           error: 'Unknown Error',
//         ));
//       }
//     });
//   }
// }
//
//
// class MovieGenreBloc extends Bloc<MovieEvent, MovieStates> {
//   MovieGenreBloc() : super(GenresInitialState()) {
//     final MovieRepo movieRepository = MovieRepo();
//
//     /// movie genres
//     on<GenresData>((event, emit) async {
//
//       try {
//         emit(GenresLoadingState());
//         final genresData = await movieRepository.fetchGenres();
//         debugPrint("Data from bloc");
//         debugPrint(genresData.toString());
//         emit(GenresLoadedState(genresData: genresData));
//       } on SocketException {
//         emit(GenresErrorState(error: "No internet"));
//       } on HttpException {
//         emit(GenresErrorState(
//           error: 'No Service Found',
//         ));
//       } on FormatException {
//         emit(GenresErrorState(
//           error: 'Invalid Response format',
//         ));
//       } catch (e) {
//         print("Unkown Error is ");
//         print("---------------------");
//         print(e);
//         emit(GenresErrorState(
//           error: 'Unknown Error',
//         ));
//       }
//     });
//   }
// }
