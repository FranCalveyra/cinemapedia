import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  final popularMovies = ref.watch(popularMoviesProvider);
  final upcomingMovies = ref.watch(upcomingMoviesProvider);
  final topRatedMovies = ref.watch(topRatedMoviesProvider);

  final movies = [
    nowPlayingMovies,
    popularMovies,
    upcomingMovies,
    topRatedMovies
  ];

  return movies.any((movieList) => movieList.isEmpty);
});
