part of 'popular_movies_cubit.dart';

class PopularMovieState extends Equatable {
  late final ListStatus status;
  late final List<Movie> movies;
  late final String errorMessage;

  PopularMovieState._({
    this.status = ListStatus.loading,
    this.movies = const <Movie>[],
    this.errorMessage = "",
  });

  PopularMovieState.loading() : this._();

  PopularMovieState.success(List<Movie> movies)
      : this._(status: ListStatus.success, movies: movies);

  PopularMovieState.failure(String errorMessage) : this._(status: ListStatus.failure, errorMessage: errorMessage);

  PopularMovieState.nameSortSuccess(List<Movie> movies){
    status = ListStatus.success;
    this.movies = _sortByName(movies);
  }

  PopularMovieState.dateSortSuccess(List<Movie> movies){
    status = ListStatus.success;
    this.movies = _sortByDate(movies);
  }

  PopularMovieState.ratingSortSuccess(List<Movie> movies){
    status = ListStatus.success;
    this.movies = _sortByRating(movies);
  }

  List<Movie> _sortByName(List<Movie> movies){
    movies.sort((a, b) => a.title.compareTo(b.title));
    return movies;
  }

  List<Movie> _sortByDate(List<Movie> movies){
    movies.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    return movies;
  }

  List<Movie> _sortByRating(List<Movie> movies){
    movies.sort((a, b) => b.rating.compareTo(a.rating));
    return movies;
  }

  @override
  List<Object> get props => [status, movies];
}