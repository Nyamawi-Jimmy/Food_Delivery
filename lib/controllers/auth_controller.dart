import 'package:get/get.dart';

import '../data/Repository/auth_repo.dart';
import '../models/response_model.dart';
import '../models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService{
final AuthRepo authRepo;

AuthController({
  required this.authRepo,
});

bool _isLoading=false;
bool get isLoading=>_isLoading;


Future<ResponseModel>registration(SignUpBody signUpBody) async {
  _isLoading = true;
  update();
  Response response = await authRepo.registration(signUpBody);
  late ResponseModel responseModel;
  if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel=ResponseModel(true, response.body["token"]);
  }else{
    responseModel=ResponseModel(true, response.statusText!);
  }
  _isLoading = false;
  update();
  return responseModel;
}
bool userLoggedIn() {
  return authRepo.userLoggedIn();
}
}