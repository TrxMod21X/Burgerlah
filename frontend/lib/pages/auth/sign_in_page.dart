part of '../pages.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomMessage('Email can\'t be empty', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomMessage('Email not valid', title: 'Email');
      } else if (password.isEmpty) {
        showCustomMessage('Password can\'t be empty', title: 'Password');
      } else if (password.length < 6) {
        showCustomMessage('Password can\'t be less than 6 character',
            title: 'Password');
      } else {
        authController.login(email, password).then((value) {
          if (value.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomMessage(value.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: ((controller) {
          return !controller.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      /// APP LOGO
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.25,
                        child: const Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              'assets/images/app-icon.png',
                            ),
                          ),
                        ),
                      ),

                      /// HELLO TEXT
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            bottom: Dimensions.height20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                fontSize: Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Sign into your account',
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// EMAIL FIELD
                      AppTextField(
                        textController: emailController,
                        hint: 'Email',
                        icon: Icons.email,
                      ),
                      SizedBox(height: Dimensions.height20),

                      /// PASSWORD FIELD
                      AppTextField(
                        textController: passwordController,
                        hint: 'Password',
                        icon: Icons.password_sharp,
                        obscureText: true,
                      ),
                      SizedBox(height: Dimensions.height20),

                      /// TEXT SIGN INTO YOUR ACCOUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Sign into your account',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width20),
                        ],
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),

                      /// SIGN IN BUTTON
                      GestureDetector(
                        onTap: () => _login(controller),
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Sign In',
                              size: Dimensions.font30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),

                      /// TEXT SIGN UP OPTIONS
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Get.to(() => const SignUpPage()),
                              text: 'Create',
                              style: TextStyle(
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.height5),
                    ],
                  ),
                )
              : Center(
                  child: LoadingAnimationWidget.beat(
                      color: AppColors.mainColor, size: 50),
                );
        }),
      ),
    );
  }
}
