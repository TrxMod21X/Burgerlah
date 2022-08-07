part of '../pages.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;

  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (controller) {
        if (!controller.isLoading) {
          late List<OrderModel> orderList;

          if (controller.currentOrderList.isNotEmpty) {
            orderList = isCurrent
                ? controller.currentOrderList.reversed.toList()
                : controller.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
                vertical: Dimensions.height10,
              ),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID: #${orderList[index].id}',
                                    style: robotoRegular.copyWith(
                                        fontSize: Dimensions.font12),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(
                                          '${orderList[index].orderStatus}',
                                          style: robotoMedium.copyWith(
                                            fontSize: Dimensions.font12,
                                            color: Theme.of(context).cardColor,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width10,
                                          vertical: Dimensions.height5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius10 / 2),
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.height10 / 2),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.height5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius10 / 2),
                                            border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/tracking.png',
                                                height: Dimensions.height15,
                                                width: Dimensions.width15,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              SizedBox(
                                                  width: Dimensions.width5),
                                              Text(
                                                'Track Order',
                                                style: robotoMedium.copyWith(
                                                  fontSize: Dimensions.font12,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.height10),
                          ],
                        ));
                  }),
            ),
          );
        } else {
          return const CustomLoader();
        }
      }),
    );
  }
}
