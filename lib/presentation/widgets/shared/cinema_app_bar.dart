import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
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
    final searchQuery = ref.read(searchQueryProvider);
    final searchedMovies = ref.read(searchedMoviesProvider);

    final searchButton = IconButton(
        onPressed: () {
          showSearch(
              query: searchQuery,
              context: context,
              delegate: SearchMovieDelegate(
                initialMovies: searchedMovies,
                  searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery)).then((movie){
                    if(movie == null) return;
                    context.push("/movie/${movie.id}");
          });
        },
        icon: Icon(Icons.search));

    return SafeArea(
      bottom: false,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Constants.horizontalAppBarPadding),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Cinemapedia',
                style: AppStyles.titleStyle(context),
              ),
              Spacer(),
              searchButton
            ],
          ),
        ),
      ),
    );
  }
}
