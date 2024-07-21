import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/widgets/snackbar.dart';

import '../../data/repositories/review_repository.dart';
import '../../models/create_review_model.dart';
import '../../models/get_all_review_model.dart';
import 'review_item.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({
    super.key,
    required this.reviewModel,
    required this.courseId,
    // required this.authorId
  });
  final ReviewModel reviewModel;
  final int courseId;
  // final int authorId;

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  late List<Review> reviews;
  late bool isUserEnrolled;
  late bool hasReviewed;
  // = [
  //   CourseReview(
  //       id: '1',
  //       content: 'Nice Product. I loved it',
  //       username: 'Narayan Gauatm',
  //       replies: [
  //         ReviewReply(
  //           id: '1',
  //           username: 'Sobin Rai',
  //           content: 'Thank You so mush. It means a lot to me',
  //         )
  //       ]),
  //   CourseReview(
  //     id: '2',
  //     content: 'What are you seeing?',
  //     username: 'Sooraj Ydv',
  //     replies: [
  //       // ReviewReply(
  //       //   id: '2',
  //       //   username: 'Sobin Rai',
  //       //   content: 'Sorry yr! I don\'t get you',
  //       // )
  //     ],
  //   )
  // ];

  final _reviewController = TextEditingController();

  final List<String> dummyUsernames = [
    'sobin',
    'gobin',
    'narayn ',
    'suraj',
  ];

  String getRandomUsername() {
    final random = Random();
    return dummyUsernames[random.nextInt(dummyUsernames.length)];
  }

  double _courseRatingByUser = 5;

  @override
  void initState() {
    super.initState();
    reviews = widget.reviewModel.reviews;
    isUserEnrolled = widget.reviewModel.isEnrolled;
    hasReviewed = widget.reviewModel.hasReviewed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isUserEnrolled && !hasReviewed)
          Card(
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: _courseRatingByUser,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    unratedColor: Colors.grey,
                    updateOnDrag: true,
                    itemPadding:
                        const EdgeInsets.symmetric(horizontal: 0.1 * 3),
                    itemBuilder: (context, index) {
                      final isUpdated = index < _courseRatingByUser;
                      return Icon(isUpdated ? Icons.star : Icons.star_border,
                          color: isUpdated ? Colors.amber : Colors.grey);
                    },
                    onRatingUpdate: (rating) {
                      _courseRatingByUser = rating;
                    },
                  ),
                  TextField(
                    controller: _reviewController,
                    style: const TextStyle(color: featureColor),
                    decoration: InputDecoration(
                      hintText: 'Write a review...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          // Validate Reply Text
                          final reviewText = _reviewController.text.trim();

                          String errorMessage = reviewText.length < 10
                              ? 'Review must have at least 10 characters'
                              : reviewText.length > 500
                                  ? 'Review must have at max 500 characters'
                                  : '';
                          if (errorMessage.isNotEmpty) {
                            mindMorphSnackBar(
                                context: context,
                                message: errorMessage,
                                isError: true);
                            return;
                          }

                          // Send Data to Backend
                          final reviewData = CreateReviewModel(
                              content: reviewText,
                              courseId: widget.courseId,
                              rating: _courseRatingByUser);

                          final result = await ReviewRepository.addReview(
                              await reviewData.toRequestBody());

                          if (result.isFailure && context.mounted) {
                            mindMorphSnackBar(
                                context: context,
                                message: result.message,
                                isError: result.isFailure);
                            return;
                          }

                          // Clear TextField
                          _reviewController.clear();

                          // Get ReviewModel from response
                          final sentReviewModel = result.data;

                          // Update replyList
                          setState(() {
                            reviews.add(sentReviewModel!);
                            // ReviewModel.sort(reviews);
                            // reviews.insert(0, sentReviewModel!);
                            hasReviewed = true;
                          });
                          // if (_reviewController.text.isNotEmpty) {
                          //   setState(() {
                          //     reviews.add(
                          //       Review(
                          //         id: DateTime.now()
                          //             .millisecondsSinceEpoch
                          //             .toString(),
                          //         username: getRandomUsername(),
                          //         content: _reviewController.text,
                          //         replies: [],
                          //       ),
                          //     );
                          //     _reviewController.clear();
                          //   });
                          // }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return ReviewWidget(
              review: reviews[index],
              courseId: widget.courseId,
              isUserAuthor: widget.reviewModel.isUserAuthor,
              // authorId: widget.authorId
              // onReplyAdded: (replyContent) {
              //   setState(() {
              //     reviews[index].replies.add(
              //           ReviewReply(
              //             id: DateTime.now().millisecondsSinceEpoch.toString(),
              //             username: getRandomUsername(),
              //             content: replyContent,
              //           ),
              //         );
              //   });
              // },
            );
          },
        ),
      ],
    );
  }
}
