import 'movie.dart';

class MovieListResponse {
  final List<Movie> movies;

  final bool hasError;
  final String error;

  MovieListResponse(this.movies, this.hasError, this.error);

  @override
  String toString() {
    return movies.toString();
  }

  MovieListResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((i) => Movie.fromJson(i))
            .toList(),
        hasError = false,
        error = "";

  MovieListResponse.withError(String errorValue)
      : movies = [],
        hasError = true,
        error = errorValue;
}
