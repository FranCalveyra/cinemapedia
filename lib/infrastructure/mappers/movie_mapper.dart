import 'package:cinemapedia/infrastructure/models/movie_moviedb.dart';

import '../../config/constants/constants.dart';
import '../../domain/entities/movie.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieDbMovie) => Movie(
        adult: movieDbMovie.adult,
        backdropPath: _getCleanPath(movieDbMovie.backdropPath),
        genreIds: movieDbMovie.genreIds.map((id) => id.toString()).toList(),
        id: movieDbMovie.id,
        originalLanguage: movieDbMovie.originalLanguage,
        originalTitle: movieDbMovie.originalTitle,
        overview: movieDbMovie.overview,
        popularity: movieDbMovie.popularity,
        posterPath: _getCleanPath(movieDbMovie.posterPath),
        releaseDate: movieDbMovie.releaseDate,
        title: movieDbMovie.title,
        video: movieDbMovie.video,
        voteAverage: movieDbMovie.voteAverage,
        voteCount: movieDbMovie.voteCount,
      );
}

String _getCleanPath(String path) {
  return (path != '')
      ? 'https://image.tmdb.org/t/p/w500$path'
      : Constants.webErrorImagePath;
}
