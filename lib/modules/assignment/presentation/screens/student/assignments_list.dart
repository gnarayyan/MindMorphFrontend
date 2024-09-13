import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/widgets/app_bar.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../../data/repository/assignemnt_student_repository.dart';
import '../../../models/student/view_assignments_model.dart';
import '../../widgets/student/all_assignments_view.dart';
import '/constants/color.dart';

class StudentAssignmentList extends StatelessWidget {
  const StudentAssignmentList({super.key});
  // AssignmentInstructorRepository

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor,
      appBar: MindMorphAppBar(
        title: 'Your Assignments',
        actions: [
          IconButton(
              onPressed: () => context.go('/'), icon: const Icon(Icons.home))
        ],
      ),
      body: FutureBuilder<ViewAssignmentModel>(
          future: AssignmentStudentRepository.getAllAssignments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MindMorphLoadingIndicator();
            } else if (snapshot.hasError) {
              return const ErrorPage(message: 'Server Error');
            } else if (!snapshot.hasData || snapshot.data == {}) {
              return const ErrorPage(message: 'No assignment provided yet');
            } else {
              final assignments = snapshot.data!;

              return AllAssignmentsView(allAssignments: assignments);
            }
          }),
    );
  }
}
