part of 'widgets.dart';

class DeliveryOption extends StatelessWidget {
  final String value;
  final String title;
  final int amount;
  final bool isFree;

  const DeliveryOption({
    Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: controller.orderType,
            onChanged: (String? value) => controller.setDeliveryType(value!),
            activeColor: Theme.of(context).primaryColor,
          ),
          SizedBox(width: Dimensions.width10),
          Text(
            title,
            style: robotoRegular.copyWith(
              fontSize: Dimensions.font16,
            ),
            maxLines: 1,
          ),
          SizedBox(width: Dimensions.width10),
          Text(
            '(${(value == 'take away' || isFree) ? 'Free' : 'Rp.${amount ~/ 10}'})',
            style: robotoMedium.copyWith(
              fontSize: Dimensions.font16,
            ),
            maxLines: 1,
          ),
        ],
      );
    });
  }
}
