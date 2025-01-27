import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoFavoritesAdded extends StatelessWidget {
  const NoFavoritesAdded({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final icon = Icon(
      Icons.favorite_outline_sharp,
      size: 60,
      color: colors.primary,
    );

    final text = const Text(
      'No favorites added yet!',
      style: TextStyle(color: Colors.grey, fontSize: 20),
    );

    final sizedBox = SizedBox(height: 8);

    final title = Text(
      'Favorite Movies',
      style: TextStyle(fontSize: 30, color: colors.primary),
      textAlign: TextAlign.center,
    );

    final searchMoviesButton = FilledButton(
      onPressed: () => context.go("/home/0"),
      child: const Text('Search movies'),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          title,
          sizedBox,
          text,
          sizedBox,
          searchMoviesButton,
        ],
      ),
    );
  }
}
