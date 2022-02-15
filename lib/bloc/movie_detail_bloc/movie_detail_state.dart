part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final ListStatus status;
  final MovieDetail movie;
  final String errorMessage;

  const MovieDetailState._({
    this.status = ListStatus.loading,
    this.movie = MovieDetail.empty,
    this.errorMessage = ""
  });

  const MovieDetailState.loading() : this._();

  const MovieDetailState.success(MovieDetail movie)
      : this._(status: ListStatus.success, movie: movie);

  const MovieDetailState.failure(String errorMessage) : this._(status: ListStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, movie];
}
