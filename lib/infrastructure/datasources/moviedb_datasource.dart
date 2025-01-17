import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/constants.dart';
import '../../domain/datasources/movies_datasource.dart';

class MovieDBDatasource extends MovieDatasource {
  final Dio dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        'api_key': Environment.movieDbApiKey,
        'language': 'en-US'
      }));

  @override
  Future<List<Movie>> getNowPlayingByPage({int page = 1}) async {
    final response = await dio.get("/movie/now-playing");
    final MovieDbResponse movieDbResponse =
        MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != Constants.webErrorImagePath)
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();
    return movies;
  }
}
