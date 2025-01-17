import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

import '../../domain/datasources/movies_datasource.dart';

class MovieDbRepository extends MovieRepository{
  final MovieDatasource datasource;

  MovieDbRepository({required this.datasource});

  @override
  Future<List<Movie>> getNowPlayingByPage({int page = 1}) async {
    return await datasource.getNowPlayingByPage(page: page);

  }
}
