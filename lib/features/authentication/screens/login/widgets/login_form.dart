import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../forget_password/forget_password.dart';
import '../../signup/signup.dart';

class ULoginForm extends StatelessWidget {
  const ULoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: UTexts.email),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          /// Password
          Obx(
              () => TextFormField(
              validator: (value) => UValidator.validateEmptyText('Password', value),
              controller: controller.password,
              obscureText: controller.isPasswordVisible.value,
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check), labelText: UTexts.password,
                  suffixIcon: IconButton(
                      onPressed: () => controller.isPasswordVisible.toggle(),
                      icon: Icon(controller.isPasswordVisible.value ? Iconsax.eye_slash : Iconsax.eye))
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields / 2),

          /// Remember Me & Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Remember Me
              Row(
                children: [Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.toggle())), Text(UTexts.rememberMe)],
              ),

              /// ForgetPassword
              TextButton(onPressed: () => Get.to(() => ForgetPasswordScreen()), child: Text(UTexts.forgetPassword))
            ],
          ),
          SizedBox(height: USizes.spaceBtwSections),

          /// Sign In
          UElevatedButton(onPressed: controller.loginWithEmailAndPassword, child: Text(UTexts.signIn)),
          SizedBox(height: USizes.spaceBtwItems / 2),

          /// Create Account
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: () => Get.to(() => SignupScreen()), child: Text(UTexts.createAccount))),
        ],
      ),
    );
  }
}
