import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/constants/color.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import 'package:mindmorph/modules/cart/data/repositories/cart_repository.dart';
import 'package:mindmorph/modules/payment/payment_via_esewa.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/snackbar.dart';

class CartScreenView extends StatefulWidget {
  const CartScreenView({
    super.key,
    required this.cart,
  });

  final CartData cart;

  @override
  State<CartScreenView> createState() => _CartScreenViewState();
}

class _CartScreenViewState extends State<CartScreenView> {
  @override
  Widget build(BuildContext context) {
    final mapData = widget.cart.mainServer.toMapData();
    return widget.cart.mainServer.data.isEmpty
        ? const ErrorPage(message: 'Cart is Empty')
        : Container(
            color: backgrounghilghtcolor,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     ElevatedButton(
                //       style:
                //           ElevatedButton.styleFrom(backgroundColor: listcolor),
                //       onPressed: () {},
                //       child: const Text(
                //         'Buy all',
                //         style: TextStyle(color: featureColor),
                //       ),
                //     ),
                //     Text(
                //       'Rs ${widget.cart.mainServer.totalPrice.toDoubleStringAsFixed(digit: 0)}',
                //       style: const TextStyle(
                //           color: featureColor, backgroundColor: listcolor),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.cart.courseServer.length,
                    itemBuilder: ((context, index) {
                      final data1 = widget.cart.courseServer[index];
                      final data2 = mapData[data1.courseId];

                      final double price = data2!.course.price;
                      final double discount = data2.course.discountPercent;
                      final actualPrice = (price - ((discount / 100) * price))
                          .roundToDouble()
                          .toInt();
                      return Card(
                        color: boxtilecolor,
                        semanticContainer: true,
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          leading: Container(
                            decoration: const BoxDecoration(
                              color: redColor,
                            ),
                            width: 100,
                            height: 150,
                            child: Image.network(
                              'http://$COURSE_SERVER/${data1.courseThumbnailUrl}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            data1.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          titleTextStyle: const TextStyle(color: titlecolor),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(width: 5),
                                  Text(
                                    data2.course.author.fullName,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 176, 176, 175)),
                                  ),
                                  // SizedBox(
                                  //   width: MediaQuery.of(context).size.width * 0.2,
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs $actualPrice',
                                    style: const TextStyle(color: Colors.amber),
                                  ),
                                  Text(data2.updatedAt),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: listcolor),
                                      onPressed: () async {
                                        // Buy a course
                                        final userId = await UserStorage.userId;
                                        if (context.mounted) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentViaWeb(
                                                      userId: userId,
                                                      courseId: data2.courseId,
                                                      totalAmount: actualPrice,
                                                      cartId: data2.id),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Buy',
                                        style: TextStyle(color: Colors.amber),
                                      )),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 171, 90, 84),
                                    ),
                                    onPressed: () async {
                                      final result =
                                          await CartRepository.deleteCartItem(
                                              data2.id);
                                      if (result.isSuccess && context.mounted) {
                                        mindMorphSnackBar(
                                            context: context,
                                            message: result.message);
                                        setState(() {
                                          widget.cart.mainServer.data
                                              .remove(data2);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            context.push(
                                '/course/dashboard/cart/${data2.courseId}');
                          },
                        ),
                      );
                    })),
              ],
            ),
          );
  }
}
