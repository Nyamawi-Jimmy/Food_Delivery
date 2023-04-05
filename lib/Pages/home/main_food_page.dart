import 'package:flutter/material.dart';
import '../../appcolors/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  String _selectedLocation = 'Boma'; // Add a state variable to keep track of selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Showing the header
          Container(
            child: Container(
              margin: EdgeInsets.only(top:Dimensions.height25,bottom: Dimensions.height20),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      BigText(text:"Dekut",color: AppColors.mainColor,size:25),
                      /*Row(
                        children: [
                          SmallText(text: _selectedLocation, color: Colors.black54, size: 15), // Use the selected location here
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )*/
                      DropdownButton<String>(
                        value: _selectedLocation, // Use the selected location as the current value
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue!; // Update the selected location when the user selects a new value
                          });
                        },
                        items: <String>['Boma', 'NyeriView', 'Embassy', 'Kahawa'] // Add other locations here
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  /*Center(
                    child:Container(
                      width: Dimensions.width40,
                      height: Dimensions.height40,
                      child: Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),*/
                  // Add the dropdown button here

                ],
              ),
            ),
          ),
          //Showing the body
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
        ],
      ),
    );
  }
}
