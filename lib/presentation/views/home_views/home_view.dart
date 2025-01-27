import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView();

  @override
  ConsumerState<HomeView> createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const CinemaAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _CinemaBody();
            }, childCount: 1))
      ],
    );
  }
}

class _CinemaBody extends ConsumerWidget {
  const _CinemaBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);


    final nowPlayingListView = MovieHorizontalListview(
      movies: nowPlayingMovies,
      title: 'Now Playing',
      subtitle: 'Now Playing Movies',
      loadNextPage: () =>
          ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
    );

    final comingSoonListView = MovieHorizontalListview(
      movies: upcomingMovies,
      title: 'Coming Soon',
      subtitle: 'Upcoming Releases',
      loadNextPage: () =>
          ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
    );

    final topRatedListView = MovieHorizontalListview(
      movies: topRatedMovies,
      title: 'Top Rated',
      subtitle: 'Historical Ranking',
      loadNextPage: () =>
          ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
    );

    return Column(
      children: [
        MovieSlideShow(movies: slideShowMovies),
        nowPlayingListView,
        comingSoonListView,
        topRatedListView,
        SizedBox(height: 10),
      ],
    );
  }
}