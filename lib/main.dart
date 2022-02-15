import 'package:flutter/material.dart';
import 'app.dart';
import 'bloc/sort_options_bloc/sort_options_cubit.dart';
import 'repositories/movie_repository.dart';

void main() async {
  final movieRepository = MovieRepository();

  runApp(MyApp(
    movieRepository: movieRepository,
    sortOptionsCubit: SortOptionsCubit()
  ));
}
