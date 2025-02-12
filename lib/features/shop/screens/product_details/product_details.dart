import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Scaffold(
      /// -----[Body]-----
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// -----[Product Image With Slider]-----
            Container(

            )

            /// -----[Product Details]-----
            /// Price, Title, Stock And Brand
            /// Attributes
            /// Checkout Button
            /// Description
          ],
        ),
      ),
      /// -----[Bottom Navigation]-----
    );
  }
}
