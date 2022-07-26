part of '../data.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeoCode(LatLng latlng) async {
    return await apiClient.getData(
      '${AppConstant.geocodeUri}?lat=${latlng.latitude}&lng=${latlng.longitude}',
    );
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstant.userAddress) ?? '';
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstant.addUserAddress, addressModel.toJson());
  }

  Future<Response> getAllAdress() async {
    return await apiClient.getData(AppConstant.addressListURI);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstant.token)!);
    return await sharedPreferences.setString(AppConstant.userAddress, address);
  }
}
