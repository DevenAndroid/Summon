import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/registration_form_textField.dart';
import 'package:get/get.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';

class DriverBankDetails extends StatefulWidget {
  const DriverBankDetails({Key? key}) : super(key: key);
  static var driverBankDetails = "/driverBankDetails";
  @override
  State<DriverBankDetails> createState() => _DriverBankDetailsState();
}

class _DriverBankDetailsState extends State<DriverBankDetails> {
  final TextEditingController bankAccountNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController iFSCCode = TextEditingController();
  RxString selectedCAt = "".obs;
  final _formKey = GlobalKey<FormState>();
  final List<String> dropDownList = ["HDFC Bank", "SBI Bank", "PNB Bank"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: "Bank Details", context: context),
      body: Obx(() {
        return SingleChildScrollView(
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
                      child: Column(
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
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
                            items: dropDownList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedCAt.value = newValue.toString();
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please select bank';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          RegistrationTextField(
                            controller: bankAccountNumber,
                            hint: "Bank Account Number",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please enter bank account number")
                            ]),
                          ),
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          RegistrationTextField(
                            controller: accountHolderName,
                            hint: "Account Holder Name",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please enter account holder name")
                            ]),
                          ),
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          RegistrationTextField(
                            controller: iFSCCode,
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
                                if (_formKey.currentState!.validate()) {}
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 60),
                                primary: AppTheme.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "Add Account".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: AppTheme.backgroundcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                              )),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
      }),
    );
  }
}
