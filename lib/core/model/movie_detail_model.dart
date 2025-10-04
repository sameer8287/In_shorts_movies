// To parse this JSON data, do
//
//     final movieDetailModel = movieDetailModelFromJson(jsonString);

import 'dart:convert';

MovieDetailModel movieDetailModelFromJson(String str) => MovieDetailModel.fromJson(json.decode(str));

String movieDetailModelToJson(MovieDetailModel data) => json.encode(data.toJson());

class MovieDetailModel {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieDetailModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  MovieDetailModel copyWith({
    bool? adult,
    String? backdropPath,
    BelongsToCollection? belongsToCollection,
    int? budget,
    List<Genre>? genres,
    String? homepage,
    int? id,
    String? imdbId,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    List<ProductionCompany>? productionCompanies,
    List<ProductionCountry>? productionCountries,
    DateTime? releaseDate,
    int? revenue,
    int? runtime,
    List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) => MovieDetailModel(
    adult: adult ?? this.adult,
    backdropPath: backdropPath ?? this.backdropPath,
    belongsToCollection: belongsToCollection ?? this.belongsToCollection,
    budget: budget ?? this.budget,
    genres: genres ?? this.genres,
    homepage: homepage ?? this.homepage,
    id: id ?? this.id,
    imdbId: imdbId ?? this.imdbId,
    originCountry: originCountry ?? this.originCountry,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    originalTitle: originalTitle ?? this.originalTitle,
    overview: overview ?? this.overview,
    popularity: popularity ?? this.popularity,
    posterPath: posterPath ?? this.posterPath,
    productionCompanies: productionCompanies ?? this.productionCompanies,
    productionCountries: productionCountries ?? this.productionCountries,
    releaseDate: releaseDate ?? this.releaseDate,
    revenue: revenue ?? this.revenue,
    runtime: runtime ?? this.runtime,
    spokenLanguages: spokenLanguages ?? this.spokenLanguages,
    status: status ?? this.status,
    tagline: tagline ?? this.tagline,
    title: title ?? this.title,
    video: video ?? this.video,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
  );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json, {bool fromDb = false}) => MovieDetailModel(
    adult: fromDb ? (json["adult"] == 1) : (json["adult"] ?? false),
    backdropPath: json["backdrop_path"] ?? "",
    belongsToCollection: json["belongs_to_collection"] == null
        ? null
        : BelongsToCollection.fromJson(fromDb ? jsonDecode(json["belongs_to_collection"]) : json["belongs_to_collection"]),
    budget: json["budget"] ?? 0,
    genres: json["genres"] == null ? [] : List<Genre>.from((fromDb ? jsonDecode(json["genres"]) : json["genres"]).map((x) => Genre.fromJson(x))),
    homepage: json["homepage"] ?? "",
    id: json["id"] ?? 0,
    imdbId: json["imdb_id"] ?? "",
    originCountry: json["origin_country"] == null
        ? []
        : List<String>.from((fromDb ? jsonDecode(json["origin_country"]) : json["origin_country"]).map((x) => x)),
    originalLanguage: json["original_language"] ?? "",
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: (json["popularity"] != null) ? json["popularity"].toDouble() : 0.0,
    posterPath: json["poster_path"] ?? "",
    productionCompanies: json["production_companies"] == null
        ? []
        : List<ProductionCompany>.from(
            (fromDb ? jsonDecode(json["production_companies"]) : json["production_companies"]).map((x) => ProductionCompany.fromJson(x)),
          ),
    productionCountries: json["production_countries"] == null
        ? []
        : List<ProductionCountry>.from(
            (fromDb ? jsonDecode(json["production_countries"]) : json["production_countries"]).map((x) => ProductionCountry.fromJson(x)),
          ),
    releaseDate: json["release_date"] == null ? null : DateTime.tryParse(json["release_date"]),
    revenue: json["revenue"] ?? 0,
    runtime: json["runtime"] ?? 0,
    spokenLanguages: json["spoken_languages"] == null
        ? []
        : List<SpokenLanguage>.from(
            (fromDb ? jsonDecode(json["spoken_languages"]) : json["spoken_languages"]).map((x) => SpokenLanguage.fromJson(x)),
          ),
    status: json["status"] ?? "",
    tagline: json["tagline"] ?? "",
    title: json["title"] ?? "",
    video: fromDb ? (json["video"] == 1) : (json["video"] ?? false),
    voteAverage: (json["vote_average"] != null) ? json["vote_average"].toDouble() : 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson({bool toDb = false}) => {
    "adult": toDb ? (adult == true ? 1 : 0) : adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": toDb
        ? belongsToCollection == null
              ? null
              : jsonEncode(belongsToCollection?.toJson())
        : belongsToCollection?.toJson(),
    "budget": budget,
    "genres": toDb
        ? jsonEncode(genres?.map((x) => x.toJson()).toList() ?? [])
        : genres == null
        ? []
        : List<dynamic>.from(genres!.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "origin_country": toDb
        ? jsonEncode(originCountry ?? [])
        : originCountry == null
        ? []
        : List<dynamic>.from(originCountry!),
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": toDb
        ? jsonEncode(productionCompanies?.map((x) => x.toJson()).toList() ?? [])
        : productionCompanies == null
        ? []
        : List<dynamic>.from(productionCompanies!.map((x) => x.toJson())),
    "production_countries": toDb
        ? jsonEncode(productionCountries?.map((x) => x.toJson()).toList() ?? [])
        : productionCountries == null
        ? []
        : List<dynamic>.from(productionCountries!.map((x) => x.toJson())),
    "release_date":
        "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime,
    "spoken_languages": toDb
        ? jsonEncode(spokenLanguages?.map((x) => x.toJson()).toList() ?? [])
        : spokenLanguages == null
        ? []
        : List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": toDb ? (video == true ? 1 : 0) : video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class BelongsToCollection {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection copyWith({int? id, String? name, String? posterPath, String? backdropPath}) => BelongsToCollection(
    id: id ?? this.id,
    name: name ?? this.name,
    posterPath: posterPath ?? this.posterPath,
    backdropPath: backdropPath ?? this.backdropPath,
  );

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      BelongsToCollection(id: json["id"], name: json["name"], posterPath: json["poster_path"], backdropPath: json["backdrop_path"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "poster_path": posterPath, "backdrop_path": backdropPath};
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  Genre copyWith({int? id, String? name}) => Genre(id: id ?? this.id, name: name ?? this.name);

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProductionCompany {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompany copyWith({int? id, String? logoPath, String? name, String? originCountry}) => ProductionCompany(
    id: id ?? this.id,
    logoPath: logoPath ?? this.logoPath,
    name: name ?? this.name,
    originCountry: originCountry ?? this.originCountry,
  );

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(id: json["id"], logoPath: json["logo_path"], name: json["name"], originCountry: json["origin_country"]);

  Map<String, dynamic> toJson() => {"id": id, "logo_path": logoPath, "name": name, "origin_country": originCountry};
}

class ProductionCountry {
  final String? iso31661;
  final String? name;

  ProductionCountry({this.iso31661, this.name});

  ProductionCountry copyWith({String? iso31661, String? name}) => ProductionCountry(iso31661: iso31661 ?? this.iso31661, name: name ?? this.name);

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(iso31661: json["iso_3166_1"], name: json["name"]);

  Map<String, dynamic> toJson() => {"iso_3166_1": iso31661, "name": name};
}

class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  SpokenLanguage copyWith({String? englishName, String? iso6391, String? name}) =>
      SpokenLanguage(englishName: englishName ?? this.englishName, iso6391: iso6391 ?? this.iso6391, name: name ?? this.name);

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      SpokenLanguage(englishName: json["english_name"], iso6391: json["iso_639_1"], name: json["name"]);

  Map<String, dynamic> toJson() => {"english_name": englishName, "iso_639_1": iso6391, "name": name};
}
