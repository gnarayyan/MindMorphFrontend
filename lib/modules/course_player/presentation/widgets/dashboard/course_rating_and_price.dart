import 'package:flutter/material.dart';
import 'package:mindmorph/modules/course_player/models/course_model.dart';
import 'package:mindmorph/modules/course_player/presentation/widgets/dashboard/rating_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class CourseRatingAndPrice extends StatelessWidget {
  const CourseRatingAndPrice({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBar(rating: course.rating, fontSize: 15),
        Row(
          children: [
            if (course.discountPercent > 0)
              'Rs ${course.price}'.text.color(Colors.grey).lineThrough.make(),
            '     Rs ${(course.price * (1 - course.discountPercent / 100)).toDoubleStringAsFixed(digit: 0)}'
                .text
                .color(Colors.amber)
                .make(),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
