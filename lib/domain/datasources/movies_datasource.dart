import '../entities/movie.dart';

abstract class MovieDatasource{
  Future<List<Movie>> getNowPlayingByPage({int page = 1});
}