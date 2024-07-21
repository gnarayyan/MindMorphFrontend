import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/constants/color.dart';
import 'package:mindmorph/constants/urls.dart';

import '../models/search_response.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    super.key,
    required this.courses,
  });

  final List<SearchModel> courses;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgrounghilghtcolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                itemBuilder: ((context, index) {
                  final course = courses[index];
                  return Card(
                    color: boxtilecolor,
                    semanticContainer: true,
                    clipBehavior: Clip.hardEdge,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      leading: Container(
                        decoration: const BoxDecoration(
                          color: redColor,
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
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: Color.fromARGB(255, 171, 90, 84),
                      ),
                      onTap: () {
                        print('Curse Id: ${course.courseId}');
                        context.push('/course/dashboard/${course.courseId}');
                      },
                    ),
                  );
                })),
          ],
        ),
      ),
    );
  }
}
