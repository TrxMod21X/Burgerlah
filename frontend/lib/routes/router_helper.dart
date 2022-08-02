part of 'routes.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signUpPage = '/sign-up';
  static const String signInPage = '/sign-in';
  static const String addAddress = '/add-address';
  static const String pickAddressMap = '/pick-address';
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static String getSplashPage() => splashPage;

  static String getInitial() => initial;

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';

  static String getSignUpPage() => '$signUpPage';
  static String getSignInPage() => '$signInPage';

  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';

  static String getPaymentPage(String id, int userID) =>
      '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status) =>
      '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    /// SPLASH PAGE
    GetPage(
      name: splashPage,
      page: () => const SplashScreen(),
    ),

    /// HOME PAGE
    GetPage(
      name: initial,
      page: () => const HomePage(),
    ),

    /// SIGN IN PAGE
    GetPage(
        name: signInPage,
        page: () {
          return const SignInPage();
        }),

    /// POPULAR FOOD PAGE
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        }),

    /// RECOMMENDED FOOD PAGE
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        }),

    /// CART PAGE
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        }),

    /// ADDRESS PAGE
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        }),

    /// PICK ADDRESS PAGE
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        }),

    /// PAYMENT PAGE
    GetPage(
      name: payment,
      page: () => PaymentPage(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),
        ),
      ),
    ),

    /// ORDER SUCCESS PAGE
    GetPage(
      name: orderSuccess,
      page: () => OrderSuccessPage(
        orderID: Get.parameters['id']!,
        status: Get.parameters['status'].toString().contains('success') ? 1 : 0,
      ),
    ),
  ];
}
