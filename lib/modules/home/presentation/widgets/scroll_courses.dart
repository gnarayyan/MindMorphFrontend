import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/course_carasoul_data_model.dart';
import '/constants/color.dart';
import '/constants/urls.dart';
import '../../../screens/commonwidget/coursettitle/coursetitle.dart';

class ScrollCourse extends StatelessWidget {
  const ScrollCourse({super.key, required this.courses, this.messageOnEmpty});

  final List<CourseCarasoulData> courses;
  final String? messageOnEmpty;

  @override
  Widget build(BuildContext context) {
    return courses.isEmpty
        ? ErrorPage(message: messageOnEmpty ?? 'Nothing to Show')
        : Card(
            color: backgrounghilghtcolor,
            shadowColor: const Color.fromARGB(255, 17, 17, 16),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: 200,
              width: 500,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    courses.length,
                    (index) => GestureDetector(
                      onTap: () {
                        int courseId = courses[index].id;
                        context.push('/course/dashboard/$courseId');
                      },
                      child: Container(
                        height: 250,
                        width: 178,
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          children: [
                            featurelistRow(
                                image:
                                    'http://$COURSE_SERVER/${courses[index].courseThumbnailUrl}',
                                name: courses[index].title,
                                price: courses[index].price.toInt(),
                                rating: courses[index].rating,
                                isNetwork: true,
                                discountPercent:
                                    courses[index].discountPercent),
                          ],
                        ).box.make(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
