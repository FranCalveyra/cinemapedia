import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'movie_stats.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool showInfo;
  const MovieCard({super.key, required this.movie, this.showInfo = true});

  @override
  Widget build(BuildContext context) {
    final image = GestureDetector(
      onTap: ()=>context.push('/home/0/movie/${movie.id}'),
      child: Image.network(
        movie.posterPath,
        fit: BoxFit.cover,
        width: Constants.cardWidth,
        loadingBuilder: _loadingBuilder,
      ),
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

    final stats = MovieStats(movie: movie, textTheme: textTheme);

    return Container(
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          card,
          sizedBox,
          if(showInfo)title,
          if(showInfo) stats,
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
