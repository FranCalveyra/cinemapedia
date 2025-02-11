import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  final StreamController<List<Movie>> debouncedMovies =
      StreamController.broadcast();
  final StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  List<Movie> initialMovies;

  SearchMovieDelegate({
    required this.searchMovies,
    this.initialMovies = const [],
  });

  @override
  String? get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    final searchingIcon = SpinPerfect(
      child: Icon(Icons.refresh_rounded),
      infinite: true,
      duration: const Duration(seconds: 20),
    );

    final deleteAllIcon = FadeIn(
      child: IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      ),
    );

    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          final isSearching = snapshot.data ?? false;

          final padding = Padding(
            padding: const EdgeInsets.only(right: 16),
            child: isSearching ? searchingIcon : deleteAllIcon,
          );
          return padding;
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        _clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder<List<Movie>>(
      stream: debouncedMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return _getListViewBuilder(movies);
      },
    );
  }

  ListView _getListViewBuilder(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildListTile(movie);
      },
    );
  }

  MovieListTile _buildListTile(Movie movie) {
    return MovieListTile(
      movie: movie,
      onMovieSelected: (context, movie) {
        _clearStreams();
        close(context, movie);
      },
    );
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  void _clearStreams() {
    debouncedMovies.close();
  }
}
