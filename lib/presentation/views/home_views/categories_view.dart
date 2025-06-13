import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    final trendingMovies = ref.read(popularMoviesProvider);
    final loadNextPage = ref.read(popularMoviesProvider.notifier).loadNextPage;

    return Scaffold(
      body: MovieMasonry(
        movies: trendingMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
