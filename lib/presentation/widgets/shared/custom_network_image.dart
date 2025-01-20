import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/shared/image_decoration.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final Movie movie;

  const CustomNetworkImage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      movie.backdropPath,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null)
          return const DecoratedBox(
              decoration: BoxDecoration(color: Colors.black12));
        return child;
      },
    );

    var colors = Theme.of(context).colorScheme;

    var text = Text(
      movie.title,
      style: TextStyle(color: colors.surface, decorationColor: Colors.black45,
      fontSize: Constants.movieTitleFontSize),
    );

    return Stack(
      children: [
        image,
        ImageDecoration(),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: text,
        )
      ],
    );
  }
}
