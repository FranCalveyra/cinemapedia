import 'package:cinemapedia/config/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';
import '../actors/actor_horizontal_list.dart';

class MovieDescription extends StatelessWidget {
  final Movie movie;

  const MovieDescription({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final description = SizedBox(
      width: (size.width - 40) * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(movie.title, style: textTheme.titleLarge),
          const SizedBox(
            height: 8,
          ),
          Text(movie.overview, style: textTheme.bodyMedium),
        ],
      ),
    );

    final roundedImage = ClipRRect(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      child: Image.network(
        movie.posterPath,
        width: size.width * 0.3,
      ),
    );

    final lead = Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          roundedImage,
          const SizedBox(width: 10),
          description,
        ],
      ),
    );

    final genres = Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        children: [
          ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.borderRadius)),
                ),
              ))
        ],
      ),
    );

    final actors = ActorHorizontalList(movieId: movie.id.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        lead,
        genres,
        actors,
        SizedBox(height: 50),
      ],
    );
  }
}
