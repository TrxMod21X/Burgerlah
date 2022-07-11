part of '../data.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstant.signUpUri, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstant.token) ?? 'None';
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstant.token);
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstant.signInUri, {
      "email": email,
      "password": password,
    });
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstant.token, token);
  }

  // Future<void> saveUserEmailAndPassword(String email, String password) async {
  //   try {
  //     await sharedPreferences.setString(AppConstant.email, email);
  //     await sharedPreferences.setString(AppConstant.password, password);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstant.number, number);
      await sharedPreferences.setString(AppConstant.password, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.token);
    sharedPreferences.remove(AppConstant.password);
    sharedPreferences.remove(AppConstant.email);
    sharedPreferences.remove(AppConstant.number);

    apiClient.token = '';
    apiClient.updateHeader('');

    return true;
  }
}
