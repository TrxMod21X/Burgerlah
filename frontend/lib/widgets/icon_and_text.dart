part of 'widgets.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color itemColor;

  const IconAndText({
    Key? key,
    required this.icon,
    required this.text,
    required this.itemColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: itemColor,
          size: Dimensions.icon24,
        ),
        const SizedBox(width: 5),
        SmallText(text: text),
      ],
    );
  }
}
