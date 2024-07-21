import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../data/repositories/purchased_courses_repository.dart';
import '../../models/certificate_on_courses.dart';
import '../widgets/eligible_course_list.dart';

class CompletedCoursesScreen extends StatelessWidget {
  const CompletedCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: featureColor),
        toolbarHeight: 80,
        shadowColor: Colors.white,
        backgroundColor: themecolor,
        title: const Text(
          'Completed Courses',
          style: TextStyle(color: titlecolor),
        ),
      ),
      backgroundColor: backgrounghilghtcolor,
      body: FutureBuilder<List<CertificateListModel>>(
          future: CertificateRepository.getEligibleCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MindMorphLoadingIndicator();
            } else if (snapshot.hasError) {
              return const ErrorPage(message: 'No Courses Completed');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const ErrorPage(message: 'No data available');
            } else {
              final courses = snapshot.data!;

              return EligibleCourseList(courses: courses);
            }
          }),
    );
  }
}
