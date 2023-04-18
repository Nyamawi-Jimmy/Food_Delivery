import 'package:delivery/Pages/auth/register.dart';
import 'package:delivery/Pages/auth/sign_up.dart';
import 'package:delivery/appcolors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/sign_in_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
SignInPage({Key? key}) : super(key: key);
  final signInController=Get.put (SignInController());


  @override
  Widget build(BuildContext context) {
/*    var phoneController=TextEditingController();
    var passwordController=TextEditingController();*/

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<SignInController>(builder: (controller){
          return Column(
            children: [
              //Sign In Page
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //Icon
              Container(
                height: Dimensions.screenHeight*0.25,
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

              //Welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),),
                    Text("Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //Text Fields
              AppTextField(textController:controller.emailController,
                hintText: 'Enter Email', icon: Icons.email,),
              SizedBox(height: Dimensions.height10,),
              AppTextField(textController:controller.phonepasswordController,
                  hintText: "Enter Password", icon: Icons.password,
                  isObscure: true,
              ),
              SizedBox(height: Dimensions.height10,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),

              //Sign Up Button
              SizedBox(height: Dimensions.height30,),
              GestureDetector(
                onTap: (){
               controller.checkSignIn();
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text:"Sign In",
                      size:Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(
                text: TextSpan(
                    text: "Dont have an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                        text: "Create",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold
                        ),)
                    ]
                ),
              ),
            ],
          );
        },)
      ),
    );
  }
}
