import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'no_favorites_added.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      final currentPosition = scrollController.position.pixels;
      final maxPosition = scrollController.position.maxScrollExtent;

      if (currentPosition + 100 >= maxPosition) {
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
    final padding = Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        itemBuilder: (context, index) {
          final card = FadeInUp(child: _buildMovieCard(index));

          if (index == 1)
            return Column(
              children: [SizedBox(height: 40), card],
            );

          return card;
        },
        itemCount: widget.movies.length,
      ),
    );

    final noMovies = NoFavoritesAdded();

    return widget.movies.isEmpty ? noMovies : padding;
  }

  Widget _buildMovieCard(int index) {
    return MovieCard(
      movie: widget.movies[index],
      showInfo: false,
    );
  }
}
