


import 'package:demo_movie/src/models/get_genres_model.dart';
import 'package:demo_movie/src/models/get_movies_model.dart';
import 'package:demo_movie/src/models/movie_model.dart';
import 'package:demo_movie/src/models/trending_movies_model.dart';
import 'package:equatable/equatable.dart';

abstract class MovieStates extends Equatable {
  const MovieStates();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class MoviesInitialState extends MovieStates {}

class MoviesLoadingState extends MovieStates {}

class MoviesLoadedState extends MovieStates {
   List<Movie> movieList;
   MoviesLoadedState({required this.movieList});
}

class MoviesErrorState extends MovieStates {
  final String? error;
   MoviesErrorState({this.error});
}

class TrendingInitialState extends MovieStates {}

class TrendingLoadingState extends MovieStates {}

class TrendingLoadedState extends MovieStates {
  List<Movie> moviesData;
  TrendingLoadedState({required this.moviesData});
}

class TrendingErrorState extends MovieStates {
  String? error;
  TrendingErrorState({this.error});
}


/// genres
class GenresInitialState extends MovieStates {}

class GenresLoadingState extends MovieStates {}

class GenresLoadedState extends MovieStates {
  GetGenresModel genresData;
  GenresLoadedState({required this.genresData});
}

class GenresErrorState extends MovieStates {
  String? error;
  GenresErrorState({this.error});
}
