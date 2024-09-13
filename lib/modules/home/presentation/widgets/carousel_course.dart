import 'package:flutter/material.dart';
import 'package:mindmorph/admin/swiper/data/repository/swiper_repository.dart';
import 'package:mindmorph/admin/swiper/models/swiper_model.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CarouselCourse extends StatefulWidget {
  const CarouselCourse({
    super.key,
  });

  @override
  State<CarouselCourse> createState() => _CarouselCourseState();
}

class _CarouselCourseState extends State<CarouselCourse> {
  List<SwiperModel>? swipers;

  void initSwipers() async {
    final response = await SwiperRepository.getAllSwipers();
    setState(() {
      swipers = response;
    });
  }

  @override
  void initState() {
    super.initState();
    initSwipers();
  }

  @override
  Widget build(BuildContext context) {
    return swipers == null
        ? const MindMorphLoadingIndicator()
        : VxSwiper.builder(
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
            height: 230,
            itemCount: swipers!.length,
            viewportFraction: 0.9999,
            itemBuilder: (BuildContext context, int index) {
              final imagePath = swipers![index].image;
              return Image.network(
                'http://$NODE_SERVER/$imagePath',
                fit: BoxFit.fill,
              )
                  .box
                  .rounded
                  .clip(Clip.antiAlias)
                  .margin(const EdgeInsets.symmetric(horizontal: 10))
                  .make();
            });
  }
}
