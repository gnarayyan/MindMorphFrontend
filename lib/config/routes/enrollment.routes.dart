import 'package:go_router/go_router.dart';
import '../../modules/enrollment/presentation/screens/purchased_courses_screen.dart';

List<RouteBase> enrollmentRoutes = [
  GoRoute(
    path: '/enrollment/purchased-courses',
    builder: (context, state) => const PurchasedCoursesScreen(),
  ),
];
