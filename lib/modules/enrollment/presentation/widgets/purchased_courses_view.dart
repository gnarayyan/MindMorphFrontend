import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/constants/urls.dart';

import '../../../profile/models/instructor_course_list_course_server.dart';

class PurchasedCoursesView extends StatelessWidget {
  const PurchasedCoursesView({super.key, required this.courses});
  final List<InstructorCourseModel> courses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: courses.length,
        itemBuilder: ((context, index) {
          final course = courses[index];
          return Card(
            color: boxtilecolor,
            semanticContainer: true,
            clipBehavior: Clip.hardEdge,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              leading: Container(
                decoration: const BoxDecoration(
                    // color: redColor,
                    ),
                width: 100,
                height: 150,
                child: Image.network(
                  'http://$COURSE_SERVER/${course.courseThumbnailUrl}',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                course.title,
                style: const TextStyle(color: titlecolor),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  context.push('/course/dashboard/enrolled/${course.courseId}'),
            ),
          );
        }));
  }
}
