part of 'widgets.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    log('${widget.text.length}');
    log('$textHeight');
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
    log(firstHalf);
    log(secondHalf);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimensions.font16,
              color: AppColors.paraColor,
              height: 1.8,
            )
          : Column(
              children: [
                // Text(
                //   hiddenText ? ('$firstHalf ....') : ('$firstHalf $secondHalf'),
                // ),
                SmallText(
                  text: hiddenText
                      ? (firstHalf + '...')
                      : (firstHalf + secondHalf),
                  size: Dimensions.font16,
                  color: AppColors.paraColor,
                  height: 1.5,
                  overflow: TextOverflow.visible,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? 'Show more...' : 'Show less...',
                        color: AppColors.primaryYellow,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.primaryYellow,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
