part of '../pages.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (widget.fromAddress) {}
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(5.553748073318983, 95.31733045170478);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']),
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  /// MAP VIEW
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>()
                          .updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController) {
                      _mapController = mapController;
                      if (!widget.fromAddress) {}
                    },
                  ),

                  /// PICK POINT
                  Center(
                    child: !controller.loading
                        ? Image.asset(
                            'assets/images/pick_marker.png',
                            height: 50,
                            width: 50,
                          )
                        : LoadingAnimationWidget.beat(
                            color: AppColors.mainColor, size: 50),
                  ),

                  /// ADDRESS INFO
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: InkWell(
                      onTap: () => Get.dialog(
                          SearchLocationModal(mapController: _mapController)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20 / 2),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 25,
                              color: AppColors.mainColor,
                            ),
                            Expanded(
                              child: Text(
                                '${controller.pickPlaceMark.name}',
                                style: TextStyle(fontSize: Dimensions.font16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: Dimensions.width10),
                            const Icon(
                              Icons.search,
                              size: 25,
                              color: AppColors.mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// CHOOSE ADDRESS BUTTON
                  Positioned(
                    bottom: 80,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: controller.isLoading
                        ? LoadingAnimationWidget.beat(
                            color: AppColors.mainColor, size: 50)
                        : CustomButton(
                            buttonText: controller.inZone
                                ? widget.fromAddress
                                    ? 'Pick Address'
                                    : 'Pick Location'
                                : 'Service is not available in your area',
                            onPressed: (controller.buttonDisabled ||
                                    controller.loading)
                                ? null
                                : () {
                                    if (controller.pickPosition.latitude != 0 &&
                                        controller.pickPlaceMark.name != null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          widget.googleMapController!
                                              .moveCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(
                                                  controller
                                                      .pickPosition.latitude,
                                                  controller
                                                      .pickPosition.longitude,
                                                ),
                                              ),
                                            ),
                                          );
                                          controller.setAddAddressData();
                                        }
                                        Get.toNamed(
                                            RouteHelper.getAddressPage());
                                      }
                                    }
                                  },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
