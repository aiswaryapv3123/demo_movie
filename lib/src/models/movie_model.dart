const String tableMovie = 'movies';
const String tableTrendingMovie = 'trendingMovies';

class MovieFields {
  static final List<String> values = [
    /// Add all fields
    id, posterPath, title, voteAverage, voteCount, overview, releaseDate,
  ];

  static const String id = '_id';
  static const String posterPath = 'posterPath';
  static const String title = 'title';
  static const String voteAverage = 'voteAverage';
  static const String voteCount = 'voteCount';
  static const String overview = 'overview';
  static const String releaseDate = 'releaseDate';
}

class Movie {
  final int? id;
  final String? posterPath;
  final String? title;
  final DateTime? releaseDate;
  final double? voteAverage;
  final String? overview;
  // final bool? adult;
  // final String? backdropPath;
  // final String? originalLanguage;
  // final String? originalTitle;
  // final double? popularity;
  // final bool? video;
  final int? voteCount;

  const Movie(
      {this.id,
      this.posterPath,
      this.title,
      this.releaseDate,
      this.voteAverage,
      this.overview,
      // this.adult,
      // this.backdropPath,
      // this.originalLanguage,
      // this.originalTitle,
      // this.popularity,
      // this.video,
      this.voteCount});

  Movie copy({
    int? id,
    String? posterPath,
    String? title,
    DateTime? releaseDate,
    double? voteAverage,
    int? voteCount,
    String? overview,
  }) =>
      Movie(
        id: id ?? this.id,
        posterPath: posterPath ?? this.posterPath,
        title: title ?? this.title,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        overview: overview ?? this.overview,
        releaseDate: releaseDate ?? this.releaseDate,
      );

  static Movie fromJson(Map<String, Object?> json) => Movie(
        id: json[MovieFields.id] as int?,
        posterPath: json[MovieFields.posterPath] as String,
        voteAverage: json[MovieFields.voteAverage] as double,
        voteCount: json[MovieFields.voteCount] as int,
        title: json[MovieFields.title] as String,
        overview: json[MovieFields.overview] as String,
        releaseDate: DateTime.parse(json[MovieFields.releaseDate] as String),

      );

  Map<String, Object?> toJson() => {
        MovieFields.id: id,
        MovieFields.title: title,
        MovieFields.posterPath: posterPath,
        MovieFields.voteAverage: voteAverage,
        MovieFields.voteCount: voteCount,
        MovieFields.overview: overview,
        MovieFields.releaseDate: releaseDate?.toIso8601String(),
      };
}

