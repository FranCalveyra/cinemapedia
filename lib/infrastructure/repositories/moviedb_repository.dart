import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieDbRepository extends MovieRepository{
  @override
  List<Movie> getNowPlayingByPage({int page = 1}) {
    // TODO: implement getNowPlayingByPage
    throw UnimplementedError();
  }
}
