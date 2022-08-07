part of 'widgets.dart';

class PaymentOptionsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;

  const PaymentOptionsButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      bool _selected = controller.paymentIndex == index;
      return InkWell(
        onTap: () => controller.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius10 / 2),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 5,
                spreadRadius: 1,
              )
            ],
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: Dimensions.width10 * 4,
              color: _selected
                  ? AppColors.mainColor
                  : Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: robotoMedium.copyWith(
                fontSize: Dimensions.font20,
              ),
            ),
            subtitle: Text(
              subTitle,
              style: robotoRegular.copyWith(
                fontSize: Dimensions.font12,
                color: Theme.of(context).disabledColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: _selected
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  )
                : const SizedBox(),
          ),
        ),
      );
    });
  }
}
