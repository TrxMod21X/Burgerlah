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
}
