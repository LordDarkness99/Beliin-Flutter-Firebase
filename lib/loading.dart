

import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/data/services/branch_services.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoadingController());
    return Scaffold(
      backgroundColor: UColors.primary,
      body: Center(
        child: CircularProgressIndicator(color: UColors.white),
      ),
    );
  }
}

class LoadingController extends GetxController{
  static LoadingController get instance => Get.find();


  @override
  void onInit() {
    BranchServices.instance.trackLink((data){
      AuthenticationRepository.instance.screenRedirect();
    }, onError: () => AuthenticationRepository.instance.screenRedirect());
    super.onInit();
  }
}

