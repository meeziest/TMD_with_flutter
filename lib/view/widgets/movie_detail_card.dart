import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:popular_movies_flutter/localization/tKeys.dart';
import 'package:popular_movies_flutter/utils/colors.dart';
import 'package:popular_movies_flutter/utils/constants.dart';


class MovieDetailCard extends StatelessWidget {
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final int income;
  final double voteAverage;
  final bool adult;

  const MovieDetailCard({Key? key,
    required this.posterPath,
    required this.runtime,
    required this.releaseDate,
    required this.income,
    required this.voteAverage,
    required this.adult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int hour = runtime ~/ 60;
    final int minutes = runtime % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 6, right: 24),
            child: Container(
              height: 192,
              width: 149,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: NetworkImage(posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Text(adult == true ? "18+" : "+6",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    flex:3,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: CustomColors.ratingCircleBackgroundColor,
                          shape: BoxShape.circle
                      ),
                      child: CircularPercentIndicator(
                        fillColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        radius: 17.0,
                        lineWidth: 3.0,
                        percent: voteAverage / 10,
                        center: Text('$voteAverage'),
                        progressColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  AutoSizeText(TKeys.aboutMovie.translate(context), style: kMainTextStyle),
                  Text(releaseDate, style: kMainTextStyle),
                  const SizedBox(height: 10),
                  AutoSizeText(
                      '${hour.toString().padRight(2, " hours")} ${minutes
                          .toString()} minutes',
                      style: kMainTextStyle
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(TKeys.budget.translate(context), style: kMainTextStyle),
                  AutoSizeText('$income \$', style:  kMainTextStyle),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

