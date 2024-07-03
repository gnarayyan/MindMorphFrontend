// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/material.dart';
// import '../../video_player/models/course_model.dart';
// import '../../video_player/data/providers/course_provider.dart';
// import '../commonwidget/ratingbar.dart';
// import '/constants/color.dart';
// import '/constants/fonts.dart';
// import 'package:velocity_x/velocity_x.dart';

// class VideoPlayerCopied extends StatefulWidget {
//   final int courseId;
//   const VideoPlayerCopied({super.key, required this.courseId});

//   @override
//   State<VideoPlayerCopied> createState() => _VideoPlayerCopiedState();
// }

// // ignore: camel_case_types
// class _VideoPlayerCopiedState extends State<VideoPlayerCopied> {
//   late CustomVideoPlayerController _customVideoPlayerController;
//   bool isvisible = true;
//   String toggle = 'Showless';
//   String cmnt = 'showles';

//   @override
//   void initState() {
//     super.initState();
//     initializevideoplayerCopied();
//   }

//   @override
//   void dispose() {
//     _customVideoPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<CourseModel>(
//       future: getCourse(widget.courseId),
//       builder: (BuildContext context, AsyncSnapshot<CourseModel> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Show a loading indicator while waiting for the data
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           // Show an error message if the data couldn't be fetched
//           return Scaffold(
//             body: Center(
//               child: Text('Error: ${snapshot.error}'),
//             ),
//           );
//         } else {
//           // Data has been successfully fetched, display the course details
//           CourseModel courseModel = snapshot.data!;
//           return Scaffold(
//             body: Container(
//               color: themecolor,
//               child: SafeArea(
//                 child: Column(children: [
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   CustomVideoPlayer(
//                       customVideoPlayerController:
//                           _customVideoPlayerController),
//                   5.heightBox,
//                   Container(
//                     decoration: BoxDecoration(boxShadow: [
//                       BoxShadow(
//                         color: const Color.fromARGB(255, 249, 249, 249)
//                             .withOpacity(0.2),
//                         blurRadius: 7,
//                         offset: const Offset(0, 3),
//                       ),
//                     ], color: themecolor),
//                     height: MediaQuery.of(context).size.height * 0.15,
//                     child: Column(
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Title(
//                             color: Colors.white,
//                             child: const Text(
//                               'courseModel.title',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         10.heightBox,
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             'Rating'
//                                 .text
//                                 .size(16)
//                                 .fontFamily(semibold)
//                                 .color(subtexColor)
//                                 .make(),
//                             const SizedBox(width: 80),
//                             ratingbar(20, 0.8, 5),
//                             const SizedBox(width: 60),
//                             'Rs 1000'.text.color(Colors.amber).make(),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: 'By:morpha Team'
//                                   .text
//                                   .size(16)
//                                   .fontFamily(regular)
//                                   .color(subtexColor)
//                                   .make(),
//                             ),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             20.heightBox,
//                             const Icon(
//                               Icons.language,
//                               color: subtexColor,
//                             ),
//                             'English'.text.size(14).color(subtexColor).make(),
//                             20.widthBox,
//                             Container(
//                               alignment: Alignment.center,
//                               height: 30,
//                               width: 120,
//                               decoration: BoxDecoration(
//                                   color: boxtilecolor,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: 'participants:100+'
//                                   .text
//                                   .color(subtexColor)
//                                   .size(14)
//                                   .make(),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   10.heightBox,
//                   Expanded(
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           5.heightBox,
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: boxtilecolor,
//                             ),
//                             height: MediaQuery.of(context).size.height * 0.35,
//                             width: MediaQuery.of(context).size.width * 0.87,
//                             child: Column(
//                               children: [
//                                 5.heightBox,
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Title(
//                                       color: const Color.fromARGB(
//                                           255, 255, 255, 255),
//                                       child: const Text(
//                                         'Curriculum',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontFamily: regular,
//                                             color: featureColor),
//                                       )),
//                                 ),
//                                 10.heightBox,
//                                 Column(
//                                   children: [
//                                     '# Introduction of flutter '
//                                         .text
//                                         .color(subtexColor)
//                                         .size(16)
//                                         .make(),
//                                     10.heightBox,
//                                     '# Crossplatform vs Native '
//                                         .text
//                                         .color(subtexColor)
//                                         .size(16)
//                                         .make(),
//                                     10.heightBox,
//                                     '# Flutter Setup - Overviews '
//                                         .text
//                                         .color(subtexColor)
//                                         .size(16)
//                                         .make(),
//                                     10.heightBox,
//                                     '# Crossplatform vs Native '
//                                         .text
//                                         .color(subtexColor)
//                                         .size(16)
//                                         .make(),
//                                     10.heightBox,
//                                     '# Dart and its proporties '
//                                         .text
//                                         .color(subtexColor)
//                                         .size(16)
//                                         .make(),
//                                     10.heightBox,
//                                     '# first flutter App '
//                                         .text
//                                         .color(subtexColor)
//                                         .size(16)
//                                         .make(),
//                                     10.heightBox,
//                                     '# about this course '
//                                         .text
//                                         .color(subtexColor)
//                                         .size(16)
//                                         .make(),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           20.heightBox,
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               // Padding(padding: EdgeInsets.all(20)),
//                               GestureDetector(
//                                 onTap: () {
//                                   showModalBottomSheet(
//                                       backgroundColor: boxtilecolor,
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return SizedBox(
//                                           height: 600,
//                                           child: Center(
//                                             child: Column(
//                                               children: [
//                                                 80.heightBox,
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                       color: themecolor,
//                                                       border: Border.all(
//                                                           width: 1,
//                                                           color: Colors.white),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               30)),
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height *
//                                                       0.3,
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.8,
//                                                   child: Column(
//                                                     children: [
//                                                       40.heightBox,
//                                                       Align(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         child: Row(
//                                                           children: [
//                                                             55.widthBox,
//                                                             'Course name:'
//                                                                 .text
//                                                                 .size(16)
//                                                                 .color(
//                                                                     titlecolor)
//                                                                 .fontFamily(
//                                                                     bold)
//                                                                 .make(),
//                                                             const SizedBox(
//                                                                 width:
//                                                                     5), // Add some space between the two texts
//                                                             'Flutter Course'
//                                                                 .text // Second text widget
//                                                                 .size(12)
//                                                                 .color(
//                                                                     featureColor)
//                                                                 .fontFamily(
//                                                                     bold)
//                                                                 .make(),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       10.heightBox,
//                                                       Align(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             55.widthBox,
//                                                             'Price:'
//                                                                 .text
//                                                                 .size(16)
//                                                                 .color(
//                                                                     titlecolor)
//                                                                 .fontFamily(
//                                                                     bold)
//                                                                 .make(),
//                                                             const SizedBox(
//                                                                 width:
//                                                                     5), // Add some space between the two texts
//                                                             '800'
//                                                                 .text // Second text widget
//                                                                 .size(12)
//                                                                 .color(
//                                                                     featureColor)
//                                                                 .fontFamily(
//                                                                     bold)
//                                                                 .make(),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       10.heightBox,
//                                                       Align(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         child: Row(
//                                                           children: [
//                                                             55.widthBox,
//                                                             'Date of purchase:'
//                                                                 .text
//                                                                 .size(16)
//                                                                 .color(
//                                                                     titlecolor)
//                                                                 .fontFamily(
//                                                                     bold)
//                                                                 .make(),
//                                                             const SizedBox(
//                                                                 width:
//                                                                     5), // Add some space between the two texts
//                                                             'May 4,2024'
//                                                                 .text // Second text widget
//                                                                 .size(12)
//                                                                 .color(
//                                                                     featureColor)
//                                                                 .fontFamily(
//                                                                     bold)
//                                                                 .make(),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       10.heightBox,
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 30.heightBox,
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceEvenly,
//                                                   children: [
//                                                     ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                                 backgroundColor:
//                                                                     themecolor,
//                                                                 shape:
//                                                                     RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               20),
//                                                                 ),
//                                                                 padding: const EdgeInsets
//                                                                     .symmetric(
//                                                                     vertical:
//                                                                         10,
//                                                                     horizontal:
//                                                                         50)),
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: const Text(
//                                                           'OK',
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.white),
//                                                         )),
//                                                     ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                                 backgroundColor:
//                                                                     themecolor,
//                                                                 shape:
//                                                                     RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               20),
//                                                                 ),
//                                                                 padding: const EdgeInsets
//                                                                     .symmetric(
//                                                                     vertical:
//                                                                         10,
//                                                                     horizontal:
//                                                                         30)),
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: const Text(
//                                                           'Confirm',
//                                                           style: TextStyle(
//                                                               fontSize: 14,
//                                                               color:
//                                                                   Colors.white),
//                                                         )),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: themecolor,
//                                       border: Border.all(
//                                           width: 1, color: Colors.white),
//                                       borderRadius: BorderRadius.circular(20)),
//                                   alignment: Alignment.centerLeft,
//                                   // ignore: sort_child_properties_last
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: 'Buy'
//                                         .text
//                                         .fontFamily(regular)
//                                         .color(Colors.white)
//                                         .make(),
//                                   ),
//                                   height: 60,
//                                   width: 100,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: themecolor,
//                                       border: Border.all(
//                                           width: 1, color: Colors.white),
//                                       borderRadius: BorderRadius.circular(20)),
//                                   alignment: Alignment.centerLeft,
//                                   // ignore: sort_child_properties_last
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: 'Add to Cart'
//                                         .text
//                                         .fontFamily(regular)
//                                         .color(Colors.white)
//                                         .make(),
//                                   ),
//                                   height: 60,
//                                   width: 100,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           10.heightBox,
//                           const Divider(
//                             thickness: 0.8,
//                             color: Colors.white,
//                             endIndent: 40,
//                             indent: 40,
//                           ),
//                           20.heightBox,
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isvisible = !isvisible;
//                                   cmnt = isvisible ? 'showless' : 'Comments';
//                                 });
//                               },
//                               style: ButtonStyle(
//                                 side: MaterialStateProperty.resolveWith<
//                                     BorderSide>(
//                                   (Set<MaterialState> states) {
//                                     return const BorderSide(
//                                       color: Color.fromARGB(
//                                           255, 255, 255, 255), // Border color
//                                       width: 1, // Border width
//                                     );
//                                   },
//                                 ),
//                               ),
//                               child: Text(cmnt,
//                                   textAlign: TextAlign.start,
//                                   style: const TextStyle(
//                                     fontFamily: regular,
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                   )),
//                             ),
//                           ),
//                           Visibility(
//                             visible: isvisible,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: boxtilecolor,
//                               ),
//                               height: 350,
//                               width: 350,
//                               child: const Column(
//                                 children: [],
//                               ),
//                             ),
//                           ),
//                           // Row(
//                           //   children: [
//                           //     Align(
//                           //       alignment: Alignment.topLeft,
//                           //       child: TextButton(
//                           //         onPressed: () {
//                           //           setState(() {
//                           //             isvisible = !isvisible;
//                           //             toggle =
//                           //                 isvisible ? 'showless' : 'Description:-';
//                           //           });
//                           //         },
//                           //         style: ButtonStyle(
//                           //           side:
//                           //               MaterialStateProperty.resolveWith<BorderSide>(
//                           //             (Set<MaterialState> states) {
//                           //               return BorderSide(
//                           //                 color: const Color.fromARGB(
//                           //                     255, 255, 255, 255), // Border color
//                           //                 width: 1, // Border width
//                           //               );
//                           //             },
//                           //           ),
//                           //         ),
//                           //         child: Text(toggle,
//                           //             textAlign: TextAlign.start,
//                           //             style: TextStyle(
//                           //               fontFamily: regular,
//                           //               fontSize: 14,
//                           //               color: Colors.white,
//                           //             )),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),

//                           Visibility(
//                             visible: isvisible,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: boxtilecolor,
//                               ),
//                               height: 350,
//                               width: 350,
//                               child: const Column(
//                                 children: [],
//                               ),
//                             ),
//                           ),
//                           // 10.heightBox,
//                           // divider,
//                           // 10.heightBox,
//                           // 10.heightBox,
//                           // divider,
//                         ],
//                       ),
//                     ),
//                   )
//                 ]),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   void initializevideoplayerCopied() {
//     CachedVideoPlayerController _CachedVideoPlayerController;
//     _CachedVideoPlayerController = CachedVideoPlayerController.network(
//         'https://www.w3schools.com/html/mov_bbb.mp4')
//       ..initialize().then((value) {
//         setState(() {});
//       });
//     _customVideoPlayerController = CustomVideoPlayerController(
//         context: context, videoPlayerController: _CachedVideoPlayerController);
//   }
// }
