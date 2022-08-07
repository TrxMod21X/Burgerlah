part of 'controllers.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  bool _isLoading = false;
  int _paymentIndex = 0;
  String _orderType = 'delivery';
  String _foodNote = '';
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  bool get isLoading => _isLoading;
  int get paymentIndex => _paymentIndex;
  String get orderType => _orderType;
  String get foodNote => _foodNote;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  Future<void> placeOrder(PlaceOrderModel placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callback(true, message, orderID);
    } else {
      callback(false, response.body.toString(), '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    update();

    Response response = await orderRepo.getOrderList();

    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];

      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);

        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up') {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }

    _isLoading = false;
    update();
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _orderType = type;
    update();
  }

  void setFoodNote(String note) {
    _foodNote = note;
  }
}
