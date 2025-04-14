import 'package:e_commerce/data/repositories/category/category_repository.dart';
import 'package:e_commerce/data/repositories/user/user_repository.dart';
import 'package:e_commerce/dummy_data.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/authentication/screens/login/login.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  @override
  void onReady() {
    // Remove the splash screen
    FlutterNativeSplash.remove();

    // Redirect to the right screen
    screenRedirect();
  }

  /// Function to redirect to the right screen
  void screenRedirect() {

    final user = _auth.currentUser;
    if(user != null){

      // Check if user is verified
      if(user.emailVerified){
        // if verified, go to navigation menu
        Get.offAll(() => NavigationMenu());
      }else{

        // if not verified, go to verify email screen
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    }else{
      // write isFirstTime If Null
      localStorage.writeIfNull('isFirstTime', true);

      // Check if user is first time
      localStorage.read('isFirstTime') != true
          ? Get.to(() => LoginScreen()) // If not first time, go to login screen
          : Get.to(() => OnboardingScreen()); // if first time, go to onboarding screen
    }

  }

  /// [Authentication]  - With Email & Password
  Future<UserCredential> registerUser(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication]  - Sign In
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [GoogleAuthentication]  - Google Sign In
  Future<UserCredential> signInWithGoogle() async{
    try{

      // Show Popup to select google account
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

      // Get the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleAccount?.authentication;

      // create credentials
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken
      );

      // Sign In using google credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - Send Mail
  Future<void> sendEmailVerification() async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ForgetPassword] - Send Mail To Reset Password
  Future<void> sendPasswordResetEmail(String email) async{
    try{

      await _auth.sendPasswordResetEmail(email: email);

    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ForgetPassword] - Send Mail To Reset Password
  Future<void> reAuthenticateUserWithEmailAndPassword(String email, String password) async{
    try{

      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      await currentUser!.reauthenticateWithCredential(credential);

    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Logout] - Logout the user
  Future<void> logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DeleteUser] - Delete User Account
  Future<void> deleteAccount() async{
    try{

      await UserRepository.instance.removeUserRecord(currentUser!.uid);

      // Remove Profile from cloudinary
      String publicId = UserController.instance.user.value.publicId;
      if(publicId.isNotEmpty){
        UserRepository.instance.deleteProfilePicture(publicId);
      }

      await _auth.currentUser?.delete();

    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
}
