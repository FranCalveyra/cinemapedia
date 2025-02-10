import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants/constants.dart';
import '../../../config/theme/app_styles.dart';

class CinemaAppBar extends ConsumerWidget {
  const CinemaAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final searchQuery = ref.watch(searchQueryProvider);
    final searchedMovies = ref.read(searchedMoviesProvider);

    final searchButton = IconButton(
        onPressed: () =>
            _searchMovies(context, searchQuery, searchedMovies, ref),
        icon: const Icon(Icons.search));

    final padding = EdgeInsets.symmetric(
      horizontal: Constants.horizontalAppBarPadding,
    );

    final cinemaButton = IconButton(
      icon: Icon(Icons.movie_outlined),
      color: colors.primary,
      onPressed: ref.watch(themeNotifierProvider.notifier).toggleDarkMode,
    );

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        cinemaButton,
        const SizedBox(width: 8),
        Text(
          'Cinemapedia',
          style: AppStyles.titleStyle(context),
        ),
        Spacer(),
        searchButton
      ],
    );
    var sizedBox = SizedBox(width: double.infinity, child: row);
    var safeArea = SafeArea(left: false, bottom: false, child: sizedBox);
    return Padding(padding: padding, child: safeArea);
  }

  void _searchMovies(BuildContext context, String? searchQuery,
      List<Movie> searchedMovies, WidgetRef ref) {
    showSearch<Movie?>(
            query: searchQuery,
            context: context,
            delegate: SearchMovieDelegate(
                initialMovies: searchedMovies,
                searchMovies: ref
                    .read(searchedMoviesProvider.notifier)
                    .searchMoviesByQuery))
        .then((movie) {
      if (movie == null) return;
      context.push("/home/0/movie/${movie.id}");
    });
  }
}
