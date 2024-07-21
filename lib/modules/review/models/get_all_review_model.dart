// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import '../../auth/login/data/local_storage/user_storage.dart';

class ReviewModel {
  List<Review> reviews;
  bool isEnrolled;
  bool hasReviewed;
  bool isUserAuthor;

  ReviewModel({
    required this.reviews,
    required this.isEnrolled,
    required this.hasReviewed,
    required this.isUserAuthor,
  });

  factory ReviewModel._fromJson(Map<String, dynamic> json) => ReviewModel(
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        isEnrolled: json["isEnrolled"],
        hasReviewed: json["hasReviewed"],
        isUserAuthor: json["isUserAuthor"],
      );
  static Future<ReviewModel> fromResponse(Response response) async {
    final jsonObject = json.decode(response.body);
    // if (response.statusCode != 200) {
    //   return ReviewModel(
    //       reviews: [],
    //       isEnrolled: false,
    //       isSuccess: false,
    //       message: 'Failed to fetch');
    // }
    final reviewModel = ReviewModel._fromJson(jsonObject);
    await sort(reviewModel.reviews);
    return reviewModel;
  }

  // Sort reviews so that reviews by a specific userId (e.g., userId = 28) appear at the top
  static Future<void> sort(List<Review> reviews) async {
    int specificUserId = await UserStorage.userId;
    reviews.sort((a, b) {
      if (a.userId == specificUserId) {
        return -1; // Place review with specific userId at the beginning
      } else if (b.userId == specificUserId) {
        return 1; // Place review with specific userId after all others
      } else {
        return 0; // Leave other reviews in their current order
      }
    });
  }

  Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "isEnrolled": isEnrolled,
        "hasReviewed": hasReviewed,
      };
}

class Review {
  int id;
  int courseId;
  int userId;
  String content;
  double rating;
  String updatedAt;
  User user;
  List<Reply> replies;

  Review({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.content,
    required this.rating,
    required this.updatedAt,
    required this.user,
    required this.replies,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        courseId: json["courseId"],
        userId: json["userId"],
        content: json["content"],
        rating: json["rating"]?.toDouble(),
        updatedAt: json["updatedAt"],
        user: User.fromJson(json["user"]),
        replies:
            List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "userId": userId,
        "content": content,
        "rating": rating,
        "updatedAt": updatedAt,
        "user": user.toJson(),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}

class Reply {
  int id;
  int userId;
  String content;
  DateTime updatedAt;
  int reviewId;
  User user;

  Reply({
    required this.id,
    required this.userId,
    required this.content,
    required this.updatedAt,
    required this.reviewId,
    required this.user,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        userId: json["userId"],
        content: json["content"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        reviewId: json["reviewId"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "content": content,
        "updatedAt": updatedAt.toIso8601String(),
        "reviewId": reviewId,
        "user": user.toJson(),
      };
}

class User {
  int id;
  String fullName;
  String avatar;

  User({
    required this.id,
    required this.fullName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "avatar": avatar,
      };
}
