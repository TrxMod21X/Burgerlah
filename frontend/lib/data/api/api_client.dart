part of '../data.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstant.token) ?? AppConstant.token;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8 ',
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8 ',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(
        uri,
        headers: headers ?? _mainHeaders,
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    log('dari post data api client');
    log(body.toString());
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      // log(response.toString());
      return response;
    } catch (e) {
      log(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
