import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/constants/constants.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_card.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      final currentPosition = scrollController.position.pixels;
      final maxPosition = scrollController.position.maxScrollExtent;

      if (currentPosition + 200 >= maxPosition) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.cardHeight,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) =>
                FadeInRight(child: MovieCard(movie: widget.movies[index])),
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
          ))
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge;
    final subtitleStyle = textTheme.titleMedium;

    final padding = const EdgeInsets.only(top: 16.0);
    final margin = const EdgeInsets.symmetric(horizontal: 16.0);
    final spacer = const Spacer();

    final filledButton = FilledButton.tonal(
      style: const ButtonStyle(visualDensity: VisualDensity.compact),
      onPressed: () {},
      child: Text(subtitle!, style: subtitleStyle),
    );

    return Container(
      padding: padding,
      margin: margin,
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          spacer,
          if (subtitle != null) filledButton
        ],
      ),
    );
  }
}
