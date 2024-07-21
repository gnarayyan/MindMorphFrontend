import 'package:flutter/material.dart';
import 'package:mindmorph/modules/cart/presentation/widgets/cart_screen_view.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '/constants/color.dart';
import '../../data/repositories/cart_repository.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: featureColor),
        toolbarHeight: 80,
        shadowColor: Colors.white,
        foregroundColor: Colors.red,
        backgroundColor: themecolor,
        title: const Text(
          'Cart Items',
          style: TextStyle(color: titlecolor),
        ),
      ),
      body: FutureBuilder<CartData>(
        future: CartRepository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MindMorphLoadingIndicator();
          } else if (snapshot.hasError) {
            return const ErrorPage(message: 'Cart is Empty');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const ErrorPage(message: 'No data available');
          } else {
            final cart = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: CartScreenView(cart: cart),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
