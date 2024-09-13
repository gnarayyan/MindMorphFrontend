import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/snackbar.dart';

import '../../../data/repository/assignemnt_instructor_repository.dart';
import '../../../models/instructor/view_assignment_model.dart';
import '../../screens/instructor/update_assignment.dart';
import '../../screens/instructor/view_assignment.dart';
import 'course_thumbnail.dart';

class AssignmentViewList extends StatefulWidget {
  const AssignmentViewList({super.key, required this.assignments});
  final List<ViewAssignmentModel> assignments;

  @override
  State<AssignmentViewList> createState() => _AssignmentViewListState();
}

class _AssignmentViewListState extends State<AssignmentViewList> {
  List<ViewAssignmentModel>? assignments;

  @override
  void initState() {
    super.initState();
    assignments = widget.assignments;
  }

  @override
  Widget build(BuildContext context) {
    return assignments == null
        ? const MindMorphLoadingIndicator()
        : ListView.builder(
            itemCount: widget.assignments.length,
            itemBuilder: ((context, index) {
              final assignment = assignments![index];

              return Card(
                color: boxtilecolor,
                semanticContainer: true,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 0.0),
                  leading: SizedBox(
                    width: 100,
                    // height: 200,
                    child: CourseThumbnail(courseId: assignment.courseId),
                  ),
                  title: Text(
                    assignment.title,
                    style: const TextStyle(color: titlecolor),
                  ),
                  subtitle: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '   ${assignment.createdAt}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewAssignment(
                                          assignment: assignment),
                                    ),
                                  ),
                              icon: const Icon(
                                Icons.visibility,
                                color: Color.fromARGB(255, 115, 240, 119),
                              )),
                          IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateAssignment(assignment: assignment),
                              ),
                            ),
                            icon: const Icon(Icons.edit_square,
                                color: Color.fromARGB(255, 105, 178, 238)),
                          ),
                          IconButton(
                            onPressed: () async {
                              //Send to Backend
                              final result =
                                  await AssignmentInstructorRepository
                                      .deleteAssignment(assignment.id);

                              setState(() {
                                assignments!.remove(assignment);
                              });

                              // Show Result in Snackbar
                              if (context.mounted) {
                                mindMorphSnackBar(
                                    context: context,
                                    message: result.message,
                                    isError: !result.isSuccess);
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 235, 115, 106),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          );
  }
}
