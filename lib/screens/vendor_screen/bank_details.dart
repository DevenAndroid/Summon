import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/model/VendorBankLIst_Model.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/registration_form_textField.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../controller/VendorBankDetails_Controller.dart';
import '../../controller/vendor_BankList_controller..dart';
import '../../repositories/Vendor_AddBankDetails_Repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);
  static var bankDetailsScreen = "/bankDetailsScreen";

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final vendorBankDetailsController = Get.put(VendorBankDetailsController());
  final vendorBankListController = Get.put(VendorBankListController());

  // final TextEditingController bankAccountNumber = TextEditingController();
  // final TextEditingController accountHolderName = TextEditingController();
  // final TextEditingController iFSCCode = TextEditingController();
  RxString selectedCAt = "".obs;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    vendorBankListController.getVendorBankListDetails().then((value) {
      vendorBankDetailsController.getVendorBankDetails().then((value) {
        if (vendorBankListController.bankListModel.value.data!.banks != null &&
            vendorBankDetailsController.bankDetailsModel.value.data != null) {
          selectedCAt.value = (vendorBankListController
                      .bankListModel.value.data!.banks!
                      .firstWhere(
                          (element) =>
                              element.name.toString() ==
                              (vendorBankDetailsController
                                      .bankDetailsModel.value.data!.bank ??
                                  ""),
                          orElse: () => Banks())
                      .id ??
                  "")
              .toString();
        }
        setState(() {});
        print(vendorBankDetailsController.bankDetailsModel.value.data!.bank);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: "Bank Details", context: context),
      body: Obx(() {
        if (vendorBankDetailsController.isDataLoading.value &&
            vendorBankDetailsController.bankDetailsModel.value.data != null) {
          vendorBankDetailsController.bankAccountNumber.text =
              (vendorBankDetailsController
                          .bankDetailsModel.value.data!.accountNo ??
                      "")
                  .toString();

          vendorBankDetailsController.accountHolderName.text =
              (vendorBankDetailsController
                          .bankDetailsModel.value.data!.accountName ??
                      "")
                  .toString();

          vendorBankDetailsController.iFSCCode.text =
              (vendorBankDetailsController
                          .bankDetailsModel.value.data!.ifscCode ??
                      "")
                  .toString();
          // selectedCAt.value = vendorBankListController
          //     .value.data!.bank
          //     .toString();
        }

        return vendorBankDetailsController.isDataLoading.value
            ? SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16, vertical: AddSize.padding16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: AddSize.size45,
                      ),
                      Image(
                        height: AddSize.size150,
                        width: AddSize.screenWidth,
                        image: const AssetImage(AppAssets.bankDetails),
                      ),
                      SizedBox(
                        height: AddSize.size45,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.backgroundcolor),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding10,
                                vertical: AddSize.padding10),
                            child: Obx(() {
                              return Column(
                                children: [
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade50,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                      // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      enabled: true,
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      'Select account',
                                      style: TextStyle(
                                          color: AppTheme.userText,
                                          fontSize: AddSize.font14),
                                    ),
                                    value: selectedCAt.value == ""
                                        ? null
                                        : selectedCAt.value,
                                    items: vendorBankListController
                                        .bankListModel.value.data!.banks!
                                        .toList()
                                        .map((value) {
                                      return DropdownMenuItem(
                                        value: value.id.toString(),
                                        child: Text(
                                          value.name.toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCAt.value = newValue.toString();
                                      });
                                      print(selectedCAt.value);
                                    },
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  RegistrationTextField(
                                    controller: vendorBankDetailsController
                                        .bankAccountNumber,
                                    hint: "Bank Account Number",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              "Please enter bank account number")
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  RegistrationTextField(
                                    controller: vendorBankDetailsController
                                        .accountHolderName,
                                    hint: "Account Holder Name",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              "Please enter account holder name")
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  RegistrationTextField(
                                    controller:
                                        vendorBankDetailsController.iFSCCode,
                                    hint: "IFSC Code",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Please enter IFSC code")
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          vendorAddBankDetailsRepo(
                                                  selectedCAt.value,
                                                  vendorBankDetailsController
                                                      .accountHolderName.text,
                                                  vendorBankDetailsController
                                                      .bankAccountNumber.text,
                                                  vendorBankDetailsController
                                                      .iFSCCode.text,
                                                  context)
                                              .then((value) {
                                            showToast(
                                                "Account Details Added Successfully");
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            const Size(double.maxFinite, 60),
                                        primary: AppTheme.primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        "Add Account".toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font18),
                                      )),
                                ],
                              );
                            }),
                          ))
                    ],
                  ),
                ),
              ))
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
