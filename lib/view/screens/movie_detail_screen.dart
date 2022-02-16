import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:popular_movies_flutter/bloc/movie_detail_bloc/movie_detail_cubit.dart';
import 'package:popular_movies_flutter/localization/localiztion_service.dart';
import 'package:popular_movies_flutter/localization/tKeys.dart';
import 'package:popular_movies_flutter/repositories/movie_repository.dart';
import 'package:popular_movies_flutter/utils/colors.dart';
import 'package:popular_movies_flutter/utils/constants.dart';
import 'package:popular_movies_flutter/utils/enums.dart';
import 'package:popular_movies_flutter/utils/icons.dart';
import 'package:popular_movies_flutter/view/widgets/error_message.dart';
import 'package:popular_movies_flutter/view/widgets/movie_detail_card.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.mainColor,
      body: BlocProvider(
        create: (context) => MovieDetailCubit(
            repository: context.read<MovieRepository>())
                      ..fetchMovie(movieId, LocalizationService.currentLocale),
        child: Builder(
          builder: (context){
            final movieDetail = context.watch<MovieDetailCubit>().state.movie;
            final status = context.watch<MovieDetailCubit>().state.status;
            final genres = movieDetail.genres.toString().substring(1, movieDetail.genres.toString().length-1);
            switch (status){
              case ListStatus.failure:
                return const ErrorMessage();
              case ListStatus.success:
                return SafeArea(
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          Image(
                            image: NetworkImage(kImagePath + movieDetail.backPoster),
                            fit : BoxFit.cover,
                            height: 312,
                          ),
                          Container(
                            height: 312.0,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                gradient: kBackPosterGradient
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: CustomIcons.vectorLeft,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        movieDetail.title,
                                        style: kMovieTitleTextStyle,
                                        minFontSize: 30,
                                        maxFontSize: 40,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              MovieDetailCard(
                                posterPath: kImagePath + movieDetail.poster,
                                runtime: movieDetail.runtime,
                                releaseDate: movieDetail.releaseDate,
                                income: movieDetail.budget,
                                voteAverage: movieDetail.rating.toDouble(),
                                adult: movieDetail.adult,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 43),
                      Padding(
                        padding: const EdgeInsets.only(right: 16 ,left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TKeys.budget.translate(context),style: kMainTextStyle),
                            const SizedBox(height:8),
                            Text(genres, style: kGenresTextStyle),
                            const SizedBox(height:9),
                            Text(movieDetail.overview, style: kMainTextStyle),
                          ],
                        ),
                      )
                    ],
                  ),
                );
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
      ),
    );
  }
}
