part of 'widgets.dart';

class AppTextField extends StatelessWidget {

  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController textController;
  
  const AppTextField({
    Key? key,
    required this.textController,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        keyboardType: textInputType,
        controller: textController,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon:  Icon(
            icon,
            color: Colors.orange,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
