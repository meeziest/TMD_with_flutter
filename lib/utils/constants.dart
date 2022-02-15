import 'package:flutter/material.dart';

const String kImagePath = "https://image.tmdb.org/t/p/w500/";

const kBackPosterGradient = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    stops: [0.0, 1.0],
    colors: [
      Color(0xBB15141F),
      Color(0xF115141F),
    ]
);

const kMovieCardPosterGradient = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    stops: [0.0, 1.0],
    colors: [
      Color(0x11000000),
      Color(0xFB15141F),
    ]
);

const kAppBarTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 40,
  fontFamily: 'Rubik'
);

const kMovieTitleTextStyle = TextStyle(
    fontSize: 30,
    fontFamily: 'Rubik'
);

const kDropDownTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Rubik'
);

const kSelectedItemTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Rubik',
  fontSize: 20,
);

const kDropDownItemsTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Rubik',
);

const kMainTextStyle = TextStyle(fontSize: 18, fontFamily: 'Rubik');

const kGenresTextStyle = TextStyle(fontSize: 17, color: Color(0xAAFFFFFF), fontFamily: 'Rubik');

