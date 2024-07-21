// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../profile/data/providers/course_by_instructor.dart';
import '../../../profile/models/instructor_course_list_course_server.dart';
import '../../models/add_to_cart.dart';
import '../../models/get_from_cart.dart';
import '../../models/response_model.dart';
import '../providers/cart_provider.dart';

class CartData {
  CartItemsResponseModel mainServer;
  List<InstructorCourseModel> courseServer;
  CartData({
    required this.mainServer,
    required this.courseServer,
  });
}

class CartRepository {
  // Add to Cart
  static Future<ResponseModel> addToCart(
      AddToCartRequestModel requestData) async {
    final response =
        await CartProvider.addToCart(await requestData.toRequestBody());
    final responseData = ResponseModel.fromResponse(response);

    return responseData;
  }

  // Get all Cart items
  static Future<CartData> getAll() async {
    final response = await CartProvider.getAllCartItems();
    final responseData = CartItemsResponseModel.fromResponse(response);
    // final mapData = responseData.toMapData();

    //Course Server
    final coursesResponse =
        await InstructorCourses.byCoursesIds(responseData.toJsonRequestBody());
    // print('Course CArt data: ${coursesResponse}');
    if (coursesResponse.statusCode != 200) {
      throw jsonDecode(coursesResponse.body);
    }
    final cartCourses =
        InstructorCourseModel.fromResponse(coursesResponse.body);

    // print('Cart Courses: ${cartCourses}');

    return CartData(courseServer: cartCourses, mainServer: responseData);
  }

  // Add to Cart
  static Future<ResponseModel> deleteCartItem(int cartId) async {
    final response = await CartProvider.deleteCartItem(cartId);
    final responseData = ResponseModel.fromResponse(response);

    return responseData;
  }
}
