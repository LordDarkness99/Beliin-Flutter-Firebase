import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/store_primary_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../utils/constants/sizes.dart';
import '../brands/all_brands.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return DefaultTabController(
      length: controller.featuredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 340,
                  pinned: true,
                  floating: false,
                  flexibleSpace: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// Primary Header
                        UStorePrimaryHeader(),
                        SizedBox(height: USizes.spaceBtwItems),

                        /// Brands List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
                          child: Column(
                            children: [
                              /// Brands Heading
                              USectionHeading(title: 'Brands', onPressed: () => Get.to(() => BrandScreen())),

                              /// Brand Cards
                              SizedBox(
                                height: USizes.brandCardHeight,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems),
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      SizedBox(width: USizes.brandCardWidth, child: UBrandCard()),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  bottom: UTabBar(tabs: controller.featuredCategories.map((category) => Tab(child: Text(category.name))).toList()),
                ),
              ];
            },
            body: TabBarView(children: controller.featuredCategories.map((category) => UCategoryTab()).toList())),
      ),
    );
  }
}
