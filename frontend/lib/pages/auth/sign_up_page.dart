part of '../pages.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    List<String> signUpImagesMethod = [
      'twitter.png',
      'facebook.png',
      'google.png',
    ];

    void _registrations(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
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
      } else if (phone.isEmpty) {
        showCustomMessage('Phone can\'t be empty', title: 'Phone');
      } else if (name.isEmpty) {
        showCustomMessage('Name can\'t be empty', title: 'Name');
      } else {
        SignUpBody signUpBody = SignUpBody(
          email: email,
          password: password,
          phone: phone,
          name: name,
        );
        authController.registration(signUpBody).then((value) {
          if (value.isSuccess) {
            log('Success registration');
            showCustomMessage(
              'Please wait while creating your account',
              title: 'Success',
              isError: false,
            );
            Future.delayed(const Duration(seconds: 3), () {
              Get.offAllNamed(RouteHelper.getInitial());
            });
          } else {
            showCustomMessage(value.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (controller) {
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

                      /// EMAIL FIELD
                      AppTextField(
                        emailController: emailController,
                        hint: 'Email',
                        icon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: Dimensions.height20),

                      /// PASSWORD FIELD
                      AppTextField(
                        emailController: passwordController,
                        hint: 'Password',
                        icon: Icons.password_sharp,
                        obscureText: true,
                      ),
                      SizedBox(height: Dimensions.height20),

                      /// PHONE FIELD
                      AppTextField(
                        emailController: phoneController,
                        hint: 'Phone',
                        icon: Icons.phone,
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(height: Dimensions.height20),

                      /// NAME FIELD
                      AppTextField(
                        emailController: nameController,
                        hint: 'Name',
                        icon: Icons.person,
                      ),
                      SizedBox(height: Dimensions.height20),

                      /// SIGN UP BUTTON
                      GestureDetector(
                        onTap: () {
                          _registrations(controller);
                        },
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
                              text: 'Sign Up',
                              size: Dimensions.font30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),

                      /// TEXT BUTTON HAVE ACCOUNT
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: 'Have an account already?',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),

                      /// TEXT SIGN UP OPTIONS
                      RichText(
                        text: TextSpan(
                          text: 'Sign up using one of the following methods',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),

                      /// SIGN UP METHOD
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => CircleAvatar(
                            radius: Dimensions.radius30,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              'assets/images/${signUpImagesMethod[index]}',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: LoadingAnimationWidget.beat(
                      color: AppColors.mainColor, size: 50),
                );
        },
      ),
    );
  }
}
