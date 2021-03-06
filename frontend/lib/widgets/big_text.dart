part of 'widgets.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({
    Key? key,
    this.color = Colors.white,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}
