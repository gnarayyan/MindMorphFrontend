import 'package:flutter/material.dart';

class MindMorphLoadingIndicator extends StatelessWidget {
  const MindMorphLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.green,
    ));
  }
}
