import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: widget.currentIndex,
      onTap: (value) => _onItemTapped(context, value),
      items: _buildBottomNavigationBar(),
    );
  }
  
  // Private methods
  void _onItemTapped(BuildContext context, int index) {
    context.go("/home/$index");
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBar() {
    final homeBarItem =
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home');
    final trendingBarItem = BottomNavigationBarItem(
        icon: Icon(Icons.trending_up), label: 'Trending');
    final favoritesBarItem = BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline), label: 'Favorites');

    return [homeBarItem, trendingBarItem, favoritesBarItem];
  }
}
