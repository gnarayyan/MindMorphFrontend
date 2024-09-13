import 'package:flutter/material.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/pdf_view_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/instructor/view_assignment_model.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/widgets/app_bar.dart';

class ViewAssignment extends StatelessWidget {
  const ViewAssignment({super.key, required this.assignment});
  final ViewAssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor,
      appBar: const MindMorphAppBar(title: 'View Assignment'),
      body: SingleChildScrollView(
        child: Container(
          width: context.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          color: themecolor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContentBox(label: 'Title', data: assignment.title),
                        const SizedBox(height: 10),
                        ContentBox(
                            label: 'Instructions',
                            data: assignment.instruction),
                        const SizedBox(height: 10),
                        ContentBox(
                            label: 'Points',
                            data: assignment.points.toString()),
                        const SizedBox(height: 10),
                        ContentBox(
                            label: 'Deadline',
                            data: assignment.deadline.toIso8601String()),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PDFViewScreen(
                                    appBarTitle: assignment.title,
                                    pdfUrl:
                                        'http://$NODE_SERVER/${assignment.attachment}',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'View Attachment',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 151, 68, 206),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  const ContentBox({super.key, required this.label, required this.data});
  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            data,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
        ),
      ],
    );
  }
}
