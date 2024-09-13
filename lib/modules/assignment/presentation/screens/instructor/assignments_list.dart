import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/widgets/app_bar.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import '../../../data/repository/assignemnt_instructor_repository.dart';

import '../../../models/instructor/view_assignment_model.dart';
import '../../widgets/instructor/assignment_view_list.dart';
import '/constants/color.dart';

class InstructorAssignmentList extends StatelessWidget {
  const InstructorAssignmentList({super.key});
  // AssignmentInstructorRepository

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor,
      appBar: MindMorphAppBar(
        title: 'Created Assignments',
        actions: [
          IconButton(
              onPressed: () => context.go('/'), icon: const Icon(Icons.home))
        ],
      ),
      body: FutureBuilder<List<ViewAssignmentModel>>(
          future: AssignmentInstructorRepository.getCreatedAssignments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MindMorphLoadingIndicator();
            } else if (snapshot.hasError) {
              return const ErrorPage(message: 'Server Error');
            } else if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const ErrorPage(message: 'No assignment provided yet');
            } else {
              final assignments = snapshot.data!;

              return AssignmentViewList(assignments: assignments);
            }
          }),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: titlecolor,
        onPressed: () => context.push('/assignment/add'),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
