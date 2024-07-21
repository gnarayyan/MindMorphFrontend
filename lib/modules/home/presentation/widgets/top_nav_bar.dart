import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/constants/constants.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgrounghilghtcolor,
          border: Border.all(
            color: themecolor,
          )),
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
            color: titlecolor,
            onPressed: () => context.push('/profile'),
            icon: const Icon(Icons.person_rounded)),
        IconButton(
          color: titlecolor,
          onPressed: () => context.push('/chat/home'),
          icon: const Icon(Icons.message),
        ),
        IconButton(
          color: titlecolor,
          onPressed: () => context.push('/assignment/add'),
          icon: const Icon(Icons.games),
        ),
        IconButton(
          color: titlecolor,
          onPressed: () => context.push('/gamification'),
          icon: const Icon(Icons.assignment),
        ),
        IconButton(
          color: titlecolor,
          onPressed: () => context.push('/cart'),
          icon: const Icon(Icons.shopping_cart),
        ),
        IconButton(
          color: titlecolor,
          onPressed: () => context.push('/search'),
          icon: const Icon(Icons.search),
        ),
      ]),
    );
  }
}
