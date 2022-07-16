part of 'utils.dart';

class AppConstant {
  static const String appName = 'Food Market App';
  static const int appVersion = 1;

  /// BASE URL
  // static const String baseUrl = 'https://aceh-foodmarket-app.masuk.id';
  static const String baseUrl = 'https://6e78-2001-448a-11a0-1038-5be-a1c9-af6d-9383.ap.ngrok.io';
  // static const String baseUrl = 'http://127.0.0.1:8000';

  /// PRODUCTS ENDPOINT
  static const String allProductFoodsUri = '/api/v1/products/foods';
  static const String popularProductUri = '/api/v1/products/popular';
  static const String recommendedProductUri = '/api/v1/products/recommended';

  /// AUTH ENDPOINT
  static const String signUpUri = '/api/v1/auth/register';
  static const String signInUri = '/api/v1/auth/login';
  static const String userInfoUri = '/api/v1/customer/info';

  /// LOCATION ENDPOINT
  static const String userAddress = 'user_address';
  static const String geocodeUri = '/api/v1/config/geocode-api';

  static const String token = '';
  static const String email = '';
  static const String password = '';
  static const String number = '';
  static const String cartList = 'cart-list';
  static const String cartHistoryList = 'cart-history-list';
}
