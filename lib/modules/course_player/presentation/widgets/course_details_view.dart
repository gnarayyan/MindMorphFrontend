import 'package:flutter/material.dart';
import 'package:mindmorph/constants/color.dart';
import 'package:mindmorph/modules/course_player/models/course_model.dart';
import 'package:velocity_x/velocity_x.dart';

import 'dashboard/course_author_and_language.dart';
import 'dashboard/course_rating_and_price.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key, required this.course, required this.title});
  final CourseModel course;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 249, 249, 249).withOpacity(0.2),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        color: themecolor,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          10.heightBox,
          CourseRatingAndPrice(course: course),
          10.heightBox,
          CourseAuthorAndLanguage(course: course),
          20.heightBox,
        ],
      ),
    );
  }
}
