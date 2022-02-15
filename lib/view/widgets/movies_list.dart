import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:popular_movies_flutter/bloc/popular_movies_bloc/popular_movies_cubit.dart';
import 'package:popular_movies_flutter/localization/tKeys.dart';
import 'package:popular_movies_flutter/repositories/movie_repository.dart';
import 'package:popular_movies_flutter/utils/constants.dart';
import 'package:popular_movies_flutter/utils/enums.dart';

import 'movie_card.dart';

class MoviesList extends StatelessWidget {

  const MoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => MovieRepository(),
      child: Builder(
        builder: (context) {
          final popularMovies = context.watch<PopularMovieCubit>().state.movies;
          final status = context.read<PopularMovieCubit>().state.status;
          int extraIndex = -2;
          switch (status) {
            case ListStatus.failure:
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.read<PopularMovieCubit>().state.errorMessage, style: kMainTextStyle),
                  Text(TKeys.errorMessage.translate(context), style: kMainTextStyle),
                ],
              ));
            case ListStatus.success:
              if (popularMovies.isEmpty) {
                return const Center(child: Text('Movie list is empty!', style: kMainTextStyle));
              }
              else {
                return ListView.builder(
                  itemCount: popularMovies.length % 2 == 0
                      ? popularMovies.length ~/ 2
                      : popularMovies.length ~/ 2 + 1,
                  itemBuilder: (BuildContext context, int index) {
                    extraIndex += 2;
                    if (extraIndex + 1 < popularMovies.length) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 11),
                        child: Row(
                          children: [
                            Expanded(
                              child: MovieCard(
                                  movieId: popularMovies[extraIndex].id,
                                  posterPath: kImagePath + popularMovies[extraIndex].poster,
                                  movieName: popularMovies[extraIndex].title,
                                  releaseDate: popularMovies[extraIndex].releaseDate,
                                  voteAverage: popularMovies[extraIndex].rating.toDouble(),
                              ),
                            ),
                            Expanded(
                              child: MovieCard(
                                  movieId: popularMovies[extraIndex + 1].id,
                                  posterPath: kImagePath + popularMovies[extraIndex + 1].poster,
                                  movieName: popularMovies[extraIndex + 1].title,
                                  releaseDate: popularMovies[extraIndex + 1].releaseDate,
                                  voteAverage: popularMovies[extraIndex + 1].rating.toDouble()
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                );
              }
            default:
              return const Center(
                child: SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 100.0,
                ),
              );
          }
        }
      ),
    );
  }
}
