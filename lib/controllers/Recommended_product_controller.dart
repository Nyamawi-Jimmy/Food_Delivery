import 'dart:convert';
import 'package:get/get.dart';

import '../data/Repository/popular_product_repo.dart';
import '../data/Repository/recommendes_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=>_recommendedProductList;

  Future<void> getRecommendedProductList()async {
    Response response= await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      update();

    }
  }
}


