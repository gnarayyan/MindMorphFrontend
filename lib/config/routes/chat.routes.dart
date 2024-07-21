import 'package:go_router/go_router.dart';
import '../../modules/chat/presentation/screens/conversation_list_screen.dart';
import '../../modules/chat/presentation/_sobinmessage_screen.dart';

List<RouteBase> chatRoutes = [
  GoRoute(
    path: '/chat/home',
    builder: (context, state) => const ChatHomeScreen(),
  ),
  GoRoute(
    path: '/chat/message',
    builder: (context, state) => const MessageScreen(),
  ),
];
