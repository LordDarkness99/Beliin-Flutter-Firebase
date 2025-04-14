import 'package:e_commerce/common/widgets/shimmer/category_shimmer.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../controllers/category/category_controller.dart';
import '../../sub_category/sub_category.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Heading
          Text(UTexts.popularCategories, style: Theme.of(context).textTheme.headlineSmall!.apply(color: UColors.white)),
          SizedBox(height: USizes.spaceBtwItems),

          /// Categories ListView
          Obx(
            (){

              final categories = controller.featuredCategories;

              /// [LoadingState]
              if(controller.isCategoriesLoading.value){
                return UCategoryShimmer(itemCount: 6);
              }

              /// [Empty]
              if(categories.isEmpty){
                return Text('Categories Not Found');
              }

              /// [DataFound]
              return SizedBox(
                height: 82,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    CategoryModel category = categories[index];
                    return UVerticalImageText(title: category.name, image: category.image, textColor: UColors.white, onTap: () => Get.to(() => SubCategoryScreen()));
                  },
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
