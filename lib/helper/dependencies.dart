
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/Recommended_product_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../data/Repository/auth_repo.dart';
import '../data/Repository/cart_repo.dart';
import '../data/Repository/popular_product_repo.dart';
import '../data/Repository/recommendes_product_repo.dart';
import '../data/api/api_client.dart';
import '../utils/app_constants.dart';

Future <void>init()async {

  final sharedPreferences =await SharedPreferences.getInstance();

  Get.lazyPut(()=>sharedPreferences);

  //Api client
Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

//repos
Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>CartRepo(sharedPreferences:Get.find()));

//controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
Get.lazyPut(() => CartController(cartRepo:Get.find()));

}