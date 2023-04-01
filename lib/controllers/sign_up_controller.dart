import 'dart:convert';

import 'package:delivery/base/loader.dart';
import 'package:delivery/models/signup_body_model.dart';
import 'package:delivery/routes/routes_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../base/custom_loader.dart';
import '../base/custom_snackbar.dart';
import '../base/show_custom_snackbar.dart';
import '../utils/app_constants.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController,
      phonepasswordController,
      firstController,
      middleController,
      lastController,
      phoneController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    phonepasswordController = TextEditingController();
    firstController = TextEditingController();
    middleController = TextEditingController();
    lastController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    phonepasswordController.dispose();
    firstController.dispose();
    middleController.dispose();
    lastController.dispose();
    phoneController.dispose();
  }

  void checkSignUp() {
    String email = emailController.text.trim();
    String phonepassword = phonepasswordController.text.trim();
    String first = firstController.text.trim();
    String middle = middleController.text.trim();
    String last = lastController.text.trim();
    String phone = phoneController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar("Type in your email", title: "Email");
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("Type in your valid email address",
          title: "Valid  Email");
    } else if (phonepassword.length < 6) {
      showCustomSnackBar("Password cannot be less than six characters",
          title: "Password");
    } else if (first.isEmpty) {
      showCustomSnackBar("Type in your firstname", title: "First Name");
    } else if (middle.isEmpty) {
      showCustomSnackBar("Type in your middle name", title: "Middle Name");
    } else if (last.isEmpty) {
      showCustomSnackBar("Type in your lastname", title: "LastName");
    } else if (phone.isEmpty) {
      showCustomSnackBar("Type in your phone number", title: "Phone number");
    } else {
      Get.showOverlay(asyncFunction: () => signup(), loadingWidget: Loader());
    }
  }

  signup() async {
    var response = await http
        .post(Uri.parse(AppConstants.APP_URL + "/registerCustomer.php"), body: {
      "email": emailController.text,
      "password": phonepasswordController.text,
      "first": firstController.text,
      "middle": middleController.text,
      "last": lastController.text,
      "phone": phoneController.text,
    });
    var res = await json.decode(response.body);

    if (res["message"] == "User added successfully") {

      Get.offAllNamed(RouteHelper.signin);
      CustomSnackBar("Success", res["message"], "Success");

    } else {
      CustomSnackBar("error", res["message"], "error");
    }
  }
}
