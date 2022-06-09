import 'dart:io';

import 'package:demo_movie/src/api/services.dart';
import 'package:demo_movie/src/bloc/events.dart';
import 'package:demo_movie/src/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieStates> {
  MovieBloc() : super(MoviesInitialState()) {
    final MovieRepo movieRepository = MovieRepo();

    on<MovieData>((event, emit) async {
      try {
        emit(MoviesLoadingState());
        final movieData = await movieRepository.fetchMovies();
        print("movieData from bloc");
        print(movieData);
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
        print("ERROR  " + e.toString());
        emit(TrendingErrorState(
          error: 'Unknown Error',
        ));
      }
    });

    on<TrendingMovieData>((event, emit) async {
      try {
        emit(TrendingLoadingState());
        final trendingMovieData = await movieRepository.fetchTrendingMovies();
        print("Data from bloc");
        print(trendingMovieData);
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
    //
    // ///
    // on<GenresData>((event, emit) async {
    //   print("Genres Data from bloc");
    //   try {
    //     emit(GenresLoadingState());
    //     final genresData = await movieRepository.fetchGenres();
    //     print("Genres Data from bloc");
    //     print(genresData);
    //     emit(GenresLoadedState(genresData: genresData));
    //   } on SocketException {
    //     emit(GenresErrorState(error: "No internet"));
    //   } on HttpException {
    //     emit(GenresErrorState(
    //       error: 'No Service Found',
    //     ));
    //   } on FormatException {
    //     emit(GenresErrorState(
    //       error: 'Invalid Response format',
    //     ));
    //   } catch (e) {
    //     emit(GenresErrorState(
    //       error: 'Unknown Error',
    //     ));
    //   }
    // });
  }
}
