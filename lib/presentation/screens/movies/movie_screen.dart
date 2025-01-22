import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/widgets/shared/image_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants/constants.dart';
import '../../../domain/entities/movie.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Weird solution I found in Stack Overflow
      ref.watch(movieInfoProvider.notifier).loadMovie(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieMap = ref.watch(movieInfoProvider);
    final Movie movie = movieMap[widget.movieId]!;

    final scrollView = CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MovieDescription(movie: movie),
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

    final textStyle = TextStyle(fontSize: 20, color: Colors.white);

    final title = Text(
      movie.title,
      style: textStyle,
      textAlign: TextAlign.start,
    );

    const titlePadding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0);

    final background = Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
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
        title: title,
        titlePadding: titlePadding,
        background: background,
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  final Movie movie;

  const _MovieDescription({required this.movie});

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
          const SizedBox(height: 8,),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        lead,
        genres,
      ],
    );
  }
}
