import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: "movie/:id",
          builder: (context, state) =>
              MovieScreen(movieId: state.pathParameters["id"] ?? "no-id"),
        )
      ]
    ),

  ],
);
