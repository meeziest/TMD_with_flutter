import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies_flutter/bloc/sort_options_bloc/sort_options_cubit.dart';
import 'package:popular_movies_flutter/model/movie.dart';
import 'package:popular_movies_flutter/model/movie_list_response.dart';
import 'package:popular_movies_flutter/repositories/movie_repository.dart';
import 'package:popular_movies_flutter/utils/enums.dart';
part 'popular_movies_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  final SortOptionsCubit sortOptionsCubit;
  late StreamSubscription sortCubitSubscription;
  final MovieRepository repository;
  final Locale locale;

  PopularMovieCubit({required this.sortOptionsCubit, required this.repository, required this.locale})
      : super(PopularMovieState.loading()){
      sortCubitSubscription = monitorSortCubit(locale);
  }

  StreamSubscription<SortOptionsState> monitorSortCubit(Locale locale){
    return sortOptionsCubit.stream.listen((sortState) {
      if(sortState.selectedOption == SortOptions.name){
        sortMovieListByName(locale);
      }
      else if(sortState.selectedOption == SortOptions.date){
        sortMovieListByDate(locale);
      }
      else if(sortState.selectedOption == SortOptions.rating){
        sortMovieTopRated(locale);
      }
    });
  }


  Future<void> fetchList(Locale locale) async {
    try {
      final movieResponse = await repository.getPopularMovies(locale);
      emit(PopularMovieState.success(movieResponse.movies));
    } on MovieListResponse catch (e){
      emit(PopularMovieState.failure(e.error));
    }
  }

  Future<void> sortMovieTopRated(Locale locale) async {
    try {
      final movieResponse = await repository.getPopularMovies(locale);
      emit(PopularMovieState.ratingSortSuccess(movieResponse.movies));
    } on MovieListResponse catch (e) {
      emit(PopularMovieState.failure(e.error));
    }
  }

  Future<void> sortMovieListByName(Locale locale) async {
    try {
      final movieResponse = await repository.getPopularMovies(locale);
      emit(PopularMovieState.nameSortSuccess(movieResponse.movies));
    } on MovieListResponse catch (e) {
      emit(PopularMovieState.failure(e.error));
    }
  }

  Future<void> sortMovieListByDate(Locale locale) async {
    try {
      final movieResponse = await repository.getPopularMovies(locale);
      emit(PopularMovieState.dateSortSuccess(movieResponse.movies));
    } on MovieListResponse catch (e) {
      emit(PopularMovieState.failure(e.error));
    }
  }

  @override
  Future<void> close() {
    sortCubitSubscription.cancel();
    return super.close();
  }
}