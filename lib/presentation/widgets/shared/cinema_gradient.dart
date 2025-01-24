import 'package:flutter/material.dart';

class CinemaGradient extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;

  const CinemaGradient({
    super.key,
    this.colors = const [Colors.transparent, Colors.black87],
    this.stops = const [0.4, 1.0],
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  }) : assert(colors.length == stops.length,
            "Stops and Colors must be same length");

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            stops: stops,
            begin: begin,
            end: end,
          ),
        ),
      ),
    );
  }
}
