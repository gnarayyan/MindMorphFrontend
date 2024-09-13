import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import 'package:mindmorph/modules/profile/widgets/student_profile/quick_navigator.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminOptions extends StatelessWidget {
  const AdminOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        QuickNavigatorButton(
          labelText: 'Carousel Data',
          icon: Icons.view_carousel,
          onPressed: () => context.push('/admin/swiper'),
        ),
        5.heightBox,
        QuickNavigatorButton(
          labelText: 'Gamification Data',
          icon: Icons.games,
          onPressed: () => context.push('/gamification/add'),
        ),
        5.heightBox,
        QuickNavigatorButton(
          labelText: 'Logout',
          icon: FontAwesomeIcons.arrowRightFromBracket,
          onPressed: () {
            UserStorage.logout();
            context.go('/login');
          },
        ),
      ],
    );
  }
}
