import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: AuthenticationRepository.instance.logout, icon: Icon(CupertinoIcons.clear))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              /// Image
              Image.asset(UImages.mailSentImage, height: UDeviceHelper.getScreenWidth(context) * 0.6),
              SizedBox(height: USizes.spaceBtwItems),

              /// Title
              Text(UTexts.verifyEmailTitle, style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: USizes.spaceBtwItems),

              /// Email
              Text(email ?? '', style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: USizes.spaceBtwItems),

              /// SubTitle
              Text(UTexts.verifyEmailSubTitle,
                  style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
              SizedBox(height: USizes.spaceBtwSections),

              /// Continue
              UElevatedButton(onPressed: controller.checkEmailVerificationStatus, child: Text(UTexts.uContinue)),

              /// Resend Email
              SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: controller.sendEmailVerification, child: Text(UTexts.resendEmail)))
            ],
          ),
        ),
      ),
    );
  }
}
