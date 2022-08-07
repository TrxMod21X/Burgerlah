part of 'widgets.dart';

class ProfileWidgets extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;

  const ProfileWidgets({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 1,
          ),
        ],
        color: AppColors.primaryWhite,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          bigText,
        ],
      ),
    );
  }
}
