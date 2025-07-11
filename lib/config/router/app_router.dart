import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final homeRoute = GoRoute(
    path: "/home/:page",
    builder: (context, state) {
      var pageIndex = int.parse(state.pathParameters['page'] ?? '0');
      if (pageIndex > 2 || pageIndex < 0) pageIndex = 0;
      return HomeScreen(pageIndex: pageIndex);
    },
    routes: [
      GoRoute(
        path: "movie/:id",
        builder: (context, state) =>
            MovieScreen(movieId: state.pathParameters["id"] ?? "no-id"),
      )
    ]);

final routes = [
  homeRoute,
  GoRoute(
    path: '/',
    redirect: (_, __) => '/home/0',
  ),
];

final router = GoRouter(
  initialLocation: "/home/0",
  routes: routes,
);
