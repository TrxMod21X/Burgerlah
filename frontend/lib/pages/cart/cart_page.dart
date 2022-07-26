part of '../pages.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlackColor,
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20 * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    backgroundColor: Colors.orange,
                    iconColor: AppColors.mainBlackColor,
                    iconSize: Dimensions.icon24,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getInitial()),
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    backgroundColor: Colors.orange,
                    iconColor: AppColors.mainBlackColor,
                    iconSize: Dimensions.icon24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  backgroundColor: Colors.orange,
                  iconColor: AppColors.mainBlackColor,
                  iconSize: Dimensions.icon24,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: SizedBox(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    return ListView.builder(
                      itemCount: controller.getItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: Dimensions.height20 * 5,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: Dimensions.height15),
                          child: Row(
                            children: [
                              /// ITEM IMAGE
                              GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(controller
                                              .getItems[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, 'cartPage'));
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(controller
                                                .getItems[index].product!);
                                    if (recommendedIndex < 0) {
                                      Get.snackbar(
                                        'History Product',
                                        'Product review is not available for this product.',
                                        backgroundColor: AppColors.mainColor,
                                        colorText: Colors.white,
                                      );
                                    } else {
                                      Get.toNamed(
                                          RouteHelper.getRecommendedFood(
                                              recommendedIndex, 'cartPage'));
                                    }
                                  }
                                },
                                child: Container(
                                  width: Dimensions.height20 * 5,
                                  height: Dimensions.height20 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${AppConstant.baseUrl}/uploads/${controller.getItems[index].img}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width10),
                              Expanded(
                                child: SizedBox(
                                  height: Dimensions.height20 * 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text:
                                            '${controller.getItems[index].name}',
                                        color: Colors.black54,
                                      ),
                                      SmallText(text: 'Spicy'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text:
                                                '${controller.getItems[index].price}',
                                            color: Colors.redAccent,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                              left: Dimensions.width10,
                                              right: Dimensions.width10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                            ),
                                            child: Row(
                                              children: [
                                                /// ADD BUTTON
                                                GestureDetector(
                                                    onTap: () =>
                                                        controller.addItem(
                                                            controller
                                                                .getItems[index]
                                                                .product!,
                                                            -1),
                                                    child: const Icon(
                                                        Icons.remove,
                                                        color: AppColors
                                                            .signColor)),
                                                SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2),
                                                BigText(
                                                  text:
                                                      '${controller.getItems[index].quantity}',
                                                ),
                                                SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2),

                                                /// REMOVE BUTTON
                                                GestureDetector(
                                                  onTap: () =>
                                                      controller.addItem(
                                                          controller
                                                              .getItems[index]
                                                              .product!,
                                                          1),
                                                  child: const Icon(Icons.add,
                                                      color:
                                                          AppColors.signColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                       
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          GetBuilder<CartController>(builder: (controller) {
            return controller.getItems.isNotEmpty
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: SizedBox(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (controller) {
                            return ListView.builder(
                              itemCount: controller.getItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: Dimensions.height20 * 5,
                                  width: double.maxFinite,
                                  margin:
                                      EdgeInsets.only(top: Dimensions.height15),
                                  child: Row(
                                    children: [
                                      /// ITEM IMAGE
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(controller
                                                  .getItems[index].product!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, 'cartPage'));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(controller
                                                    .getItems[index].product!);
                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                'History Product',
                                                'Product review is not available for this product.',
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white,
                                              );
                                            } else {
                                              Get.toNamed(RouteHelper
                                                  .getRecommendedFood(
                                                      recommendedIndex,
                                                      'cartPage'));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  '${AppConstant.baseUrl}/uploads/${controller.getItems[index].img}'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      Expanded(
                                        child: SizedBox(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BigText(
                                                text:
                                                    '${controller.getItems[index].name}',
                                              ),
                                              SmallText(text: 'Spicy'),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        '${controller.getItems[index].price}',
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom:
                                                          Dimensions.height10,
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        /// ADD BUTTON
                                                        GestureDetector(
                                                            onTap: () =>
                                                                controller.addItem(
                                                                    controller
                                                                        .getItems[
                                                                            index]
                                                                        .product!,
                                                                    -1),
                                                            child: const Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .mainBlackColor)),
                                                        SizedBox(
                                                            width: Dimensions
                                                                    .width10 /
                                                                2),
                                                        BigText(
                                                          text:
                                                              '${controller.getItems[index].quantity}',
                                                        ),
                                                        SizedBox(
                                                            width: Dimensions
                                                                    .width10 /
                                                                2),

                                                        /// REMOVE BUTTON
                                                        GestureDetector(
                                                          onTap: () =>
                                                              controller.addItem(
                                                                  controller
                                                                      .getItems[
                                                                          index]
                                                                      .product!,
                                                                  1),
                                                          child: const Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .mainBlackColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const NoDataPage(text: 'Your cart is empty!');
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) => Container(
          height: Dimensions.height120,
          padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
          ),
          child: controller.getItems.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainBlackColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.width10 / 2),
                          BigText(text: 'Rp.${controller.totalAmount}'),
                          SizedBox(width: Dimensions.width10 / 2),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          if (Get.find<LocationController>()
                              .addressList
                              .isEmpty) {
                            Get.toNamed(RouteHelper.getAddressPage());
                          }else {
                            Get.offNamed(RouteHelper.getInitial());
                          }
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainBlackColor,
                        ),
                        child: BigText(
                          text: 'Checkout',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
