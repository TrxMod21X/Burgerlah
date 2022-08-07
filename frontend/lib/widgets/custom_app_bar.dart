part of 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButtonEnabled;
  final Function? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backButtonEnabled = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(text: title, color: AppColors.primaryDark),
      centerTitle: true,
      backgroundColor: AppColors.primaryWhite,
      leading: backButtonEnabled
          ? IconButton(
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pushReplacementNamed(context, '/initial'),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryDark,
              ),
            )
          : const SizedBox(),
    );
  }

  @override
  Size get preferredSize =>
      Size(Dimensions.screenWidth, Dimensions.height10 * 6);
}
