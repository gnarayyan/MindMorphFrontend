import 'package:go_router/go_router.dart';

import '../../admin/swiper/presentation/screens/swiper_screen.dart';

List<RouteBase> adminRoutes = [
  GoRoute(
    path: '/admin/swiper',
    builder: (context, state) => const SwiperScreen(),
  ),
];
