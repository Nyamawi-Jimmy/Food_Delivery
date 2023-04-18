import 'dart:convert';

import 'package:delivery/appcolors/colors.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/sign_in_controller.dart';
import 'package:delivery/routes/routes_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/widgets/app_icons.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;
import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {


  Future<dynamic> getCustomerDetails() async {
    var response = await http.get(
        Uri.parse(AppConstants.APP_URL + "/getAllCustomers.php"));
    var res = await json.decode(response.body);
    return res;
  }

  var customerDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: FutureBuilder<dynamic>(
          future: getCustomerDetails(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error fetching customer details'));
              } else {
                customerDetails = snapshot.data;
                print("customer details" + customerDetails);
                // You can use customerDetails here to display the details on the screen
                return Column(
                  children: [
                    // Profile Icon
                    AppIcons(
                      icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconcolor: Colors.white,
                      iconSize: Dimensions.iconSize24 * 3,
                      size: Dimensions.height15 * 10,
                    ),
                    SizedBox(height: Dimensions.height20 * 2),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Name
                            AccountWidget(
                              appIcon: AppIcons(
                                icon: Icons.person,
                                backgroundColor: AppColors.mainColor,
                                iconcolor: Colors.white,
                                iconSize: Dimensions.iconSize16 * 2,
                                size: Dimensions.height15 * 3,
                              ),
                              bigText: BigText(text: 'Jimmy'),
                            ),
                            SizedBox(height: Dimensions.height20),
                            // Phone
                            AccountWidget(
                              appIcon: AppIcons(
                                icon: Icons.phone,
                                backgroundColor: AppColors.yellowColor,
                                iconcolor: Colors.white,
                                iconSize: Dimensions.iconSize16 * 2,
                                size: Dimensions.height15 * 3,
                              ),
                              bigText: BigText(text: '0718845069'),
                            ),
                            SizedBox(height: Dimensions.height20),
                            // Email
                            AccountWidget(
                              appIcon: AppIcons(
                                icon: Icons.email,
                                backgroundColor: AppColors.yellowColor,
                                iconcolor: Colors.white,
                                iconSize: Dimensions.iconSize16 * 2,
                                size: Dimensions.height15 * 3,
                              ),
                              bigText: BigText(text: 'nyamawijimmy@gmail.com'),
                            ),
                            SizedBox(height: Dimensions.height20),
                            // Address
                            AccountWidget(
                              appIcon: AppIcons(
                                icon: Icons.location_on,
                                backgroundColor: AppColors.yellowColor,
                                iconcolor: Colors.white,
                                iconSize: Dimensions.iconSize16 * 2,
                                size: Dimensions.height15 * 3,
                              ),
                              bigText: BigText(text: 'Fill in your address'),
                            ),
                            SizedBox(height: Dimensions.height20),
                            // Message
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed(RouteHelper.signin);
                              },
                              child: AccountWidget(
                                appIcon: AppIcons(
                                  icon: Icons.logout,
                                  backgroundColor: Colors.redAccent,
                                  iconcolor: Colors.white,
                                  iconSize: Dimensions.iconSize16 * 2,
                                  size: Dimensions.height15 * 3,
                                ),
                                bigText: BigText(text: 'Logout'),
                              ),
                            ),
                            SizedBox(height: Dimensions.height20),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}