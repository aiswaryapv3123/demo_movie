import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class MovieData extends MovieEvent {}

class TrendingMovieData extends MovieEvent {}

class GenresData extends MovieEvent {}

