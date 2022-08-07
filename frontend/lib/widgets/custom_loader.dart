part of 'widgets.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.beat(color: AppColors.mainColor, size: 50),
    );
  }
}
