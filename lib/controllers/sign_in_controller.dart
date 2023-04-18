import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../base/custom_loader.dart';
import '../base/custom_snackbar.dart';
import '../base/show_custom_snackbar.dart';
import '../routes/routes_helper.dart';
import '../utils/app_constants.dart';
import '../utils/shared_prefs.dart';

class SignInController extends GetxController{
late TextEditingController
emailController,
phonepasswordController;

@override
void onInit() {
  super.onInit();
  phonepasswordController = TextEditingController();
  emailController = TextEditingController();

 }

/*@override
void onClose() {
  super.onClose();
  phonepasswordController.dispose();
  phoneController.dispose();
}*/
void checkSignIn() {
  String email = emailController.text.trim();
  String phonepassword = phonepasswordController.text.trim();

  if (email.isEmpty) {
    showCustomSnackBar("Type in your email", title: "Email");
  }
  else if (phonepassword.length < 6) {
    showCustomSnackBar("Password cannot be less than six characters",
        title: "Password");
  } else {
          Get.showOverlay(asyncFunction: () => signin(),loadingWidget: CustomLoader());
  }
  }
signin() async {
  var response = await http.post(Uri.parse(AppConstants.LOGIN_URL), body: {
    "email": emailController.text,
    "password": phonepasswordController.text,
  });
  print(response.request?.url);
  print(response.request?.finalized);
  print(response.body);
  var res = await json.decode(response.body);
  if (response.statusCode==200) {
    var token = res["message"];

    var toDashboard = await http.get(Uri.parse(AppConstants.DASHBOARD_URL), headers: {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization": "Bearer " + token,
    });

    //var respo = await jsonDecode(toDashboard.body);
    print("response" + toDashboard.body);
    if (toDashboard.statusCode == 200) {
      Get.offAllNamed(RouteHelper.getInitial());
      CustomSnackBar("Success","Login successful", "Success");
    }

  } else {
    CustomSnackBar("error", res["message"], "error");
  }


}

}

