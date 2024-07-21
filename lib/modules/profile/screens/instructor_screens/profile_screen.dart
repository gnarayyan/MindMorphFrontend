// import "package:flutter/material.dart";
// import "package:font_awesome_flutter/font_awesome_flutter.dart";
// import 'package:go_router/go_router.dart';
// import "/constants/color.dart";

// import "package:velocity_x/velocity_x.dart";

// class InstrcutorProfile extends StatefulWidget {
//   const InstrcutorProfile({super.key});

//   @override
//   State<InstrcutorProfile> createState() => _InstrcutorProfileState();
// }

// class _InstrcutorProfileState extends State<InstrcutorProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Instructor Profile'),
//         backgroundColor: Colors.black,
//         foregroundColor: featureColor,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(12),
//         color: themecolor,
//         width: context.screenWidth,
//         height: context.screenHeight,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SafeArea(
//                   child: Column(
//                 children: [
//                   20.heightBox,
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     height: 170,
//                     width: 350,
//                     decoration: BoxDecoration(
//                         color: backgrounghilghtcolor,
//                         borderRadius: BorderRadius.circular(40)),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 20.heightBox,
//                                 "Sobin rai "
//                                     .text
//                                     .size(20)
//                                     .align(TextAlign.left)
//                                     .bold
//                                     .color(titlecolor)
//                                     .make(),
//                                 "sobin@gmail.com"
//                                     .text
//                                     .size(15)
//                                     .semiBold
//                                     .align(TextAlign.left)
//                                     .color(
//                                         const Color.fromARGB(255, 88, 68, 132))
//                                     .make(),
//                                 20.heightBox,
//                                 const Icon(
//                                   Icons.person,
//                                   color: Color.fromARGB(255, 173, 178, 209),
//                                   size: 30,
//                                 )
//                               ],
//                             ),
//                             Column(children: [
//                               Container(
//                                 alignment: Alignment.centerRight,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: const Color.fromARGB(
//                                               255, 249, 249, 249)
//                                           .withOpacity(0.2),
//                                       blurRadius: 7,
//                                       offset: const Offset(0, 3),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipOval(
//                                   child: Image.network(
//                                     'https://insidetheperimeter.ca/wp-content/uploads/2015/11/Albert_einstein_by_zuzahin-d5pcbug-WikiCommons.jpg',
//                                     width: 75,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               10.heightBox,
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                       onPressed: () {
//                                         context.pop();
//                                       },
//                                       icon: const Icon(
//                                         FontAwesomeIcons.rightLeft,
//                                         color:
//                                             Color.fromARGB(255, 173, 178, 209),
//                                         size: 20,
//                                       ))
//                                 ],
//                               )
//                             ]),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   10.heightBox,
//                   const Divider(
//                     thickness: 0.5,
//                     color: titlecolor,
//                     endIndent: 20,
//                     indent: 20,
//                   ),
//                   35.heightBox,
//                   ListView(
//                     padding: const EdgeInsets.all(10),
//                     shrinkWrap: true,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(2),
//                         height: 70,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: listcolor,
//                         ),
//                         alignment: Alignment.center,
//                         child: ListTile(
//                           leading: const Icon(
//                             Icons.book,
//                             color: Color.fromARGB(255, 2, 91, 154),
//                             size: 30,
//                           ),
//                           title: const Text(
//                             'My courses ',
//                             style: TextStyle(color: titlecolor),
//                           ),
//                           trailing: IconButton(
//                               onPressed: () =>
//                                   context.push('/listInstructorcourse'),
//                               icon: const Icon(
//                                 Icons.navigate_next,
//                                 color: titlecolor,
//                               )),
//                         ),
//                       ),
//                       5.heightBox,
//                     ],
//                   )
//                 ],
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
