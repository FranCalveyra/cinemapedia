import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_details.dart';

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
        releaseDate: movieDbMovie.releaseDate != null ? movieDbMovie.releaseDate! : DateTime.now(),
        title: movieDbMovie.title,
        video: movieDbMovie.video,
        voteAverage: movieDbMovie.voteAverage,
        voteCount: movieDbMovie.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
        adult: movieDetails.adult,
        backdropPath: _getCleanPath(movieDetails.backdropPath),
        genreIds: movieDetails.genres.map((genre) => genre.name).toList(),
        id: movieDetails.id,
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        overview: movieDetails.overview,
        popularity: movieDetails.popularity,
        posterPath: _getCleanPath(movieDetails.posterPath),
        releaseDate: movieDetails.releaseDate != null ? movieDetails.releaseDate! : DateTime.now(),
        title: movieDetails.title,
        video: movieDetails.video,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount,
      );
}

String _getCleanPath(String path) {
  return (path != '')
      ? 'https://image.tmdb.org/t/p/w500$path'
      : Constants.webErrorImagePath;
}
