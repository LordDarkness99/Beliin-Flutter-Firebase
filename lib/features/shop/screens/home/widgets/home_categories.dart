import 'package:e_commerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../sub_category/sub_category.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Heading
          Text(UTexts.popularCategories, style: Theme.of(context).textTheme.headlineSmall!.apply(color: UColors.white)),
          SizedBox(height: USizes.spaceBtwItems),

          /// Categories ListView
          SizedBox(
            height: 80,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return UVerticalImageText(title: 'Sports Categories', image: UImages.bagsIcon, textColor: UColors.white, onTap: () => Get.to(() => SubCategoryScreen()),);
              },
            ),
          )
        ],
      ),
    );
  }
}
