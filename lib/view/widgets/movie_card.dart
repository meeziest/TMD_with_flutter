import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:popular_movies_flutter/utils/colors.dart';
import 'package:popular_movies_flutter/utils/constants.dart';
import 'package:popular_movies_flutter/view/screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final int movieId;
  final String posterPath;
  final String movieName;
  final String releaseDate;
  final double voteAverage;

  const MovieCard({Key? key,
    required this.posterPath,
    required this.movieName,
    required this.releaseDate,
    required this.voteAverage,
    required this.movieId})
  :super(key: key);

  void openMovieDetail(int id, BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(
            movieId: movieId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: (){
          openMovieDetail(movieId, context);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Positioned(
              right: 5,
              top: 5,
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
                  percent: voteAverage/10,
                  center: Text('$voteAverage'),
                  progressColor: Colors.white,
                ),
              ),
            ),
            Ink.image(
              image: NetworkImage(posterPath),
              height: 214.0,
              child: InkWell(
                onTap: () {
                  openMovieDetail(movieId, context);
                },
              ),
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Container(
                height: 100.0,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    gradient: kMovieCardPosterGradient,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    releaseDate,
                    style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xBFffffff)
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
