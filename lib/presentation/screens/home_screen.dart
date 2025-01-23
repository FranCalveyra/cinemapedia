import 'package:cinemapedia/presentation/widgets/shared/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../views/home_views/home_view.dart';

class HomeScreen extends StatelessWidget {
  final Widget childView;

  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
