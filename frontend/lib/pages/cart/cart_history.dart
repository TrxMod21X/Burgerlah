part of '../pages.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Column(
        children: [
          /// APP BAR
          Container(
            color: AppColors.primaryWhite,
            width: double.maxFinite,
            height: Dimensions.height20 * 5,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: AppColors.primaryDark,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getCartPage()),
                  child: const AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.primaryWhite,
                    backgroundColor: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),

          /// HISTORY ITEM LIST
          GetBuilder<CartController>(builder: (controller) {
            return controller.getCartHistoryList().isNotEmpty
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimensions.height120,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// DATE ITEM
                                    timeWidget(listCounter),
                                    SizedBox(height: Dimensions.height10),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        /// IMAGE ITEM
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                            itemsPerOrder[i],
                                            (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      width:
                                                          Dimensions.width20 *
                                                              4,
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                                  .width10 /
                                                              2),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            '${AppConstant.baseUrl}/uploads/${getCartHistoryList[listCounter - 1].img}',
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                        ),

                                        /// ITEM INFO
                                        SizedBox(
                                          height: Dimensions.height20 * 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SmallText(
                                                text: 'Total',
                                                color: AppColors.titleColor,
                                              ),
                                              BigText(
                                                text:
                                                    '${itemsPerOrder[i]} items',
                                                color: AppColors.titleColor,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () =>
                                                            CartModel.fromJson(
                                                          jsonDecode(
                                                            jsonEncode(
                                                              getCartHistoryList[
                                                                  j],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width10,
                                                    vertical:
                                                        Dimensions.height5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.radius15 / 3,
                                                    ),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                  child: SmallText(
                                                    text: 'one more',
                                                    color: AppColors.mainColor,
                                                  ),
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
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const NoDataPage(
                        text: 'You didn\'t buy anything so far !'));
          }),
        ],
      ),
    );
  }
}
