import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActorHorizontalList extends ConsumerWidget {
  final String movieId;

  const ActorHorizontalList({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider)[movieId];

    if (actorsByMovie == null) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: Constants.strokeWidth,
        ),
      );
    }

    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          itemCount: actorsByMovie.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final actor = actorsByMovie[index];
            return Container(
              padding: const EdgeInsets.all(8),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                    child: _buildImage(actor),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    actor.name,
                    style: textTheme.bodyLarge,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    actor.character ?? "",
                    style: TextStyle(
                      fontSize: textTheme.bodySmall!.fontSize,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }),
    );
  }

  Image _buildImage(Actor actor){
    if(actor.profilePath == Constants.defaultProfileImagePath){
      return Image.asset(actor.profilePath, fit: BoxFit.cover, height: 180,);
    }

    return Image.network(actor.profilePath, fit: BoxFit.cover);
  }
}
