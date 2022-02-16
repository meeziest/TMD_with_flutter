import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies_flutter/model/movie_detail_response.dart';
import 'package:popular_movies_flutter/model/movie_list_response.dart';
import 'package:popular_movies_flutter/repositories/api_constants.dart';

class MovieRepository {
  final Dio _dio = Dio();
  var getPopularMoviesApi = '${ApiConstants.mainUrl}/movie/popular';
  var movieUrl = "${ApiConstants.mainUrl}/movie";

  Future<MovieListResponse> getPopularMovies(Locale locale) async {
    var params = {"api_key": ApiConstants.apiKey , "language": locale.languageCode};
    try{
      Response response = await _dio.get(getPopularMoviesApi, queryParameters: params);
      return compute(jsonToMoveListResponse, response);
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
    var params = {"api_key": ApiConstants.apiKey, "language": locale.languageCode};
      try {
        Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
        return compute(jsonToMoveDetailResponse, response);
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

  static MovieListResponse jsonToMoveListResponse(Response response){
      return MovieListResponse.fromJson(response.data);
  }

  static MovieDetailResponse jsonToMoveDetailResponse(Response response){
    return MovieDetailResponse.fromJson(response.data);
  }
}
