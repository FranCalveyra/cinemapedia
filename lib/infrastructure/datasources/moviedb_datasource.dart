import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

import '../../domain/datasources/movies_datasource.dart';

class MovieDBDatasource extends MovieDatasource{
  final Dio dio  = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3"
    )
  );

  @override
  Future<List<Movie>> getNowPlayingByPage({int page = 1}) async{
    // TODO: implement getNowPlayingByPage
    throw UnimplementedError();
  }

}