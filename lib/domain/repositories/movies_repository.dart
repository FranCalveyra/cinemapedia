import '../entities/movie.dart';

abstract class MovieRepository{
  Future<List<Movie>> getNowPlayingByPage({int page = 1});
}