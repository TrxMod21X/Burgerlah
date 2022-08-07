part of '../pages.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(5.553748073318983, 95.31733045170478),
    zoom: 14.4746,
  );
  late LatLng _initialPosition = LatLng(5.553748073318983, 95.31733045170478);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();

    // log(Get.find<LocationController>().addressList.first.address);

    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          '') {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();

      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']),
        ),
      );

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );

      // log(Get.find<LocationController>().getAddress.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlackColor,

      /// APPBAR
      appBar: CustomAppBar(
        title: 'My Address',
        onBackPressed: () => Get.back(),
      ),

      /// BODY
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel?.name}';
            _contactPersonNumber.text = '${userController.userModel?.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(builder: (controller) {
            _addressController.text = '${controller.placeMark.name ?? ''}'
                '${controller.placeMark.locality ?? ''}'
                '${controller.placeMark.postalCode ?? ''}'
                '${controller.placeMark.country ?? ''}';

            // print('address in my view is ${_addressController.text}');

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// MAPS VIEW
                  Container(
                    height: Dimensions.height120 + Dimensions.height30,
                    width: Dimensions.screenWidth,
                    margin: EdgeInsets.only(
                      left: Dimensions.width5,
                      right: Dimensions.width5,
                      top: Dimensions.width5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      border: Border.all(
                        width: 2,
                        color: Colors.orange,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height2 * 3),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _initialPosition,
                              zoom: 17,
                            ),
                            onTap: (latlng) {
                              Get.toNamed(
                                RouteHelper.getPickAddressPage(),
                                arguments: PickAddressMap(
                                  fromSignup: false,
                                  fromAddress: true,
                                  googleMapController:
                                      controller.googleMapController,
                                ),
                              );
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              controller.updatePosition(_cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController mapController) {
                              controller.setMapController(mapController);
                              if (Get.find<LocationController>()
                                  .addressList
                                  .isEmpty) {}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ADDRESS TYPE CATEGORY
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, top: Dimensions.height20),
                    child: SizedBox(
                      height: Dimensions.height45 + Dimensions.height5,
                      child: ListView.builder(
                          itemCount: controller.addressTypeList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.setAddressTypeIndex(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.height20,
                                  vertical: Dimensions.height10,
                                ),
                                margin:
                                    EdgeInsets.only(right: Dimensions.width10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius10 / 2),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.orange,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color: controller.addressTypeIndex == index
                                      ? Colors.orange
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),

                  /// ADDRESS FIELD
                  SizedBox(height: Dimensions.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height20),
                    child: BigText(text: 'Delivery Address'),
                  ),
                  SizedBox(height: Dimensions.height10),
                  AppTextField(
                      textController: _addressController,
                      hint: 'Your Address',
                      icon: Icons.map),

                  /// NAME FIELD
                  SizedBox(height: Dimensions.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height20),
                    child: BigText(text: 'Contact Name'),
                  ),
                  SizedBox(height: Dimensions.height10),
                  AppTextField(
                      textController: _contactPersonName,
                      hint: 'Name',
                      icon: Icons.person),

                  /// NUMBER FIELD
                  SizedBox(height: Dimensions.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height20),
                    child: BigText(text: 'Contact Phone'),
                  ),
                  SizedBox(height: Dimensions.height10),
                  AppTextField(
                      textController: _contactPersonNumber,
                      hint: 'Phone',
                      icon: Icons.phone),
                  SizedBox(height: Dimensions.height20),
                ],
              ),
            );
          });
        },
      ),

      /// BOTTOM NAV BAR
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (controller) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height20 * 7,
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AddressModel _addressModel = AddressModel(
                        addressType: controller
                            .addressTypeList[controller.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude: controller.position.latitude.toString(),
                        longitude: controller.position.longitude.toString(),
                      );
                      controller.addAddress(_addressModel).then((response) {
                        if (response.isSuccess) {
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar('Address', 'Added Successfully');
                        } else {
                          Get.snackbar('Address', 'Couldn\'t save address');
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainBlackColor,
                      ),
                      child: BigText(
                        text: 'Save address',
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
