// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

class CartResponseModel {
  int id;
  int courseId;
  String updatedAt;
  Course course;

  CartResponseModel({
    required this.id,
    required this.courseId,
    required this.updatedAt,
    required this.course,
  });

  factory CartResponseModel._fromJson(Map<String, dynamic> json) =>
      CartResponseModel(
        id: json["id"],
        courseId: json["courseId"],
        updatedAt: json["craetedAt"],
        course: Course._fromJson(json["course"]),
      );
}

class Course {
  double price;
  double discountPercent;
  Author author;

  Course(
      {required this.price,
      required this.author,
      required this.discountPercent});

  factory Course._fromJson(Map<String, dynamic> json) => Course(
      price: (json["price"] * 100) / 100,
      author: Author._fromJson(json["author"]),
      discountPercent: (json["discountPercent"] * 100) / 100);
}

class Author {
  String fullName;

  Author({
    required this.fullName,
  });

  factory Author._fromJson(Map<String, dynamic> json) => Author(
        fullName: json["fullName"],
      );
}

// Response Model

class CartItemsResponseModel {
  List<CartResponseModel> data;
  bool isFailure;
  String? message;
  CartItemsResponseModel({
    required this.data,
    required this.isFailure,
    this.message,
  });

  factory CartItemsResponseModel.fromResponse(Response response) {
    bool isFailure = response.statusCode != 200;

    if (isFailure) {
      return CartItemsResponseModel(
        isFailure: isFailure,
        data: [],
        message: json.decode(response.body)['message'],
      );
    }

    final data = List<CartResponseModel>.from(
        json.decode(response.body).map((x) => CartResponseModel._fromJson(x)));
    return CartItemsResponseModel(isFailure: isFailure, data: data);
  }

  String toJsonRequestBody() {
    final courseIds = data.map((item) => item.courseId).toList();

    return json.encode({'courseIds': courseIds});
  }

  // Convert List<CartResponseModel> to Map<int, CartResponseModel>
  Map<int, CartResponseModel> toMapData() {
    Map<int, CartResponseModel> cartMap = {};
    for (var cart in data) {
      cartMap[cart.courseId] = cart;
    }
    return cartMap;
  }

  double get totalPrice {
    double totalPrice = 0;
    for (var cart in data) {
      totalPrice += cart.course.price;
    }
    return totalPrice;
  }
}
