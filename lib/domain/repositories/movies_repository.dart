import '../entities/movie.dart';

abstract class MovieRepository{
  List<Movie> getNowPlayingByPage({int page = 1});
}