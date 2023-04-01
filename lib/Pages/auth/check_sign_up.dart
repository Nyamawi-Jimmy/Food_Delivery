/*
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController,
      passwordController,
      firstController,
      middleController,
      lastController,
      phoneController;


  void checkSignUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String first = firstController.text.trim();
    String middle = middleController.text.trim();
    String last = lastController.text.trim();
    String phone = phoneController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar("Type in your email", title: "Email");
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar(
          "Type in your valid email address", title: "Valid  Email");
    } else if (password.length < 6) {
      showCustomSnackBar(
          "Password cannot be less than six characters", title: "Password");
    } else if (first.isEmpty) {
      showCustomSnackBar("Type in your firstname", title: "First Name");
    } else if (middle.isEmpty) {
      showCustomSnackBar("Type in your middle name", title: "Middle Name");
    } else if (last.isEmpty) {
      showCustomSnackBar("Type in your lastname", title: "LastName");
    }

    else if (phone.isEmpty) {
      showCustomSnackBar("Type in your phone number", title: "Phone number");
    }
    else {
      Get.showOverlay(
          asyncFunction: ()=> signup(), loadingWidget: CustomLoader());
    }
  }
  signup() async {}
}*/
