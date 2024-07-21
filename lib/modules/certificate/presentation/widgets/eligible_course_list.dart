import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/download_file_button.dart';
import 'package:mindmorph/widgets/pdf_view_screen.dart';
import '../../models/certificate_on_courses.dart';

class EligibleCourseList extends StatelessWidget {
  const EligibleCourseList({super.key, required this.courses});
  final List<CertificateListModel> courses;

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
              onLongPress: () =>
                  context.push('/course/dashboard/enrolled/${course.courseId}'),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              leading: SizedBox(
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
              subtitle: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      //Certificate View Page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PDFViewScreen(
                              appBarTitle: course.title,
                              pdfUrl:
                                  'http://$PYTHON_SERVER/${course.certificateViewUrl}'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.visibility),
                  ),
                  MindMorphDownloadFileButton(
                      pdfUrl:
                          'http://$PYTHON_SERVER/${course.certificateViewUrl}')
                ],
              ),
            ),
          );
        }));
  }
}
