import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';
import '../appcolors/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget{
final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star,color:AppColors.mainColor)),
            ),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "1287"),
            SizedBox(width: 10,),
            SmallText(text: "Comments")

          ],
        ),
        SizedBox(height: Dimensions.height10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconcolor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.7km",
                iconcolor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "32Min",
                iconcolor: AppColors.iconColor2)
          ],
        )

      ],
    );
  }
}
