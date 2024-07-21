import 'dart:math';

import 'package:flutter/material.dart';

class ViewGamification extends StatefulWidget {
  const ViewGamification({super.key});

  @override
  State<ViewGamification> createState() => _ViewGamificationState();
}

class _ViewGamificationState extends State<ViewGamification> {
  final List<String> tips = [
    'Tip 1: Keep your code clean and organized.',
    'Tip 2: Use meaningful variable names.',
    'Tip 3: Comment your code where necessary.',
    'Tip 4: Write reusable code.',
    'Tip 5: Test your code thoroughly.',
  ];

  String selectedTip = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectRandomTip();
      _showTipsDialog(context);
    });
  }

  void _selectRandomTip() {
    final random = Random();
    selectedTip = tips[random.nextInt(tips.length)];
  }

  void _showTipsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Sharp corners
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 5, 46, 80),
            ),

            width:
                MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            height: MediaQuery.of(context).size.height *
                0.4, // 40% of screen height
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 5, 42, 72)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.1,
                  padding: const EdgeInsets.all(4.0),
                  child: const Text(
                    'Tips of the day',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      selectedTip,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 6, 62, 107)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('home button '),
        ],
      ),
    );
  }
}
