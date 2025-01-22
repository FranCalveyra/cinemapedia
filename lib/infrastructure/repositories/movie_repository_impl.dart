import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

import '../../domain/datasources/movies_datasource.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getNowPlayingByPage({int page = 1}) async {
    return await datasource.getNowPlayingByPage(page: page);
  }

  @override
  Future<List<Movie>> getComingSoonByPage({int page = 1}) async {
    return await datasource.getComingSoonByPage(page: page);
  }

  @override
  Future<List<Movie>> getPopularByPage({int page = 1}) async {
    return await datasource.getPopularByPage(page: page);
  }

  @override
  Future<List<Movie>> getTopRatedByPage({int page = 1}) async {
    return await datasource.getTopRatedByPage(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    return await datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await datasource.searchMovies(query);
  }
}
