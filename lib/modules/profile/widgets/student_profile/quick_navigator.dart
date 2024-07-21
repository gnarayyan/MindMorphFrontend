import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';

class QuickNavigatorButton extends StatelessWidget {
  const QuickNavigatorButton(
      {super.key, required this.labelText, this.onPressed, required this.icon});
  final String labelText;
  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 70,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: listcolor,
      ),
      alignment: Alignment.center,
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 2, 91, 154),
          size: 30,
        ),
        title: Text(
          labelText,
          style: const TextStyle(color: titlecolor),
        ),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.navigate_next,
              color: titlecolor,
            )),
      ),
    );
  }
}
