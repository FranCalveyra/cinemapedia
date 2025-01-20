import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/constants.dart';
import '../shared/custom_network_image.dart';

class SwiperCard extends StatelessWidget {
  final Movie movie;

  const SwiperCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(Constants.borderRadius);
    final decoration = BoxDecoration(borderRadius: borderRadius, boxShadow: [
      BoxShadow(
        color: Colors.black45,
        blurRadius: Constants.blurRadius,
        offset: Offset(0, 10),
      )
    ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.swiperCardBottomPadding),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: SwiperNetworkImage(movie: movie),
        ),
      ),
    );
  }
}
