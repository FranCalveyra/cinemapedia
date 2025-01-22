import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants/constants.dart';
import '../../../config/theme/app_styles.dart';

class CinemaAppBar extends ConsumerWidget {
  const CinemaAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final movieRepository = ref.watch(movieRepositoryProvider);
    final searchButton = IconButton(
        onPressed: () {
          showSearch(
              context: context,
              delegate: SearchMovieDelegate(
                  searchMovies: movieRepository.searchMovies));
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
