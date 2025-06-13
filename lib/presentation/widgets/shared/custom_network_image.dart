import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/shared/cinema_gradient.dart';
import 'package:flutter/material.dart';

class SwiperNetworkImage extends StatelessWidget {
  final Movie movie;

  const SwiperNetworkImage({super.key, required this.movie});

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

    final textStyle = TextStyle(
        color: Colors.white,
        decorationColor: Colors.black45,
        fontSize: Constants.movieTitleFontSize);

    var text = Text(
      movie.title,
      style: textStyle,
    );
    const distance = 16.0;
    return Stack(
      children: [
        image,
        CinemaGradient(),
        Positioned(
          bottom: distance,
          left: distance,
          right: distance,
          child: text,
        )
      ],
    );
  }
}
