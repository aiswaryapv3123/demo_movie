// To parse this JSON data, do
//
//     final trendingMoviesModel = trendingMoviesModelFromJson(jsonString);

import 'dart:convert';

TrendingMoviesModel trendingMoviesModelFromJson(String str) => TrendingMoviesModel.fromJson(json.decode(str));

String trendingMoviesModelToJson(TrendingMoviesModel data) => json.encode(data.toJson());

class TrendingMoviesModel {
  TrendingMoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int? page;
  final List<Movies>? results;
  final int? totalPages;
  final int? totalResults;

  factory TrendingMoviesModel.fromJson(Map<String, dynamic> json) => TrendingMoviesModel(
    page: json["page"] == null ? null : json["page"],
    results: json["results"] == null ? null : List<Movies>.from(json["results"].map((x) => Movies.fromJson(x))),
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    totalResults: json["total_results"] == null ? null : json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages == null ? null : totalPages,
    "total_results": totalResults == null ? null : totalResults,
  };
}

class Movies {
  Movies({
    this.originalLanguage,
    this.originalTitle,
    this.id,
    this.video,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.voteCount,
    this.title,
    this.adult,
    this.backdropPath,
    this.posterPath,
    this.genreIds,
    this.popularity,
    this.mediaType,
    this.firstAirDate,
    this.originalName,
    this.originCountry,
    this.name,
  });

  final String? originalLanguage;
  final String? originalTitle;
  final int? id;
  final bool? video;
  final double? voteAverage;
  final String? overview;
  final DateTime? releaseDate;
  final int? voteCount;
  final String? title;
  final bool? adult;
  final String? backdropPath;
  final String? posterPath;
  final List<int>? genreIds;
  final double? popularity;
  final String? mediaType;
  final DateTime? firstAirDate;
  final String? originalName;
  final List<String>? originCountry;
  final String? name;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
    originalLanguage: json["original_language"] == null ? null : json["original_language"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    id: json["id"] == null ? null : json["id"],
    video: json["video"] == null ? null : json["video"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    overview: json["overview"] == null ? null : json["overview"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    title: json["title"] == null ? null : json["title"],
    adult: json["adult"] == null ? null : json["adult"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    mediaType: json["media_type"] == null ? null : "media_type",
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    originalName: json["original_name"] == null ? null : json["original_name"],
    originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "original_language": originalLanguage == null ? null : originalLanguage,
    "original_title": originalTitle == null ? null : originalTitle,
    "id": id == null ? null : id,
    "video": video == null ? null : video,
    "vote_average": voteAverage == null ? null : voteAverage,
    "overview": overview == null ? null : overview,
    "release_date": releaseDate == null ? null : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "vote_count": voteCount == null ? null : voteCount,
    "title": title == null ? null : title,
    "adult": adult == null ? null : adult,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "poster_path": posterPath == null ? null : posterPath,
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds!.map((x) => x)),
    "popularity": popularity == null ? null : popularity,
    "media_type": mediaType == null ? null : mediaType,
    "first_air_date": firstAirDate == null ? null : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "original_name": originalName == null ? null : originalName,
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry!.map((x) => x)),
    "name": name == null ? null : name,
  };
}

// enum MediaType { MOVIE, TV }
//
// final mediaTypeValues = EnumValues({
//   "movie": MediaType.MOVIE,
//   "tv": MediaType.TV
// });
//
// enum OriginalLanguage { EN }
//
// final originalLanguageValues = EnumValues({
//   "en": OriginalLanguage.EN
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
