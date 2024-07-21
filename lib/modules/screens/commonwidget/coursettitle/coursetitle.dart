import 'package:flutter/material.dart';
import 'package:mindmorph/modules/course_player/presentation/widgets/dashboard/rating_bar.dart';
import '/constants/color.dart';
import '/constants/fonts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featurelistRow(
    {image,
    required String name,
    required int price,
    required double rating,
    required double discountPercent,
    bool isNetwork = false}) {
  return Expanded(
    child: Container(
      // width: 250,
      // height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: themecolor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: isNetwork
                      ? NetworkImage(image as String) as ImageProvider
                      : AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: 80,
            ),
            name.text
                .fontFamily(semibold)
                .maxLines(2)
                // .size(1)
                .color(titlecolor)
                .overflow(TextOverflow.ellipsis)
                .make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (discountPercent > 0)
                  'Rs $price'
                      .text
                      .color(const Color.fromRGBO(158, 158, 158, 1))
                      .lineThrough
                      .make(),
                'Rs ${(price * (1 - discountPercent / 100)).toDoubleStringAsFixed(digit: 0)}'
                    .text
                    .color(Colors.amber)
                    .make()

                // 'Rs $price'
                //     .text
                //     .fontFamily(semibold)
                //     .color(titlecolor)
                //     .size(2)
                //     .make(),
              ],
            ),
            RatingBar(rating: rating),
          ],
        ),
      ),
    ),
  );
}
