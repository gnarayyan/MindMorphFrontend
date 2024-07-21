import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../data/repositories/course_initialize_submit_repository.dart';
import '../../models/instructor_course_list_course_server.dart';
import '/constants/color.dart';

class ListInstructorCourse extends StatelessWidget {
  const ListInstructorCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Courses',
            style: TextStyle(color: featureColor, fontSize: 20)),
        iconTheme: const IconThemeData(color: titlecolor),
        backgroundColor: const Color.fromARGB(255, 8, 27, 42),
        actions: [
          IconButton(
              onPressed: () {
                context.push('/course/initialize');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<InstructorCourseModel>>(
        future: InstructorCoursesRepository.coursesByAuthorId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MindMorphLoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const ErrorPage(message: 'No data avilable');
          } else {
            final courses = snapshot.data!;
            return InstructorCoursesView(courses: courses);
          }
        },
      ),
    );
  }
}

class InstructorCoursesView extends StatelessWidget {
  const InstructorCoursesView({
    super.key,
    required this.courses,
  });

  final List<InstructorCourseModel> courses;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themecolor,
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: ((BuildContext context, index) {
          final course = courses[index];
          return SizedBox(
            height: 100,
            child: Card(
              elevation: 50,
              color: boxtilecolor,
              semanticContainer: true,
              child: Column(
                children: [
                  ListTile(
                    onTap: () =>
                        context.push('/course/dashboard/${course.courseId}'),
                    onLongPress: () =>
                        context.push('/course/sections/${course.courseId}'),
                    leading: Container(
                      decoration: const BoxDecoration(),
                      width: 100,
                      height: 200,
                      child: Image.network(
                        'http://$COURSE_SERVER/${course.courseThumbnailUrl}',
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(
                      course.title,
                      style: const TextStyle(color: titlecolor, fontSize: 18),
                    ),
                    subtitle: Text(
                      'Rs ${course.price!.toDoubleStringAsFixed(digit: 0)}',
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 193, 7, 1), fontSize: 14),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () =>
                  //           context.push('/course/sections/${course.courseId}'),
                  //       icon: const Icon(Icons.edit),
                  //       color: Colors.grey,
                  //     ),
                  // IconButton(
                  //   onPressed: () => context
                  //       .push('/course/dashboard/${course.courseId}'),
                  //   icon: const Icon(Icons.play_arrow),
                  //   color: Colors.grey,
                  // ),
                  // IconButton(
                  //   onPressed: () => context
                  //       .push('/course/dashboard/${course.courseId}'),
                  //   icon: const Icon(Icons.remove_red_eye),
                  //   color: Colors.grey,
                  // ),
                  // ],
                  // )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
