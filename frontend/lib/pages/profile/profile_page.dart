part of '../pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }

    return Scaffold(
      backgroundColor: AppColors.primaryDark,

      /// APP BAR
      appBar: _userLoggedIn ? const CustomAppBar(title: 'My Profile') : null,

      /// BODY
      body: GetBuilder<UserController>(builder: (controller) {
        return _userLoggedIn
            ? (!controller.isLoading
                ? const CustomLoader()
                : Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        /// PROFILE IMAGE
                        AppIcon(
                          icon: Icons.person,
                          iconColor: AppColors.primaryDark,
                          iconSize: Dimensions.icon15 * 5,
                          size: Dimensions.width10 * 15,
                          backgroundColor: AppColors.primaryWhite,
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
                                    iconColor: AppColors.primaryYellow,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.primaryDark,
                                  ),
                                  bigText: BigText(
                                    text: controller.userModel!.name,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                SizedBox(height: Dimensions.height20),

                                /// PROFILE PHONE
                                ProfileWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    iconColor: AppColors.primaryYellow,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.primaryDark,
                                  ),
                                  bigText: BigText(
                                    text: controller.userModel!.phone,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                SizedBox(height: Dimensions.height20),

                                /// PROFILE EMAIL
                                ProfileWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.email,
                                    iconColor: AppColors.primaryYellow,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.primaryDark,
                                  ),
                                  bigText: BigText(
                                    text: controller.userModel!.email,
                                    color: AppColors.primaryDark,
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
                                          iconColor: AppColors.primaryYellow,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.width10 * 5,
                                          backgroundColor:
                                              AppColors.primaryDark,
                                        ),
                                        bigText: BigText(
                                          text: 'Fill in your address',
                                          color: AppColors.primaryDark,
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
                                          iconColor: AppColors.primaryYellow,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.width10 * 5,
                                          backgroundColor:
                                              AppColors.primaryDark,
                                        ),
                                        bigText: BigText(
                                          text: 'Your address',
                                          color: AppColors.primaryDark,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                                SizedBox(height: Dimensions.height20),

                                /// PROFILE MESSAGES
                                ProfileWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.notifications_active,
                                    iconColor: AppColors.primaryYellow,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.width10 * 5,
                                    backgroundColor: AppColors.primaryDark,
                                  ),
                                  bigText: BigText(
                                    text: 'Messages',
                                    color: AppColors.primaryDark,
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
                                      iconColor: AppColors.primaryYellow,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.width10 * 5,
                                      backgroundColor: AppColors.primaryDark,
                                    ),
                                    bigText: BigText(
                                      text: 'Logout',
                                      color: AppColors.primaryDark,
                                    ),
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
