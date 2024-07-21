import 'package:go_router/go_router.dart';

import '../../modules/cart/presentation/screens/cart_screen.dart';
import '../../modules/review/presentation/screens/review_screen.dart';
// import '../../modules/payment/payment_via_web.dart';

List<RouteBase> cartRoutes = [
  GoRoute(
    name:
        'cart', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/cart',
    builder: (context, state) => const CartScreen(),
  ),
  GoRoute(
    path: '/review',
    builder: (context, state) => const ReviewScreen(),
  ),
];
