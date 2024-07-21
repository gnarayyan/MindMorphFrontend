import 'package:go_router/go_router.dart';

import '../../admin/swiper/admin_panel.dart';

List<RouteBase> adminRoutes = [
  GoRoute(
    path: '/admin/swiper',
    builder: (context, state) => const Adminpanel(),
  ),
];
