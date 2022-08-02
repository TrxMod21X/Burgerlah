part of '../data.dart';

class OrderRepo {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderModel placeOrder) async {
    return await apiClient.postData(
      AppConstant.placeOrderURI,
      placeOrder.toJson(),
    );
  }
}
