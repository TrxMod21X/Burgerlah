part of 'controllers.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  final Placemark _placemark = Placemark();
  final Placemark _pickPlacemark = Placemark();
  final List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  final List<String> _addressTypeList = ['hone', 'office', 'others'];
  final int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;
  late GoogleMapController _mapController;
  final bool _updateAddressData = true;
  final bool _changeAddress = true;

  List<AddressModel> get addressList => _addressList;
  Map get getAddress => _getAddress;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlacemark;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude,
            ),
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = '127.0.0.1';
    Response response = await locationRepo.getAddressFromGeoCode(latLng);
    print('${response.body['status']}');
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
      print('printing address $_address');
    } else {
      print('error getting the google api');
    }

    return _address;
  }
}
