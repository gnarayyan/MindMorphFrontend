import 'package:flutter/material.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import '../../data/repositories/course_repository.dart';
import '../widgets/dashboard_view.dart';

class CourseDashboard extends StatelessWidget {
  const CourseDashboard(
      {super.key,
      required this.courseId,
      this.areSectionsPlayAble = false,
      this.showAddToCartBtn = false,
      this.hasEnrolled = false});

  final int courseId;
  final bool areSectionsPlayAble;
  final bool showAddToCartBtn;
  final bool hasEnrolled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CourseResponse>(
        future: CourseResponse.getData(courseId, hasEnrolled: hasEnrolled),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MindMorphLoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            final courseData = snapshot.data!;
            return DashboardView(
              courseData: courseData,
              areSectionsPlayAble: areSectionsPlayAble,
              showAddToCartBtn: showAddToCartBtn,
              hasEnrolled: hasEnrolled,
            );
          }
        },
      ),
    );
  }
}
