import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl({required this.datasource});

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    return await datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadFavorites({int limit = 10, offset = 0}) async {
    return await datasource.loadFavorites(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    return await datasource.toggleFavorite(movie);
  }
}
