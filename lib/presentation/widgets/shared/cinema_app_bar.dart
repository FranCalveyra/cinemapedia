import 'package:flutter/material.dart';

import '../../../config/constants/constants.dart';
import '../../../config/theme/app_styles.dart';

class CinemaAppBar extends StatefulWidget {
  const CinemaAppBar({super.key});

  @override
  State<CinemaAppBar> createState() => _CinemaAppBarState();
}

class _CinemaAppBarState extends State<CinemaAppBar> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Constants.horizontalAppBarPadding),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Cinemapedia',
                style: AppStyles.titleStyle(context),
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
