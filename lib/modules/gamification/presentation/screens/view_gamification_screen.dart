import 'package:flutter/material.dart';
import 'package:mindmorph/constants/urls.dart';
import '../../data/repository/gamification_repository.dart';
import '../../models/view_game_data.dart';

// import '../../repositories/gamification_repository.dart';

void showGameDialog({
  required BuildContext context,
}) {
  Future<void> fetchAndShowDialog() async {
    final ViewGameModel data = await GamificationRepository.getGameData();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Sharp corners
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 5, 46, 80),
                ),
                // width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 5, 42, 72),
                        ),
                        // width: MediaQuery.of(context).size.width * 0.9,
                        // height: MediaQuery.of(context).size.width * 0.1,
                        padding: const EdgeInsets.all(4.0),
                        child: const Center(
                          child: Text(
                            'Tips of the day',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 224, 224, 52),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.text,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (data.imageUrl != null)
                                Image.network(
                                    'http://$NODE_SERVER/${data.imageUrl}'),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 6, 62, 107),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await fetchAndShowDialog();
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 6, 62, 107),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  fetchAndShowDialog();
}






// void showGameDialog(
//     {required BuildContext context,
//     required ViewGameModel data,
//     required void Function() nextGame}) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20), // Sharp corners
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: const Color.fromARGB(255, 5, 46, 80),
//               ),
//               width: MediaQuery.of(context).size.width * 0.8,
//               height: MediaQuery.of(context).size.height * 0.8,
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: const Color.fromARGB(255, 5, 42, 72),
//                     ),
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     height: MediaQuery.of(context).size.width * 0.1,
//                     padding: const EdgeInsets.all(4.0),
//                     child: const Text(
//                       'Tips of the day',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 224, 224, 52),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             data.text,
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Image.network(data.imageUrl)
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         TextButton(
//                           style: TextButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 6, 62, 107),
//                           ),
//                           onPressed: nextGame,
//                           child: const Text(
//                             'Next',
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                         TextButton(
//                           style: TextButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 6, 62, 107),
//                           ),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text(
//                             'Close',
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
