part of '../pages.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel orderModel;

  const PaymentPage({Key? key, required this.orderModel}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl =
        '${AppConstant.baseUrl}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}';
    log('payment_page.dart: $selectedUrl');
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Payment"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Center(
          child: SizedBox(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: selectedUrl,
                  gestureNavigationEnabled: true,
                  userAgent:
                      'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.future
                        .then((value) => controllerGlobal = value);
                    _controller.complete(webViewController);
                    //_controller.future.catchError(onError)
                  },
                  onProgress: (int progress) {
                    log("payment_page.dart: WebView is loading (progress : $progress%)");
                  },
                  onPageStarted: (String url) {
                    log('payment_page.dart: Page started loading: $url');
                    setState(() {
                      _isLoading = true;
                    });
                    log("payment_page.dart: urls =>" + url.toString());
                    _redirect(url);
                  },
                  onPageFinished: (String url) {
                    log('payment_page.dart: Page finished loading: $url');
                    setState(() {
                      _isLoading = false;
                    });
                    _redirect(url);
                  },
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
    log("payment_page.dart: redirect");
    if (_canRedirect) {
      bool _isSuccess =
          url.contains('success') && url.contains(AppConstant.baseUrl);
      bool _isFailed =
          url.contains('fail') && url.contains(AppConstant.baseUrl);
      bool _isCancel =
          url.contains('cancel') && url.contains(AppConstant.baseUrl);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
      }
      if (_isSuccess) {
        Get.offNamed(
          RouteHelper.getOrderSuccessPage(
              widget.orderModel.id.toString(), 'success'),
        );
      } else if (_isFailed || _isCancel) {
        Get.offNamed(
          RouteHelper.getOrderSuccessPage(
              widget.orderModel.id.toString(), 'fail'),
        );
      } else {
        log("payment_page.dart: Encountered problem");
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      log("payment_page.dart: app exited");
      return true;
      // return Get.dialog(PaymentFailedDialog(orderID: widget.orderModel.id.toString()));
    }
  }
}
