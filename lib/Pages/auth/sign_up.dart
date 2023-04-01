import 'package:delivery/appcolors/colors.dart';
import 'package:delivery/base/show_custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:delivery/models/signup_body_model.dart';
import '../../base/custom_loader.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/sign_up_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import 'check_sign_up.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final signupController=Get.put (SignUpController());

  @override
  Widget build(BuildContext context) {
/*    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var firstController = TextEditingController();
    var middleController = TextEditingController();
    var lastController = TextEditingController();
    var phoneController = TextEditingController()*/;

    var signUpImages = [
      "g.png",
      "f.png",
      "t.jpg"
    ];
   /* void checkSignUp() {
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
      showCustomSnackBar("Registered succesfully",title: "Registration")
      }

    }*/
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: GetBuilder<SignUpController>(builder: (controller){
              return Column(
                children: [
                  //Sign Up Page
                  SizedBox(height: Dimensions.screenHeight * 0.05,),
                  //Icon
                  Container(
                    height: Dimensions.screenHeight * 0.25,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        backgroundImage: AssetImage(
                            "assets/images/logo.png"
                        ),
                      ),
                    ),
                  ),

                  //Text Fields
                  AppTextField(textController: controller.emailController,
                    hintText: 'Email',
                    icon: Icons.email,),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(textController: controller.phonepasswordController,
                      hintText: "Enter Password",
                      icon: Icons.password),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(textController: controller.firstController,
                    hintText: 'First Name',
                    icon: Icons.person,),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(textController: controller.middleController,
                    hintText: 'Middle Name',
                    icon: Icons.person_2,),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(textController: controller.lastController,
                    hintText: 'Last Name name',
                    icon: Icons.person_3,),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(textController: controller.phoneController,
                    hintText: 'Enter Phone Number',
                    icon: Icons.phone,),

                  //Sign Up Button
                  SizedBox(height: Dimensions.height20,),
                  GestureDetector(
                    onTap: () {
                      controller.checkSignUp();
                    },
                    child: Container(
                      width: Dimensions.screenWidth / 2,
                      height: Dimensions.screenHeight / 13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: BigText(text: "Sign Up",
                          size: Dimensions.font20 + Dimensions.font20 / 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  //Already have an account??
                  SizedBox(height: Dimensions.height10,),
                  RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account already?",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )),

                  //Sign Up using one of the following
                  SizedBox(height: Dimensions.screenHeight * 0.03,),
                  RichText(
                      text: TextSpan(
                          text: "Sign up using one of the following methods",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16
                          )
                      )),
                  Wrap(
                      children:
                      List.generate(3, (index) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage: AssetImage(
                                "assets/images/" + signUpImages[index],
                              ),
                            ),
                          ))

                  )
                ],
              );
            },)
        ),
    );
  }

}
