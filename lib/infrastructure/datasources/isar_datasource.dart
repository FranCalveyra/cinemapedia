import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = _openDB();
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    return _movieExists(isar, movieId);
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final bool isAlreadyFavorite = await _movieExists(isar, movie.id);
    if (isAlreadyFavorite) {
      isar.writeTxnSync(() => isar.movies.deleteSync(movie.isarId!));
      return;
    }
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  Future<bool> _movieExists(Isar isar, int movieId) async =>
      await isar.movies.filter().idEqualTo(movieId).findFirst() != null;

  @override
  Future<List<Movie>> loadFavorites({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  Future<Isar> _openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
