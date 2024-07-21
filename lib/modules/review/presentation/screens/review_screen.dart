import 'package:flutter/material.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../data/repositories/review_repository.dart';
import '../../models/get_all_review_model.dart';
import '../widgets/review_view.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});
  final int courseId = 27;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<ReviewModel>(
            future: ReviewRepository.getAllReviews(courseId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MindMorphLoadingIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const ErrorPage(message: 'No data available');
              } else {
                final result = snapshot.data!;

                return ReviewView(
                  reviewModel: result,
                  courseId: courseId,
                  // authorId: authorId
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
