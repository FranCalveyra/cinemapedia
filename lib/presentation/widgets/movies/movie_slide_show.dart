import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants/constants.dart';
import '../../../domain/entities/movie.dart';
import 'swiper_card.dart';

class MovieSlideShow extends StatelessWidget {
  final List<Movie> movies;

  const MovieSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final edgeInsets = const EdgeInsets.only(top: 0);

    final pagination = SwiperPagination(
      margin: edgeInsets,
      builder: DotSwiperPaginationBuilder(
        activeColor: colors.primary,
        color: colors.secondary,
      ),
    );

    final swiper = Swiper(
      viewportFraction: Constants.viewPortFraction,
      scale: Constants.scale,
      autoplay: true,
      pagination: pagination,
      itemCount: movies.length,
      itemBuilder: _buildSwiperCard,
    );

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: swiper,
    );
  }

  Widget _buildSwiperCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movies[index].id}'),
      child: FadeIn(child: SwiperCard(movie: movies[index])),
    );
  }
}
