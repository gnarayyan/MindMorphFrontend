import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../../data/provider/get_thumbnail_url.dart';
import '../../../models/student/view_assignments_model.dart';
import '../../screens/student/create_student_assignment.dart';

class StudentAssignmentViewList extends StatefulWidget {
  const StudentAssignmentViewList({super.key, required this.assignments});
  // final ViewAssignmentModel assignments;
  final List<Assignment> assignments;

  @override
  State<StudentAssignmentViewList> createState() =>
      _StudentAssignmentViewListState();
}

class _StudentAssignmentViewListState extends State<StudentAssignmentViewList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.assignments.length,
      itemBuilder: ((context, index) {
        final assignment = widget.assignments[index];

        return Card(
          color: boxtilecolor,
          semanticContainer: true,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            leading: SizedBox(
              width: 100,
              // height: 200,
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                    'http://$NODE_SERVER/${assignment.user.avatar}'),
              ),
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
                  '   ${assignment.deadline}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Row(
                  children: [
                    // IconButton(
                    //     onPressed: () {}

                    //     // => Navigator.of(context).push(
                    //     //       MaterialPageRoute(
                    //     //         builder: (context) => ViewAssignment(
                    //     //             assignment: assignment),
                    //     //       ),
                    //     //     )

                    //     ,
                    //     icon: const Icon(
                    //       Icons.visibility,
                    //       color: Color.fromARGB(255, 115, 240, 119),
                    //     )),

                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => CreateAssignmentScreen(
                                assignmentId: assignment.id)
                            // UpdateAssignment(assignment: assignment),
                            ),
                      ),
                      icon: const Icon(Icons.edit_square,
                          color: Color.fromARGB(255, 105, 178, 238)),
                    )
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

class UserThumbnail extends StatefulWidget {
  const UserThumbnail({super.key, required this.courseId});
  final int courseId;

  @override
  State<UserThumbnail> createState() => _UserThumbnailState();
}

class _UserThumbnailState extends State<UserThumbnail> {
  String? thumbnailUrl;

  void fetchThumbnail() async {
    final url = await getThumbnailUrl(widget.courseId);
    setState(() {
      thumbnailUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return thumbnailUrl == null
        ? const MindMorphLoadingIndicator()
        : Image.network(
            'http://$COURSE_SERVER/${thumbnailUrl!}',
            fit: BoxFit.cover,
          );
  }
}
