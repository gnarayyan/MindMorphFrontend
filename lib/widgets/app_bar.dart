import 'package:flutter/material.dart';
import '/constants/constants.dart';

class MindMorphAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MindMorphAppBar({super.key, required this.title, this.actions});
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: boxtilecolor,
      iconTheme: const IconThemeData(color: titlecolor),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: titlecolor,
          fontFamily: bold,
          fontSize: 16,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
