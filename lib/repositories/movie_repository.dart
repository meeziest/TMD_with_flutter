import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies_flutter/model/movie_detail_response.dart';
import 'package:popular_movies_flutter/model/movie_list_response.dart';
// import 'dart:isolate';

class MovieRepository {
  final String apiKey = "2f05ecb893a6f356e596873f1972d65b";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getPopularMoviesApi = '$mainUrl/movie/popular';
  var movieUrl = "$mainUrl/movie";

  Future<MovieListResponse> getPopularMovies(Locale locale) async {
    var params = {"api_key": apiKey, "language": locale.languageCode};
    try{
      Response response = await _dio.get(getPopularMoviesApi, queryParameters: params);
      return MovieListResponse.fromJson(response.data);
    } on SocketException {
      throw MovieListResponse.withError("No internet connection!");
    } on FormatException {
      throw MovieListResponse.withError("Bad server response");
    } on HttpException {
      throw MovieListResponse.withError("Bad request 404");
    } on Exception {
      throw MovieListResponse.withError("Unexpected error");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id, Locale locale) async {
    var params = {"api_key": apiKey, "language": locale.languageCode};
      try {
        Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
        return MovieDetailResponse.fromJson(response.data);
    } on SocketException {
      throw MovieDetailResponse.withError("No internet connection!");
    } on FormatException {
      throw MovieDetailResponse.withError("Bad server response");
    } on HttpException {
      throw MovieDetailResponse.withError("Bad request 404");
    } on Exception {
      throw MovieDetailResponse.withError("Unexpected error");
    }
  }

  // Future _readAndParseMovieListJson(List<dynamic> args) async {
  //   SendPort responsePort = args[0];
  //   Locale locale = args[1];
  //   var params = {"api_key": apiKey, "language": locale.languageCode};
  //   Response response = await _dio.get(getPopularMoviesApi, queryParameters: params);
  //   MovieListResponse moviesListResponse = MovieListResponse.fromJson(response.data);
  //   Isolate.exit(responsePort, moviesListResponse);
  // }
  //
  // Future _readAndParseMovieDetailJson(List<dynamic> args) async {
  //   SendPort responsePort = args[0];
  //   Locale locale = args[1];
  //   int id = args[2];
  //   var params = {"api_key": apiKey, "language": locale.languageCode};
  //   Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
  //   MovieDetailResponse movieDetailResponse = MovieDetailResponse.fromJson(response.data);
  //   Isolate.exit(responsePort, movieDetailResponse);
  // }
}
