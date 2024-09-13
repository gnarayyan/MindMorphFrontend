import 'package:flutter/material.dart';
import '../widgets/game_data_form.dart';
import '/constants/constants.dart';
import '/widgets/app_bar.dart';

class AddGamificationDataScreen extends StatelessWidget {
  const AddGamificationDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MindMorphAppBar(title: 'Add Gamification Data'),
      backgroundColor: boxtilecolor,
      body: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: boxtilecolor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const GameDataForm(),
      ),
    );
  }
}
