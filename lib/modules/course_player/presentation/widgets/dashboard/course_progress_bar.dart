import 'package:flutter/material.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CourseProgressBar extends StatelessWidget {
  const CourseProgressBar({super.key, required this.completed});
  final double? completed;

  @override
  Widget build(BuildContext context) {
    return completed == null
        ? const MindMorphLoadingIndicator()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 10.0,
              percent: completed!,
              center: Text(
                "${(completed! * 100).toDoubleStringAsFixed(digit: 0)}%",
                style: const TextStyle(color: Colors.greenAccent),
              ),
              progressColor: Colors.green,
            ),
          );

    // Row(
    //   children: [
    //     ' Your Progress '.text.size(14).color(Colors.amber).make(),
    //     SizedBox(
    //       height: 80,
    //       child:,
    //     ),
    //   ],
    // );
  }
}
