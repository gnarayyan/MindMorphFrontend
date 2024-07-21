import '../../models/create_response_model.dart';
import '../../models/get_all_review_model.dart';
import '../providers/review_provider.dart';

class ReviewRepository {
  static Future<ReviewModel> getAllReviews(int courseId) async {
    final response = await ReviewProvider.getAllReviews(courseId);

    final reviews = await ReviewModel.fromResponse(response);

    return reviews;
  }

  static Future<ResponseModel<Review>> addReview(String body) async {
    final response = await ReviewProvider.addReview(body);

    ResponseModel<Review> result =
        ResponseModel.fromResponse(response, Review.fromJson);

    return result;
  }
}
