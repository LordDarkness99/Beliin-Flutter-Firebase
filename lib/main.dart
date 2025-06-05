import 'dart:async';

import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/data/services/branch_services.dart';
import 'package:e_commerce/my_app.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  /// Widgets Flutter Binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Flutter Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Get Storage Initialization
  await GetStorage.init();

  /// Initialize Branch SDK
  Get.put(BranchServices()).initBranch();

  /// Initialize Publishable Key
  Stripe.publishableKey = UKeys.stripePublishableKey;

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {
    Get.put(AuthenticationRepository());
  });

  /// Portrait Up The Device
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}