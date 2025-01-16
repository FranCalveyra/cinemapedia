import '../entities/movie.dart';

abstract class MovieDatasource{
  List<Movie> getNowPlayingByPage({int page = 1});
}