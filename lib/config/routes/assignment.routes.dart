import 'package:go_router/go_router.dart';

import '../../modules/assignment/presentation/screens/instructor/assignments_list.dart';
import '../../modules/assignment/presentation/screens/student/assignments_list.dart';

List<RouteBase> assignmentRoutes = [
  GoRoute(
    path: '/assignments/instructor/list',
    builder: (context, state) => const InstructorAssignmentList(),
  ),
  GoRoute(
    path: '/assignments/student/list',
    builder: (context, state) => const StudentAssignmentList(),
  ),
];
