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
    return _getMoviesByPath("/movie/now_playing", page);
  }

  @override
  Future<List<Movie>> getComingSoonByPage({int page = 1}) async {
    return _getMoviesByPath("/movie/upcoming", page);
  }

  @override
  Future<List<Movie>> getPopularByPage({int page = 1}) async {
    return _getMoviesByPath("/movie/popular", page);
  }

  @override
  Future<List<Movie>> getTopRatedByPage({int page = 1}) async {
    return _getMoviesByPath("/movie/top_rated", page);
  }

  Future<List<Movie>> _getMoviesByPath(String path, int page) async {
    final response = await dio.get(path, queryParameters: {'page': page});
    final MovieDbResponse movieDbResponse =
        MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != Constants.webErrorImagePath)
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();
    return movies;
  }
}
