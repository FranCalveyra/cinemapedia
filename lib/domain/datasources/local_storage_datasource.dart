import '../entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadFavorites({int limit = 10, offset = 0});
}
