import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendorAddProductController.dart';
import '../../model/VendorAddProduct_Model.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/registration_form_textField.dart';
import '../Language_Change_Screen.dart';

class AddOptionScreen extends StatefulWidget {
  const AddOptionScreen({Key? key}) : super(key: key);
  static var addOptionScreen = "/addOptionScreen";

  @override
  State<AddOptionScreen> createState() => _AddOptionScreenState();
}

class _AddOptionScreenState extends State<AddOptionScreen> {
  TextEditingController titleController = TextEditingController();
  final vendorAddProductController = Get.put(VendorAddProductController());
  // RxList<ListModel1> listModelData = <ListModel1>[].obs;
  bool isMultiSelect = false;

  int currentIndex = 0;

  bool emptyList = false;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      currentIndex = Get.arguments;
      titleController.text = vendorAddProductController.vendorAddProductModel.value
          .data!.singlePageAddons![currentIndex].title ?? "";
      isMultiSelect = vendorAddProductController.vendorAddProductModel.value
          .data!.singlePageAddons![currentIndex].multiSelectAddons ?? false;
      tempList = vendorAddProductController.vendorAddProductModel.value
          .data!.singlePageAddons![currentIndex].addonData ?? [];
    } else {
      emptyList = true;
      createOneForMe();
    }
  }
  List<AddonData> tempList = [];

  createOneForMe() {
    tempList.add(AddonData(
        calories: "",
        name: "",
        price: ""
    ));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          leadingWidth: AddSize.size20 * 2,
          backgroundColor: Color(0xffF5F5F5),
          title: Text(
            "Add Options".tr,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppTheme.blackcolor),
          ),

          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.back,
                  height: AddSize.size20,
                )),
          ),
        ),
        // backAppBar(title: "My Address", context: context),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(fontSize: 17),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC0CCD4)),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Color(0xffC0CCD4)),
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC0CCD4)),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: width * .05, vertical: height * .03),
                    hintText: 'Title'.tr,
                    hintStyle: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 16,
                        color: Color(0xffACACB7),
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                        side:
                            BorderSide(color: AppTheme.primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: isMultiSelect,
                        onChanged: (bool? value) {
                          setState(() {
                            isMultiSelect = value!;
                          });
                        }),
                    Text(
                      "100Cal+".tr,
                      style: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xff909090),
                          fontSize: AddSize.font14,
                          fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                        child: Text(
                      "Multi-select (optional item)".tr,
                      style: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xff000000),
                          fontSize: AddSize.font14,
                          fontWeight: FontWeight.w700),
                    )),
                  ],
                ),
                SizedBox(
                  height: height * .01,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choice of Add On".tr,
                              style: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000)),
                            ),

                            InkWell(
                              onTap: () {
                                tempList.add(AddonData(
                                  calories: "",
                                  name: "",
                                  price: ""
                                ));
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppTheme.primaryColor,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 38,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: tempList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index1) {
                              return GestureDetector(
                                onTap: () {},
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: repeatUnit(
                                        item: tempList[index1],
                                        index: index1
                                    ),
                                  ),
                                  Positioned(
                                    top: -5,
                                    right: -2,
                                    child: IconButton(
                                        onPressed: () {
                                          tempList.removeAt(index1);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.clear,
                                          color: AppTheme.primaryColor,
                                          size: 25,
                                        )),
                                  ),
                                ]),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                if(emptyList){
                  vendorAddProductController
                      .vendorAddProductModel.value.data!.singlePageAddons!
                      .add(SinglePageAddons(
                          addonData: tempList, multiSelectAddons: isMultiSelect, title: titleController.text.trim()));
                } else {
                  vendorAddProductController.vendorAddProductModel.value.data!.singlePageAddons![currentIndex].title = titleController.text.trim();
                  vendorAddProductController.vendorAddProductModel.value.data!.singlePageAddons![currentIndex].multiSelectAddons = isMultiSelect;
                  vendorAddProductController.vendorAddProductModel.value.data!.singlePageAddons![currentIndex].addonData = tempList;
                }
                Get.back();
                Future.delayed(Duration(milliseconds: 300)).then((value) {
                  vendorAddProductController.refreshInt.value = DateTime.now().microsecondsSinceEpoch;
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.maxFinite, AddSize.size30 * 2),
                backgroundColor: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "SAVE".tr,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppTheme.backgroundcolor,
                    fontWeight: FontWeight.w600,
                    fontSize: AddSize.font18),
              )),
        ),
      ),
    );
  }

  Padding repeatUnit({
    required AddonData item,
    required int index
}) {
    final TextEditingController name = TextEditingController(text: item.name);
    final TextEditingController price = TextEditingController(text: item.price);
    final TextEditingController cal = TextEditingController(text: item.calories);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AddSize.padding18, vertical: AddSize.padding22),
      child: Column(
        children: [
          SizedBox(
            height: AddSize.size10,
          ),
          Row(
            children: [
              Expanded(
                child: RegistrationTextField1(
                  hint: "Name".tr,
                  lableText: "Name".tr,
                  onChanged: (value) {
                    tempList[index].name = value;
                  },
                  controller: name,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter Name")]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          Row(
            children: [
              Expanded(
                child: RegistrationTextField1(
                  hint: "Calories".tr,
                  lableText: "Calories".tr,
                  onChanged: (value) {
                    tempList[index].calories = value;
                  },
                  controller: cal,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter calories")]),
                ),
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Expanded(
                child: RegistrationTextField1(
                  onChanged: (value) {
                    log(value);
                    tempList[index].price = value.toString();
                  },
                  hint: "Price".tr,
                  lableText: "Price".tr,
                  // keyboardType: TextInputType.number,
                  controller: price,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter Price")]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size15,
          ),
        ],
      ),
    );
  }
}
