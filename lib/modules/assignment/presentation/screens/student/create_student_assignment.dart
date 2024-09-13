import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';

import '../../widgets/student/create_assignment_view.dart';

class CreateAssignmentScreen extends StatefulWidget {
  const CreateAssignmentScreen({super.key, required this.assignmentId});
  final int assignmentId;

  @override
  State<CreateAssignmentScreen> createState() => _AsignmnetState();
}

class _AsignmnetState extends State<CreateAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: CreateAssignmentView(assignmentId: widget.assignmentId),
        ),
      ),
    );
  }
}
