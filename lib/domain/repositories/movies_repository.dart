import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlayingByPage({int page = 1});

  Future<List<Movie>> getPopularByPage({int page = 1});

  Future<List<Movie>> getComingSoonByPage({int page = 1});

  Future<List<Movie>> getTopRatedByPage({int page = 1});

  Future<Movie> getMovieById(String id);
}
