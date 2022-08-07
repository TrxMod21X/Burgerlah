part of '../pages.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double? _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// SLIDER MENU SECTION
        GetBuilder<PopularProductController>(
          builder: (controller) => controller.isLoaded
              ? SizedBox(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: controller.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(
                          position, controller.popularProductList[position]);
                    },
                  ),
                )
              : const CircularProgressIndicator(color: Colors.orange),
        ),

        /// DOTS SECTION
        GetBuilder<PopularProductController>(
          builder: (controller) => DotsIndicator(
            dotsCount: controller.popularProductList.isEmpty
                ? 1
                : controller.popularProductList.length,
            position: _currPageValue!,
            decorator: DotsDecorator(
              activeColor: AppColors.primaryYellow,
              color: AppColors.dotColor,
              size: const Size.square(9),
              activeSize: const Size(18, 9),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
              ),
            ),
          ),
        ),

        /// POPULAR TEXT
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height3),
                child: BigText(text: '.', color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height2),
                child: SmallText(text: 'Food pairing'),
              )
            ],
          ),
        ),

        /// RECOMMENDED FOOD
        /// LIST OF FOOD AND IMAGES
        GetBuilder<RecommendedProductController>(
          builder: (controller) => controller.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.recommendedProductList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Get.toNamed(
                        RouteHelper.getRecommendedFood(index, 'home')),
                    child: Container(
                      margin: EdgeInsets.only(
                        right: Dimensions.width20,
                        left: Dimensions.width20,
                        bottom: Dimensions.height10,
                      ),
                      child: Row(children: [
                        /// IMAGE SECTION
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.darkerDark,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${AppConstant.baseUrl}/uploads/${controller.recommendedProductList[index].img}',
                              ),
                            ),
                          ),
                        ),

                        /// TEXT CONTAINER
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20),
                              ),
                              color: AppColors.darkerDark,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: controller
                                        .recommendedProductList[index].name!,
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  SmallText(
                                    text: controller
                                        .recommendedProductList[index]
                                        .description!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconAndText(
                                        icon: Icons.circle,
                                        text: 'Normal',
                                        itemColor: AppColors.iconColor1,
                                      ),
                                      IconAndText(
                                        icon: Icons.location_on,
                                        text: '1.7km',
                                        itemColor: AppColors.mainColor,
                                      ),
                                      IconAndText(
                                        icon: Icons.access_time_rounded,
                                        text: '32 min',
                                        itemColor: AppColors.iconColor2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              : const CircularProgressIndicator(color: Colors.orange),
        )
      ],
    );
  }

  Widget _buildPageItem(int position, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (position == _currPageValue!.floor()) {
      double currScale = 1 - (_currPageValue! - position) * (1 - _scaleFactor);
      double currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue!.floor() + 1) {
      double currScale =
          _scaleFactor + (_currPageValue! - position + 1) * (1 - _scaleFactor);
      double currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue!.floor() - 1) {
      double currScale = 1 - (_currPageValue! - position) * (1 - _scaleFactor);
      double currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      double currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(RouteHelper.getPopularFood(
              position,
              'home',
              popularProduct.stars!.toDouble(),
            )),
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      '${AppConstant.baseUrl}/uploads/${popularProduct.img!}'),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.secondaryDark,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.secondaryWhite,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: AppColors.secondaryWhite,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: AppColors.secondaryWhite,
                    offset: Offset(5, 0),
                  )
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.width15,
                  right: Dimensions.width15,
                ),
                child: AppColumn(
                  text: popularProduct.name!,
                  rating: popularProduct.stars!.toDouble(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
