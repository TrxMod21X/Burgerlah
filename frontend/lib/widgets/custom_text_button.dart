part of 'widgets.dart';

class CustomTextButton extends StatelessWidget {
  final String title;

  const CustomTextButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.height20,
        bottom: Dimensions.height20,
        left: Dimensions.width10,
        right: Dimensions.width10,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10,
            color: AppColors.mainBlackColor.withOpacity(0.3),
          ),
        ],
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.primaryDark,
      ),
      child: Center(
        child: BigText(
          text: title,
          color: AppColors.primaryWhite,
        ),
      ),
    );
  }
}
