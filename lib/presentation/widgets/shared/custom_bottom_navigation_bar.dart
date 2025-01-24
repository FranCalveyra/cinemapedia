import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: _getCurrentIndex(context),
      onTap: (value) => _onItemTapped(context, value),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Categories'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favorites'),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    var routes = {0: "/", 1: "/categories", 2: "/favorites"};
    context.go(routes[index] ?? "/");
  }

  int _getCurrentIndex(BuildContext context) {
    var routes = {"/": 0, "/categories": 1, "/favorites": 2};
    final String location = GoRouterState.of(context).uri.toString();
    return routes[location] ?? 0;
  }
}
