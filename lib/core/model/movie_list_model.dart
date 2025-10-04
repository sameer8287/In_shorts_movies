// To parse this JSON data, do
//
//     final movieListModel = movieListModelFromJson(jsonString);

import 'dart:convert';

MovieListModel movieListModelFromJson(String str) => MovieListModel.fromJson(json.decode(str));

String movieListModelToJson(MovieListModel data) => json.encode(data.toJson());

class MovieListModel {
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  MovieListModel({this.page, this.results, this.totalPages, this.totalResults});

  MovieListModel copyWith({int? page, List<Result>? results, int? totalPages, int? totalResults}) => MovieListModel(
    page: page ?? this.page,
    results: results ?? this.results,
    totalPages: totalPages ?? this.totalPages,
    totalResults: totalResults ?? this.totalResults,
  );

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
    page: json["page"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final MediaType? mediaType;
  final OriginalLanguage? originalLanguage;
  final List<int>? genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Result copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? title,
    String? originalTitle,
    String? overview,
    String? posterPath,
    MediaType? mediaType,
    OriginalLanguage? originalLanguage,
    List<int>? genreIds,
    double? popularity,
    DateTime? releaseDate,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) => Result(
    adult: adult ?? this.adult,
    backdropPath: backdropPath ?? this.backdropPath,
    id: id ?? this.id,
    title: title ?? this.title,
    originalTitle: originalTitle ?? this.originalTitle,
    overview: overview ?? this.overview,
    posterPath: posterPath ?? this.posterPath,
    mediaType: mediaType ?? this.mediaType,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    genreIds: genreIds ?? this.genreIds,
    popularity: popularity ?? this.popularity,
    releaseDate: releaseDate ?? this.releaseDate,
    video: video ?? this.video,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
  );

  factory Result.fromJson(Map<String, dynamic> json, {bool fromDb = false}) => Result(
    adult: fromDb ? (json["adult"] == 1) : (json["adult"] ?? false),
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: mediaTypeValues.map[json["media_type"]],
    originalLanguage: originalLanguageValues.map[json["original_language"]],
    genreIds: json["genre_ids"] == null
        ? []
        : fromDb
        ? List<int>.from(jsonDecode(json["genre_ids"]))
        : List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    releaseDate: json["release_date"] == null ? null : DateTime.tryParse(json["release_date"]),
    video: fromDb ? (json["video"] == 1) : (json["video"] ?? false),
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson({bool toDb = false}) => {
    "adult": toDb ? (adult == true ? 1 : 0) : adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "genre_ids": toDb
        ? jsonEncode(genreIds ?? [])
        : genreIds == null
        ? []
        : List<dynamic>.from(genreIds!.map((x) => x)),
    "popularity": popularity,
    "release_date":
        "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "video": toDb ? (video == true ? 1 : 0) : video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage { EN, JA }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN, "ja": OriginalLanguage.JA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
