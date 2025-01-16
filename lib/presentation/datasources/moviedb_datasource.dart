import 'package:cinemapedia/domain/entities/movie.dart';

import '../../domain/datasources/movies_datasource.dart';

class MovieDBDatasource extends MovieDatasource{
  @override
  List<Movie> getNowPlayingByPage({int page = 1}) {
    // TODO: implement getNowPlayingByPage
    throw UnimplementedError();
  }

}