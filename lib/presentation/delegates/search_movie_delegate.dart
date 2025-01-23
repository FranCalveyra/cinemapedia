import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  @override
  String? get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    bool isSearching = false;

    final searchingIcon = SpinPerfect(
      child: Icon(Icons.refresh_rounded),
      infinite: true,
    );
    final deleteAllIcon = IconButton(
      onPressed: () => query = '',
      icon: Icon(Icons.clear),
    );

    final padding = FadeIn(
      animate: !isSearching,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: isSearching ? searchingIcon : deleteAllIcon,
      ),
    );

    return [padding];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_outlined),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: searchMovies(query),
      initialData: [],
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieListTile(movie: movie, onMovieSelected: close,);
          },
        );
      },
    );
  }
}
