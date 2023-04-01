import 'package:delivery/appcolors/colors.dart';
import 'package:delivery/widgets/app_icons.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigText(text: "Profile",size: 24,color: Colors.white,)),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            //Profile Icon
            AppIcons(icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconcolor: Colors.white,
              iconSize: Dimensions.iconSize24*3,
              size: Dimensions.height15*10,
            ),
              SizedBox(height: Dimensions.height20*2),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Name
                      AccountWidget(appIcon:AppIcons(icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.iconSize16*2,
                          size: Dimensions.height15*3),
                          bigText: BigText( text: 'Jimmy')),
                      SizedBox(height: Dimensions.height20),
                      //Phone
                      AccountWidget(appIcon:AppIcons(icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.iconSize16*2,
                          size: Dimensions.height15*3),
                          bigText: BigText( text: '0718845069')),
                      SizedBox(height: Dimensions.height20),
                      //Email
                      AccountWidget(appIcon:AppIcons(icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.iconSize16*2,
                          size: Dimensions.height15*3),
                          bigText: BigText( text: 'nyamawijimmy@gmail.com')),
                      SizedBox(height: Dimensions.height20),
                      //Address
                      AccountWidget(appIcon:AppIcons(icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.iconSize16*2,
                          size: Dimensions.height15*3),
                          bigText: BigText( text: 'Fill in your address')),
                      SizedBox(height: Dimensions.height20),
                      //Message
                      AccountWidget(appIcon:AppIcons(icon: Icons.message,
                          backgroundColor: Colors.redAccent,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.iconSize16*2,
                          size: Dimensions.height15*3),
                          bigText: BigText( text: 'Jimmy')),
                      SizedBox(height: Dimensions.height20),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
