import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../../profile/models/instructor_course_list_course_server.dart';
import '../../data/repositories/purchased_courses_repository.dart';
import '../widgets/purchased_courses_view.dart';

class PurchasedCoursesScreen extends StatelessWidget {
  const PurchasedCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: featureColor),
        toolbarHeight: 80,
        shadowColor: Colors.white,
        backgroundColor: themecolor,
        title: const Text(
          'Enrolled Courses',
          style: TextStyle(color: titlecolor),
        ),
      ),
      backgroundColor: backgrounghilghtcolor,
      body: FutureBuilder<List<InstructorCourseModel>>(
          future: PurchasedCoursesRepository.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MindMorphLoadingIndicator();
            } else if (snapshot.hasError) {
              return const ErrorPage(message: 'No Courses Enrolled');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const ErrorPage(message: 'No data available');
            } else {
              final courses = snapshot.data!;

              return PurchasedCoursesView(courses: courses);
            }
          }),
    );
  }
}
