import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

import '../models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: _clearPath(cast),
        character: cast.character,
      );
}

String _clearPath(Cast cast) {
  return cast.profilePath != null
      ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
      : Constants.defaultProfileImagePath;
}
