import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/controllers.dart';
import 'package:food_delivery/pages/pages.dart';
import 'package:food_delivery/routes/routes.dart';
import 'package:get/get.dart';
import 'helpers/helpers.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              title: 'Food Market App',
              defaultTransition: Transition.zoom,
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,
              // home: SignInPage(),
            );
          },
        );
      },
    );
  }
}
