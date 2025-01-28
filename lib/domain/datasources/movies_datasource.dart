import 'package:cinemapedia/domain/entities/entities.dart';


abstract class MovieDatasource {
  Future<List<Movie>> getNowPlayingByPage({int page = 1});

  Future<List<Movie>> getPopularByPage({int page = 1});

  Future<List<Movie>> getComingSoonByPage({int page = 1});

  Future<List<Movie>> getTopRatedByPage({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovies(String query);

  Future<List<Movie>> getSimilarMovies(int movieId);

  Future<List<Video>> getYoutubeVideosById(int movieId);
}
