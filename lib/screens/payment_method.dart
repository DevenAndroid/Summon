import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/payment_option_controller.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/thankyou_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../repositories/check_out_repository.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);
  static var paymentScreen = "/paymentScreen";

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final controller = Get.put(PaymentOptionController());
  bool _isValue = false;
  RxString selectedValue = "cod".obs;
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response.walletName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  var options = {
    'key': 'rzp_live_1HJot1eILYIf7B',
    'amount': 100,
    'name': 'Demo',
    'description': 'Payment',
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
  };

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar(title: "Select Payment Method", context: context),
      body: Obx(() {
        return controller.isDataLoading.value
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image(
                                    image: const AssetImage(
                                        AppAssets.paymentIcon1),
                                    height: height * .03,
                                    width: width * .10,
                                  ),
                                  SizedBox(
                                    width: width * .04,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "My Wallet balance",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.blackcolor,
                                                fontSize: 14),
                                      ),
                                      Text(
                                        "₹${controller.model.value.data!.earnedBalance}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                height: 1.5,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ]),
                                Checkbox(
                                    side: const BorderSide(
                                        color: AppTheme.primaryColor, width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    value: _isValue,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isValue = value!;
                                        if (_isValue == true) {
                                          selectedValue.value = "";
                                        } else {
                                          selectedValue.value = "cod";
                                        }
                                      });
                                    })
                              ],
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          selectedValue.value = "online";
                          print(selectedValue.value);
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image(
                                      image: const AssetImage(
                                          AppAssets.mastercardIcon),
                                      height: height * .04,
                                      width: width * .10,
                                    ),
                                    SizedBox(
                                      width: width * .04,
                                    ),
                                    Text(
                                      "Card",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.blackcolor,
                                              fontSize: 16),
                                    ),
                                  ]),
                                  Obx(() {
                                    return Radio<String>(
                                      value: "online",
                                      groupValue: selectedValue.value,
                                      onChanged: (value) {
                                        selectedValue.value = value!;
                                      },
                                    );
                                  }),
                                ],
                              ),
                            )),
                      ),
                      controller.model.value.data!.cod == true
                          ? GestureDetector(
                              onTap: () {
                                selectedValue.value = "cod";
                                print(selectedValue.value);
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Image(
                                            image: const AssetImage(
                                                AppAssets.cashIcon),
                                            height: height * .03,
                                            width: width * .08,
                                          ),
                                          SizedBox(
                                            width: width * .04,
                                          ),
                                          Text(
                                            "Cash on delivery",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppTheme.blackcolor,
                                                    fontSize: 16),
                                          ),
                                        ]),
                                        Obx(() {
                                          return Radio<String>(
                                            value: "cod",
                                            groupValue: selectedValue.value,
                                            onChanged: (value) {
                                              selectedValue.value = value!;
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  )),
                            )
                          : SizedBox(),
                    ],
                  ),
                ))
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(top: AddSize.padding20),
                  child: CircularProgressIndicator(),
                ),
              );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  checkOut(payment_type: selectedValue.value, context: context)
                      .then((value) {
                    if (value.status == true) {
                      Get.offAllNamed(ThankYouScreen.thankYouScreen,
                          arguments: [
                            value.data!.orderType,
                            value.data!.orderId,
                            value.data!.placedAt,
                            value.data!.itemTotal,
                            value.data!.tax,
                            value.data!.deliveryCharges,
                            value.data!.packingFee,
                            value.data!.grandTotal,
                            value.data!.orderId
                          ]);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    primary: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                child: Text(
                  "PAY NOW",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )),
            SizedBox(
              height: AddSize.padding20,
            ),
            ElevatedButton(
                onPressed: () {
                  _razorpay.open(options);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    primary: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                child: Text(
                  "Checkout",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
