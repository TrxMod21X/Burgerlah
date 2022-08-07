part of 'widgets.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = AppColors.primaryWhite,
    this.iconColor = AppColors.primaryDark,
    this.size = 40,
    this.iconSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize ,
        ),
      ),
    );
  }
}
