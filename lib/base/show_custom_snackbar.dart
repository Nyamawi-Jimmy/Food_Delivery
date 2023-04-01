import 'package:delivery/appcolors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/big_text.dart';
import '../widgets/small_text.dart';

void showCustomSnackBar(String message, {bool isError=true, String title="Error"}){

  Get.snackbar(title, message,
  titleText: BigText(text: title,color: Colors.white,),
    messageText: Text(message,style:TextStyle(
      color: Colors.white,
    )),
    colorText: Colors.white,
    backgroundColor: AppColors.mainColor
  );
}