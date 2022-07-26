part of '../pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      backgroundColor: AppColors.mainBlackColor,

      /// APP BAR
      appBar: _userLoggedIn
          ? AppBar(
              backgroundColor: Colors.orange,
              title: BigText(
                text: 'Profile',
                size: Dimensions.font12 * 2,
                color: Colors.white,
              ),
            )
          : null,

      /// BODY
      body: GetBuilder<UserController>(builder: (controller) {
        return _userLoggedIn
            ? (!controller.isLoading
                ? Center(
                    child: LoadingAnimationWidget.beat(
                        color: AppColors.mainColor, size: 50))
                : Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        /// PROFILE IMAGE
                        AppIcon(
                          icon: Icons.person,
                          iconColor: AppColors.mainBlackColor,
                          iconSize: Dimensions.icon15 * 5,
                          size: Dimensions.width10 * 15,
                          backgroundColor: Colors.orange,
                        ),
                        SizedBox(height: Dimensions.height30),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                /// PROFILE NAME
                                ProfileWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    iconColor: Colors.orange,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.mainBlackColor,
                                  ),
                                  bigText:
                                      BigText(text: controller.userModel!.name),
                                ),
                                SizedBox(height: Dimensions.height20),

                                /// PROFILE PHONE
                                ProfileWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.yellowColor,
                                  ),
                                  bigText: BigText(
                                      text: controller.userModel!.phone),
                                ),
                                SizedBox(height: Dimensions.height20),

                                /// PROFILE EMAIL
                                ProfileWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.email,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.yellowColor,
                                  ),
                                  bigText: BigText(
                                    text: controller.userModel!.email,
                                  ),
                                ),
                                SizedBox(height: Dimensions.height20),

                                /// PROFILE ADDRESS
                                GetBuilder<LocationController>(
                                    builder: (controller) {
                                  if (_userLoggedIn &&
                                      controller.addressList.isEmpty) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getAddressPage());
                                      },
                                      child: ProfileWidgets(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.width10 * 5,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                        ),
                                        bigText: BigText(
                                          text: 'Fill in your address',
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getAddressPage());
                                      },
                                      child: ProfileWidgets(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.width10 * 5,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                        ),
                                        bigText: BigText(
                                          text: 'Your address',
                                        ),
                                      ),
                                    );
                                  }
                                }),
                                SizedBox(height: Dimensions.height20),

                                /// PROFILE MESSAGES
                                ProfileWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.message,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.yellowColor,
                                  ),
                                  bigText: BigText(
                                    text: 'Messages',
                                  ),
                                ),
                                SizedBox(height: Dimensions.height20),

                                /// LOGOUT BUTTON
                                GestureDetector(
                                  onTap: () {
                                    if (_userLoggedIn) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.find<LocationController>()
                                          .clearAddressList();
                                      Get.offAllNamed(
                                          RouteHelper.getSplashPage());
                                    }
                                  },
                                  child: ProfileWidgets(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.width10 * 5,
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    bigText: BigText(text: 'Logout'),
                                  ),
                                ),
                                SizedBox(height: Dimensions.height20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            : SizedBox(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 20,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          image: const DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/splash.png'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.getSignInPage()),
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Sign In',
                              color: Colors.white,
                              size: Dimensions.font26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
