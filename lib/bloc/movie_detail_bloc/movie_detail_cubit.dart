import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:popular_movies_flutter/model/movie_detail.dart';
import 'package:popular_movies_flutter/model/movie_detail_response.dart';
import 'package:popular_movies_flutter/repositories/movie_repository.dart';
import 'package:popular_movies_flutter/utils/enums.dart';
part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({required this.repository})
      : super(const MovieDetailState.loading());

  final MovieRepository repository;

  Future<void> fetchMovie(int id, Locale locale) async {
    try {
      final movieResponse = await repository.getMovieDetail(id, locale);
      emit(MovieDetailState.success(movieResponse.movieDetail));
    } on MovieDetailResponse catch(e){
      emit(MovieDetailState.failure(e.error));
    }
  }
}
