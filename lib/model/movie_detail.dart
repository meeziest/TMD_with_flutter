import 'package:equatable/equatable.dart';
import 'genre.dart';

class MovieDetail extends Equatable {
  final int id;
  final num popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final num rating;
  final String releaseDate;
  final List<Genre> genres;
  final int budget;
  final int revenue;
  final String status;
  final int runtime;
  final bool adult;

  const MovieDetail(
      this.id,
      this.popularity,
      this.title,
      this.backPoster,
      this.poster,
      this.overview,
      this.rating,
      this.releaseDate,
      this.genres,
      this.budget,
      this.revenue,
      this.status,
      this.runtime,
      this.adult);

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        popularity = json["popularity"] ?? 0,
        title = json["title"] ?? "",
        backPoster = json["backdrop_path"] ?? "",
        poster = json["poster_path"] ?? "",
        overview = json["overview"] ?? "",
        rating = json["vote_average"] ?? 0.0,
        releaseDate = json["release_date"] ?? "",
        genres = (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
        budget = json["budget"] ?? 0,
        revenue = json["revenue"] ?? 0,
        status = json["status"] ?? "",
        adult = json["adult"] ?? false,
        runtime = json["runtime"] ?? 0;

  @override
  List<Object> get props =>
      [id, popularity, title, backPoster, poster, overview, rating, adult];

  static const empty = MovieDetail(0, 0, "", "", "", "", 0, "", [], 0, 0, "", 0, false);

  @override
  String toString() {
    return 'MovieDetail{id: $id, popularity: $popularity, title: $title, backPoster: $backPoster, poster: $poster, overview: $overview, rating: $rating, releaseDate: $releaseDate, genres: $genres, budget: $budget, revenue: $revenue, status: $status, runtime: $runtime, adult: $adult}';
  }
}
