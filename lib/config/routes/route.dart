import 'package:go_router/go_router.dart';
import 'package:mindmorph/modules/auth/screens/signup.dart';
// import 'package:mindmorph/modules/home/presentation/screens/nav_bar.dart';
// import 'package:mindmorph/modules/profile/screens/acountdetaildemo.dart';
import 'package:mindmorph/modules/profile/screens/profile_drawer_screen.dart';
import '../../modules/gamification/presentation/screens/add_gamification_screen.dart';
import '../../modules/home/presentation/screens/home_screen.dart';
// import '/modules/home/button_nav_bar/presentation/navigation_root.dart';
import '../../modules/search/presentation/screens/searchpage.dart';
import '/modules/auth/login/presentation/screens/login.dart';
import 'admin.routes.dart';
import 'cart.routes.dart';
import 'chat.routes.dart';
import 'enrollment.routes.dart';
import 'intial_route.dart';
import 'profile.routes.dart';
import 'course.routes.dart';

final router = GoRouter(
  initialLocation: '/initial',
  routes: [
    initialRoute,
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      name:
          'signup', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/signup',
      builder: (context, state) => const Signup(),
    ),
    GoRoute(
      name:
          'home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) =>
          const HomeScreen(), //NavigationRootScreen(), //const Home(),
    ),
    GoRoute(
      name:
          'profile', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/profile',
      builder: (context, state) => const Account(),
    ),

    GoRoute(
      name:
          'search', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/search',
      builder: (context, state) => const Search(),
    ),
    // GoRoute(
    //     name:
    //         'video-player', // Optional, add name to your routes. Allows you navigate by name instead of path
    //     path: '/video-player',
    //     builder: (context, state) {
    //       String? courseId = state.uri.queryParameters['courseId'];

    //       // ignore: avoid_print
    //       print(
    //           'Passed video ID: $courseId  and its type: ${courseId.runtimeType}');

    //       return VideoPlayer(courseId: int.tryParse(courseId ?? '1') ?? 1);
    //     }),
    // GoRoute(
    //   name:
    //       'demopage', // Optional, add name to your routes. Allows you navigate by name instead of path
    //   path: '/demopage',
    //   builder: (context, state) => const DemoPage(),
    // ),

    //---------------------

    // GoRoute(
    //   name:
    //       'enrolledcourse', // Optional, add name to your routes. Allows you navigate by name instead of path
    //   path: '/enrolledcourse',
    //   builder: (context, state) => EnrolledCourse(),
    // ),

    // GoRoute(
    //   name:
    //       'playenrollcourse', // Optional, add name to your routes. Allows you navigate by name instead of path
    //   path: '/playenrollcourse',
    //   builder: (context, state) => const Playenrollcourse(),
    // ),

    ...profileRoutes,
    ...courseRoutes,
    ...cartRoutes,
    ...enrollmentRoutes,
    ...chatRoutes,
    ...adminRoutes,
    GoRoute(
      path: '/gamification',
      builder: (context, state) => const GamificationScreen(),
    ),
  ],
);
