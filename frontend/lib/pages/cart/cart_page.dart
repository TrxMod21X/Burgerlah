part of '../pages.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          /// TOP BAR ICON BUTTON
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
                    iconSize: Dimensions.icon24,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getInitial()),
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconSize: Dimensions.icon24,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(const CartHistory()),
                  child: AppIcon(
                    icon: Icons.history,
                    iconSize: Dimensions.icon24,
                  ),
                ),
              ],
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
                                return Slidable(
                                  // key: const ValueKey(0),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dismissible:
                                        DismissiblePane(onDismissed: () {}),
                                    children: [
                                      // A SlidableAction can have an icon and/or a label.
                                      SlidableAction(
                                        onPressed: (context) {
                                          log('${controller.items}');
                                        },
                                        backgroundColor: AppColors.primaryRed,
                                        foregroundColor: AppColors.primaryWhite,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          log('${controller.getItems[index].product!}');
                                        },
                                        backgroundColor: AppColors.primaryRed,
                                        foregroundColor: AppColors.primaryWhite,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    height: Dimensions.height20 * 5,
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height15),
                                    child: Row(
                                      children: [
                                        /// ITEM IMAGE
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .isPopularProduct(controller
                                                    .getItems[index]
                                                    .product!
                                                    .name!);

                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .isRecommendedProduct(controller
                                                    .getItems[index]
                                                    .product!
                                                    .name!);

                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                popularIndex,
                                                'cartPage',
                                                2.0,
                                              ));
                                            } else if (recommendedIndex >= 0) {
                                              Get.toNamed(RouteHelper
                                                  .getRecommendedFood(
                                                recommendedIndex,
                                                'cartPage',
                                              ));
                                            } else {
                                              Get.snackbar(
                                                'History Product',
                                                'Product review is not available for this product.',
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white,
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.transparent,
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
                                                SmallText(
                                                  text:
                                                      '${controller.getItems[index].product!.description}',
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text:
                                                          '${controller.getItems[index].price}',
                                                      color:
                                                          AppColors.primaryRed,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryWhite,
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
                                                                  .primaryDark,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          BigText(
                                                            text:
                                                                '${controller.getItems[index].quantity}',
                                                            color: AppColors
                                                                .primaryDark,
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
                                                                  .primaryDark,
                                                            ),
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
      bottomNavigationBar:
          GetBuilder<OrderController>(builder: (orderController) {
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(
          builder: (controller) => Container(
            height: Dimensions.height120 + Dimensions.height45,
            padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height10,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: controller.getItems.isNotEmpty
                ? Column(
                    children: [
                      InkWell(
                        onTap: () => showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          elevation: 3,
                          context: context,
                          builder: (_) {
                            return Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: Dimensions.screenHeight,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryWhite,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              Dimensions.radius20),
                                          topRight: Radius.circular(
                                              Dimensions.radius20),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 520,
                                            padding: EdgeInsets.only(
                                              left: Dimensions.width20,
                                              right: Dimensions.width20,
                                              top: Dimensions.height20,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const PaymentOptionsButton(
                                                  icon: Icons.money,
                                                  title: 'Cash on Delivery',
                                                  subTitle:
                                                      'you pay after getting the delivery',
                                                  index: 0,
                                                ),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height10),
                                                const PaymentOptionsButton(
                                                  icon: Icons.atm,
                                                  title: 'Digital Payment',
                                                  subTitle:
                                                      'saver and faster way payment',
                                                  index: 1,
                                                ),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height30),
                                                Text(
                                                  'Delivery Options',
                                                  style: robotoMedium.copyWith(
                                                      fontSize:
                                                          Dimensions.font20),
                                                ),
                                                SizedBox(
                                                    height: Dimensions.height5),
                                                DeliveryOption(
                                                  title: 'Home Delivery',
                                                  value: 'delivery',
                                                  amount:
                                                      Get.find<CartController>()
                                                          .totalAmount,
                                                  isFree: false,
                                                ),
                                                SizedBox(
                                                    height: Dimensions.height5),
                                                DeliveryOption(
                                                  title: 'Take Away',
                                                  value: 'take away',
                                                  amount:
                                                      Get.find<CartController>()
                                                          .totalAmount,
                                                  isFree: true,
                                                ),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height20),
                                                Text(
                                                  'Additional Notes',
                                                  style: robotoMedium.copyWith(
                                                      fontSize:
                                                          Dimensions.font20),
                                                ),
                                                SizedBox(
                                                    height: Dimensions.height5),
                                                AppTextField(
                                                  textController:
                                                      _noteController,
                                                  hint: '',
                                                  maxLines: true,
                                                  icon: Icons.note,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).whenComplete(
                          () => orderController.setFoodNote(
                            _noteController.text.trim(),
                          ),
                        ),
                        child: const SizedBox(
                          width: double.maxFinite,
                          child: CustomTextButton(title: 'Payment Options'),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
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
                              color: AppColors.primaryDark,
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
                                } else {
                                  var location = Get.find<LocationController>()
                                      .getUserAddress();
                                  var cart =
                                      Get.find<CartController>().getItems;
                                  var user =
                                      Get.find<UserController>().userModel;
                                  log('');

                                  PlaceOrderModel placeOrder = PlaceOrderModel(
                                    cart: cart,
                                    orderAmount: 100.0,
                                    orderNote: orderController.foodNote,
                                    address: location.address,
                                    latitude: location.latitude,
                                    longitude: location.longitude,
                                    contactPersonName: user!.name,
                                    contactPersonNumber: user.phone,
                                    scheduleAt: '',
                                    distance: 10.0,
                                    paymentMethod:
                                        orderController.paymentIndex == 0
                                            ? 'cash_on_delivery'
                                            : 'digital_payment',
                                    orderType: orderController.orderType,
                                  );
                                  // log('type is ${placeOrder.toJson()['order_type']}');
                                  // log('method is ${placeOrder.toJson()['payment_method']}');
                                  // log('method is ${placeOrder.toJson()['order_note']}');
                                  // return;

                                  Get.find<OrderController>()
                                      .placeOrder(placeOrder, _callback);
                                }
                              } else {
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                            },
                            child: const CustomTextButton(title: 'Checkout'),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        );
      }),
    );
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPrefference();
      Get.find<CartController>().addToHistory();

      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, 'Success'));
      } else {
        Get.offNamed(
          RouteHelper.getPaymentPage(
            orderID,
            Get.find<UserController>().userModel!.id,
          ),
        );
      }
    } else {
      showCustomMessage(message);
    }
  }
}
