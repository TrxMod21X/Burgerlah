part of 'widgets.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double fontSize;
  const AppColumn({
    Key? key,
    required this.text,
    this.fontSize = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: fontSize==0 ? Dimensions.font20 : fontSize,),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.icon15,
                ),
              ),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: '4.5'),
            SizedBox(width: Dimensions.width10),
            SmallText(text: '1287'),
            SizedBox(width: Dimensions.width5),
            SmallText(text: 'Comments'),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndText(
              icon: Icons.circle,
              text: 'Normal',
              itemColor: AppColors.iconColor1,
            ),
            IconAndText(
              icon: Icons.location_on,
              text: '1.7km',
              itemColor: AppColors.mainColor,
            ),
            IconAndText(
              icon: Icons.access_time_rounded,
              text: '32 min',
              itemColor: AppColors.iconColor2,
            )
          ],
        )
      ],
    );
  }
}
