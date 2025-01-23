import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_stats.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants/constants.dart';
import '../../../domain/entities/movie.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.movie,
    required this.onMovieSelected,
  });
  final Function onMovieSelected;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final spacingBox = SizedBox(
      width: 16.0,
    );

    final cleanOverview = movie.overview.length > 150
        ? '${movie.overview.substring(0, 150)}...'
        : movie.overview;

    final textAndDescription = SizedBox(
      width: size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: textTheme.titleMedium,
          ),
          Text(
            cleanOverview,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          MovieStats(movie: movie, textTheme: textTheme)
        ],
      ),
    );

    final row = Row(
      children: [
        SizedBox(
          width: size.width * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
            child: Image.network(
              movie.posterPath,
              loadingBuilder: (context, child, loadingProgress) =>
                  FadeIn(child: child),
            ),
          ),
        ),
        spacingBox,
        textAndDescription,
      ],
    );

    final padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: row,
    );

    return GestureDetector(
      child: padding,
      onTap: ()=>onMovieSelected(context, movie),
    );
  }
}
