part of '../pages.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final double rating;
  final String page;

  const PopularFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${AppConstant.baseUrl}/uploads/${product.img!}',
                  ),
                ),
              ),
            ),
          ),

          /// ICON WIDGETS
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == 'cartPage') {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<PopularProductController>(
                  builder: ((controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (controller.totalItems >= 1) {
                              Get.toNamed(RouteHelper.getCartPage());
                            } else {
                              showCustomMessage(
                                'Keranjang anda kosong',
                                title: 'Burgerlah',
                                isError: false,
                              );
                            }
                          },
                          child:
                              const AppIcon(icon: Icons.shopping_cart_outlined),
                        ),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: Dimensions.width20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.primaryDark,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: Dimensions.font12,
                                  color: AppColors.primaryWhite,
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),

          /// INTRODUCTION OF FOOD
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            top: Dimensions.height350 - 20,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                color: AppColors.secondaryDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name!,
                    rating: rating,
                    fontSize: Dimensions.font26,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: 'Introduce'),

                  /// EXPANDABLE TEXT
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: product.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
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
          child: Row(
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
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Row(children: [
                  GestureDetector(
                      onTap: () => controller.setQuantity(false),
                      child:
                          const Icon(Icons.remove, color: AppColors.signColor)),
                  SizedBox(width: Dimensions.width10 / 2),
                  BigText(text: '${controller.inCartItems}'),
                  SizedBox(width: Dimensions.width10 / 2),
                  GestureDetector(
                      onTap: () => controller.setQuantity(true),
                      child: const Icon(Icons.add, color: AppColors.signColor)),
                ]),
              ),
              GestureDetector(
                onTap: () => controller.addItem(product),
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainBlackColor,
                  ),
                  child: BigText(
                    text: 'Rp.${product.price!} | Add to cart',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
