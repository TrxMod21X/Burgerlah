part of '../data.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstant.cartList, cart);
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstant.cartList)) {
      carts = sharedPreferences.getStringList(AppConstant.cartList)!;
    }

    List<CartModel> cartList = [];

    carts.forEach(
      (element) => cartList.add(
        CartModel.fromJson(
          jsonDecode(element),
        ),
      ),
    );

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.cartHistoryList)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstant.cartHistoryList)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach(
      (element) => cartListHistory.add(
        CartModel.fromJson(
          jsonDecode(element),
        ),
      ),
    );

    return cartListHistory;

  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.cartHistoryList)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstant.cartHistoryList)!;
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    cart = [];
    sharedPreferences.setStringList(AppConstant.cartHistoryList, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstant.cartList);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstant.cartHistoryList);
  }

  void removeCartSharedPrefference() {
    sharedPreferences.remove(AppConstant.cartList);
    sharedPreferences.remove(AppConstant.cartHistoryList);
  }
}
