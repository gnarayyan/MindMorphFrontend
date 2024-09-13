import 'package:flutter/material.dart';
import '../../../models/student/view_assignments_model.dart';
import 'assignment_view_list.dart';

class AllAssignmentsView extends StatelessWidget {
  const AllAssignmentsView({super.key, required this.allAssignments});
  final ViewAssignmentModel allAssignments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // New Assignments
        if (allAssignments.newAssignments.isNotEmpty)
          const AssignmentSection(label: 'New Assignments', color: Colors.blue),
        if (allAssignments.newAssignments.isNotEmpty)
          StudentAssignmentViewList(assignments: allAssignments.newAssignments),

        // Due Assignments
        if (allAssignments.dueAssignments.isNotEmpty)
          const AssignmentSection(label: 'Due Assignments', color: Colors.red),
        if (allAssignments.dueAssignments.isNotEmpty)
          StudentAssignmentViewList(assignments: allAssignments.dueAssignments),

        // Pending Assignments
        if (allAssignments.pendingAssignments.isNotEmpty)
          const AssignmentSection(
              label: 'Pending Assignments', color: Colors.purple),
        if (allAssignments.pendingAssignments.isNotEmpty)
          StudentAssignmentViewList(
              assignments: allAssignments.pendingAssignments),

        // Returned Assignments
        if (allAssignments.returnedAssignments.isNotEmpty)
          const AssignmentSection(
              label: 'Returned Assignments', color: Colors.green),
        if (allAssignments.returnedAssignments.isNotEmpty)
          StudentAssignmentViewList(
              assignments: allAssignments.returnedAssignments),
      ],
    );
  }
}

class AssignmentSection extends StatelessWidget {
  const AssignmentSection(
      {super.key, required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
              color: color, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
