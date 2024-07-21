import 'package:flutter/material.dart';
import 'package:mindmorph/constants/color.dart';
import '../../models/course_carasoul_data_model.dart';
import 'carousel_course.dart';
import 'scroll_courses_title.dart';
import 'top_nav_bar.dart';
import 'package:mindmorph/modules/home/presentation/widgets/scroll_courses.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    super.key,
    required this.trendingCourses,
    required this.newCourses,
    required this.recommendedCourses,
  });

  final List<CourseCarasoulData> trendingCourses;
  final List<CourseCarasoulData> newCourses;
  final List<CourseCarasoulData> recommendedCourses;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: themecolor,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(children: [
          const TopNavBar(),
          const SizedBox(height: 40),
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const CarouselCourse(),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 0.8,
                  color: Color.fromARGB(255, 148, 145, 145),
                ),
                const ScrollCoursesTitle(
                  title: 'Recommended Courses',
                ),
                // const FeatureCourseList(),
                ScrollCourse(
                  courses: recommendedCourses,
                  messageOnEmpty: 'Enroll Some Courses to Get Recommendation',
                ),
                const ScrollCoursesTitle(title: 'Top Rated Courses'),
                ScrollCourse(courses: trendingCourses),
                const ScrollCoursesTitle(title: 'New Courses'),
                ScrollCourse(courses: newCourses),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
