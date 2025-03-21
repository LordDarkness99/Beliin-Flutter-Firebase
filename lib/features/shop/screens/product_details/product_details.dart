import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -----[Body]-----
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -----[Product Image With Slider]-----
            UProductThumbnailAndSlider(),

            /// -----[Product Details]-----
            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  UProductMetaData(),
                  SizedBox(height: USizes.spaceBtwSections),

                  /// Attributes
                  UProductAttributes(),
                  SizedBox(height: USizes.spaceBtwSections),

                  /// Checkout Button
                  UElevatedButton(onPressed: (){}, child: Text('Checkout')),
                  SizedBox(height: USizes.spaceBtwSections),

                  /// Description
                  USectionHeading(title: 'Description', showActionButton: false),
                  SizedBox(height: USizes.spaceBtwItems),

                  ReadMoreText(
                    'This is a product of iPhone 11 with 512 GB, This is a product of iPhone 11 with 512 GB, This is a product of iPhone 11 with 512 GB, This is a product of iPhone 11 with 512 GB, This is a product of iPhone 11 with 512 GB, This is a product of iPhone 11 with 512 GB',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                  ),

                  SizedBox(height: USizes.spaceBtwSections)
                ],
              ),
            )

          ],
        ),
      ),

      /// -----[Bottom Navigation]-----
      bottomNavigationBar: UBottomAddToCart(),
    );
  }
}




