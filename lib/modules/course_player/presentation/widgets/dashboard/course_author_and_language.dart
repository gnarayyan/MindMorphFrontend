import 'package:flutter/material.dart';
import 'package:mindmorph/constants/color.dart';
import 'package:mindmorph/constants/fonts.dart';
import 'package:mindmorph/modules/course_player/models/course_model.dart';
import 'package:mindmorph/utils/shorten_name.dart';
import 'package:velocity_x/velocity_x.dart';

class CourseAuthorAndLanguage extends StatelessWidget {
  const CourseAuthorAndLanguage({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        shortenName(course.author.fullName)
            .text
            .size(16)
            .fontFamily(bold)
            .color(subtexColor)
            .make(),
        Row(
          children: [
            const Icon(
              Icons.language,
              color: subtexColor,
            ),
            const SizedBox(width: 5),
            course.language.text.size(14).color(subtexColor).make(),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.group,
              color: Colors.amber,
            ),
            '  ${course.enrollCount}   '
                .toString()
                .text
                .color(subtexColor)
                .size(14)
                .make(),
          ],
        ),
      ],
    );
  }
}
