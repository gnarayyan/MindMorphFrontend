import 'package:go_router/go_router.dart';
import '../../modules/assignment/presentation/screens/instructor/create_assignment.dart';
import '../../modules/certificate/presentation/screens/completed_courses_screen.dart';
import '../../modules/profile/screens/instructor_screens/course_list_screen.dart';
import '../../modules/course_player/coursevideo.dart';

List<RouteBase> profileRoutes = [
  GoRoute(
    name: 'listInstructorcourse',
    path: '/listInstructorcourse',
    builder: (context, state) => const ListInstructorCourse(),
  ),
  GoRoute(
    name: 'Instructpage',
    path: '/Instructpage',
    builder: (context, state) => const Instructpage(),
  ),

  //Student Routes
  GoRoute(
    path: '/certificate/courses-completed',
    builder: (context, state) => const CompletedCoursesScreen(),
  ),

  GoRoute(
    path: '/assignment/add',
    builder: (context, state) => const AddAssignment(),
  ),
];
