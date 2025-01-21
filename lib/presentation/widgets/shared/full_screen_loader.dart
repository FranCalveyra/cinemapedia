import 'package:flutter/material.dart';

import '../../../config/constants/constants.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading movies...',
      'Buying some popcorn...',
      'Loading trending...',
      'Calling the boys...',
      'Getting the tickets...',
      'Which movie should I pick?...',
      'It\'s taking longer than expected... ',
    ];

    return Stream.periodic(Duration(milliseconds: Constants.movieLoadingDelay),
        (step) => messages[step]).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 16,);
    const progressIndicator = CircularProgressIndicator(strokeWidth: Constants.strokeWidth,);

    final streamBuilder = StreamBuilder(stream: getLoadingMessages(), builder: (context, snapshot){
      if(!snapshot.hasData) return const Text('Loading...');
      return Text(snapshot.data!);
    },);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please, wait'),
          sizedBox,
          progressIndicator,
          sizedBox,
          streamBuilder
        ],
      ),
    );
  }
}
