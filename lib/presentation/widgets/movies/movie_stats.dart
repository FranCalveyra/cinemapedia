import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

class MovieStats extends ConsumerWidget {
  const MovieStats({
    required this.movie,
    required this.textTheme,
  });

  final Movie movie;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizedBox = SizedBox(width: 8);
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    final popularityColor = isDarkMode ? Colors.white : Colors.black;

    final voteColor = Colors.yellow.shade800;

    return SizedBox(
      width: Constants.cardWidth,
      child: Row(
        children: [
          Icon(Icons.star_half_outlined, color: voteColor),
          sizedBox,
          Text(
            HumanFormats.number(movie.voteAverage, 1),
            maxLines: 2,
            style: textTheme.bodyMedium?.copyWith(color: voteColor),
          ),
          const Spacer(),
          Icon(Icons.remove_red_eye),
          sizedBox,
          Text(
            HumanFormats.number(movie.popularity),
            maxLines: 2,
            style: textTheme.bodyMedium?.copyWith(color: popularityColor),
          ),
        ],
      ),
    );
  }
}
