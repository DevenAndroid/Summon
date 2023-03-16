import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../controller/main_home_controller.dart';
import '../controller/myWallet_controller.dart';
import '../repositories/add_money_repo.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({Key? key}) : super(key: key);
  static var addMoneyScreen = "/addMoneyScreen";
  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final controller = Get.put(MainHomeController());
  final myWalletController = Get.put(MyWalletController());
  final TextEditingController addMoneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> moneyList = ["500", "800", "1000", "1200"];
  final Razorpay _razorpay = Razorpay();


  void processPayment() {
    var options = {
      'key': 'rzp_live_1HJot1eILYIf7B',
      'amount': (int.parse((addMoneyController.text))*100).toString(),
      'name': 'Demo',
      'description': 'Order Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("aaaaaaa------");
    addMoneyRepo(amount: addMoneyController.text, razorpaySignature: response.signature??"SIGNATURE", paymentId: response.paymentId, context: context)
        .then((value){
      showToast(value.message).toString();
      if(value.status == true){
        myWalletController.getWalletData();
        Get.back();
      }
    });
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Add Money", context: context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16, vertical: AddSize.padding16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: AppTheme.backgroundcolor,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding16,
                                vertical: AddSize.padding16),
                            child: Column(
                              children: [
                                TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            color: AppTheme.blackcolor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28),
                                    controller: addMoneyController,
                                    cursorColor: AppTheme.primaryColor,
                                    validator: validateMoney,
                                    decoration: const InputDecoration()),
                                SizedBox(
                                  height: AddSize.size15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    moneyList.length,
                                    (index) => chipList(moneyList[index]),
                                  ),
                                ),
                                SizedBox(
                                  height: AddSize.size25,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        processPayment();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            double.maxFinite, AddSize.size45), backgroundColor: AppTheme.primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    child: Text(
                                      "ADD MONEY",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: AppTheme.backgroundcolor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                    )),
                              ],
                            ))),
                    SizedBox(
                      height: AddSize.size12,
                    ),
                  ],
                ),
              )),
        ));
  }

  chipList(title) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChoiceChip(
      padding: EdgeInsets.symmetric(
          horizontal: width * .005, vertical: height * .005),
      backgroundColor: AppTheme.backgroundcolor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.grey.shade300)),
      label: Text("+₹$title",
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      selected: false,
      onSelected: (value) {
        setState(() {
          addMoneyController.text = title;
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
    );
  }
}
