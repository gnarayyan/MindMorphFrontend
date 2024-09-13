import '../../models/response_model.dart';
import '../../models/swiper_model.dart';
import '../provider/swiper_provider.dart';

class SwiperRepository {
  static Future<SwiperResponseModel> uploadSwiper(String imagePath) async {
    final response = await SwiperProvider.uploadSwiper(imagePath);

    final result = SwiperResponseModel.fromResponse(response, 201);
    return result;
  }

  static Future<List<SwiperModel>> getAllSwipers() async {
    final response = await SwiperProvider.getAllSwipers();

    final result = SwiperModel.fromResponseBody(response.body);
    return result;
  }

  static Future<SwiperResponseModel> deleteSwiper(int id) async {
    final response = await SwiperProvider.deleteSwiper(id);

    final result = SwiperResponseModel.fromResponse(response, 200);
    return result;
  }
}
