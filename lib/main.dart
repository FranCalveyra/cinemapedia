import 'package:cinemapedia/config/router/app_router.dart';
import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';

void main(){
  runApp(const CinemaPediaApp());
}

class CinemaPediaApp extends StatelessWidget{
  const CinemaPediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().getTheme(),
    );
  }
}