import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signup_body_model.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
});

  Future<Response>registration(SignUpBody signUpBody)async{
    return await apiClient.postData(AppConstants.APP_URL+AppConstants.REGISTRATION_URI ,signUpBody.toJson());
  }

  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }
  saveUserToken(String token) async {
    apiClient.token=token;
    apiClient.updateHeade(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
}