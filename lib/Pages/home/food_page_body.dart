import 'package:delivery/controllers/Recommended_product_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../appcolors/colors.dart';
import '../../controllers/popular_product_controller.dart';
import '../../models/products_model.dart';
import '../../routes/routes_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../food/popular_food_detail.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction:0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _height=Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue=pageController.page! ;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        // Slide Section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return Container(
            //color: Colors.redAccent,
            height: Dimensions.pageView,
            child: GestureDetector(
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context,position){
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  }),
            ),
          );
        }),

    //Dots Section
    GetBuilder<PopularProductController>(builder: (popularProducts){
      return DotsIndicator(
        dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
        position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          )
      );

    }),

        //Popular Text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text:"Recommended"),
                SizedBox(width: Dimensions.widtht10,),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: SmallText(text: "."),
                ),
                SizedBox(width: Dimensions.widtht10,),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food pairing"),
                )
              ],
          ),
        ),

        //Recommended food page
        //Food List View and Images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context,position){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(position,"home"));
                  },
                  child: Container (
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //Image Section
                        Container(
                          width:Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                image: NetworkImage(
                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[position].img!
                                ),
                              )
                          ),
                        ),

                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight:Radius.circular(Dimensions.radius20),
                                bottomRight:Radius.circular(Dimensions.radius20),
                              ),
                              color:Colors.white,
                            ),

                            child:Padding(
                              padding: EdgeInsets.only(left:Dimensions.width10,right:Dimensions.width8,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[position].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: "With Chinese Characteristics"),
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
                                  ),
                                ],

                              ),

                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                );

              });
        })
      ],
    );
  }
  Widget _buildPageItem(int index,ProductModel popularPoduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
      else if(index==_currPageValue.floor()+1){
        var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
        var currTrans=_height*(1-currScale)/2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
      else if (index ==_currPageValue.floor()-1) {
        var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
        var currTrans = _height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }
      else{
        var currScale=0.8;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);

    }


    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.widtht10,right: Dimensions.widtht10),
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularPoduct.img!
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width16,right: Dimensions.width16,bottom: Dimensions.height16),
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5)
                  ),
              BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0)
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0)
                  )
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.height15,right: Dimensions.height15,top: Dimensions.height15),
                child:AppColumn(text: popularPoduct.name!,),
            ),
          )
          )
        ],

      ),
    );
  }
}
