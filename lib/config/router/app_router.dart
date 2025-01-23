import 'package:cinemapedia/presentation/screens/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia/presentation/views/home_views/categories_view.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final homeRoute =
    GoRoute(path: "/", builder: (context, state) => const HomeView(), routes: [
  GoRoute(
    path: "movie/:id",
    builder: (context, state) =>
        MovieScreen(movieId: state.pathParameters["id"] ?? "no-id"),
  )
]);

final router = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
        builder: (context, state, child) => HomeScreen(childView: child),
        routes: [
          homeRoute,
          GoRoute(
            path: "/favorites",
            builder: (context, state) => const FavoritesView(),
          ),
          GoRoute(
            path: "/categories",
            builder: (context, state) => const CategoriesView(),
          )
        ])
  ],
);
