part of '../pages.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;

  const PaymentSuccessPage(
      {Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        // Get.dialog(PaymentDialogFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                status == 1
                    ? Icons.check_circle_outline_outlined
                    : Icons.warning_amber_outlined,
                size: 100,
                color: AppColors.mainColor,
              ),
              SizedBox(height: Dimensions.height30),
              Text(
                status == 1
                    ? 'You placed the order successfully'
                    : 'Your order failed',
                style: TextStyle(fontSize: Dimensions.font20),
              ),
              SizedBox(height: Dimensions.height20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height20,
                ),
                child: Text(
                  status == 1 ? 'Successful order' : 'Failed Order',
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    color: Theme.of(context).disabledColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: CustomButton(
                  buttonText: 'Back to Home',
                  onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
