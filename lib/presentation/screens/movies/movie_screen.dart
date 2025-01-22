import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/image_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants/constants.dart';
import '../../../domain/entities/movie.dart';
import '../../widgets/movies/movie_description.dart';

class MovieScreen extends ConsumerStatefulWidget {
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    // Weird solution I found in StackOverflow
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(movieInfoProvider.notifier).loadMovie(widget.movieId);
      ref.watch(actorsByMovieProvider.notifier).loadActors(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieMap = ref.watch(movieInfoProvider);
    final Movie? movie = movieMap[widget.movieId];

    if (movie == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: Constants.strokeWidth,
          ),
        ),
      );
    }

    final scrollView = CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => MovieDescription(movie: movie),
                childCount: 1)),
      ],
    );

    final scaffold = Scaffold(
      body: scrollView,
    );

    return scaffold;
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const titlePadding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0);

    final background = Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) return const SizedBox();
              return FadeIn(child: child);
            },
          ),
        ),
        ImageGradient(stops: [0.7, 1.0])
      ],
    );

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.yellow,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: titlePadding,
        background: background,
      ),
    );
  }
}
