import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      movie.posterPath,
      fit: BoxFit.cover,
      width: Constants.cardWidth,
      loadingBuilder: _loadingBuilder,
    );

    final card = SizedBox(
      width: Constants.cardWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: image,
      ),
    );

    final margin = EdgeInsets.symmetric(horizontal: 8, vertical: 8.0);
    final sizedBox = SizedBox(
      height: 8,
    );

    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleSmall;
    final title = SizedBox(
      width: Constants.cardWidth,
      child: Text(
        movie.title,
        maxLines: 1,
        style: titleStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );

    final stats = _Stats(movie: movie, textTheme: textTheme);

    return Container(
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          card,
          sizedBox,
          title,
          stats,
        ],
      ),
    );
  }

  Widget _loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    final colors = Theme.of(context).colorScheme;
    final progressIndicator = CircularProgressIndicator(
      color: colors.primary,
      strokeWidth: Constants.strokeWidth,
    );
    final toReturn = loadingProgress != null ? progressIndicator : child;
    return Center(
      child: toReturn,
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({
    required this.movie,
    required this.textTheme,
  });

  final Movie movie;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final sizedBox = SizedBox(
      width: 8,
    );

    return Row(
      children: [
        Icon(
          Icons.star_half_outlined,
          color: Colors.yellow.shade800,
        ),
        sizedBox,
        Text(
          HumanFormats.voteAverage(movie.voteAverage),
          maxLines: 2,
          style:
              textTheme.bodyMedium?.copyWith(color: Colors.yellow.shade800),
        ),
        sizedBox,
        Text(
          HumanFormats.number(movie.popularity),
          maxLines: 2,
          style: textTheme.bodyMedium?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
