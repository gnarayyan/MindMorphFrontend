import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import 'package:mindmorph/modules/profile/widgets/student_profile/quick_navigator.dart';
import 'package:velocity_x/velocity_x.dart';

class InstructorOptions extends StatelessWidget {
  const InstructorOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        QuickNavigatorButton(
          labelText: 'My Courses',
          icon: Icons.movie,
          onPressed: () => context.push('/listInstructorcourse'),
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
