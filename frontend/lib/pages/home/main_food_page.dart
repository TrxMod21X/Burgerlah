part of '../pages.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _onRefresh() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        backgroundColor: AppColors.primaryDark,
        color: AppColors.primaryWhite,
        child: Column(
          children: [
            /// HEADER
            Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: 'Indonesia',
                        color: AppColors.primaryWhite,
                        size: Dimensions.font30,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: 'Banda Aceh',
                            color: AppColors.primaryWhite,
                          ),
                          const Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: AppColors.primaryDark,
                        size: Dimensions.icon24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  )
                ],
              ),
            ),

            /// BODY
            const Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
