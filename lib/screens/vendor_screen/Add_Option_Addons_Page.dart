import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/Addons_Controller.dart';
import '../../model/ListDataModel.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/registration_form_textField.dart';

class AddOptionScreen extends StatefulWidget {
  const AddOptionScreen({Key? key}) : super(key: key);
  static var addOptionScreen = "/addOptionScreen";

  @override
  State<AddOptionScreen> createState() => _AddOptionScreenState();
}

class _AddOptionScreenState extends State<AddOptionScreen> {
  TextEditingController titleController=TextEditingController();
  final addOnsController = Get.put(AddonsController());
  RxList<ListModel1> listModelData = <ListModel1>[].obs;
  bool isMultiSelect=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addOnsController.getAddonsData().then((va) {
      if (listModelData.isEmpty && addOnsController.isDataLoading.value) {
        listModelData.add(ListModel1(
            name: "".obs,
            price: "".obs,
            calories: "".obs,
            addonType: "".obs,
            addonTypeId: "".obs));
        setState(() {});
      }
    });


  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          leadingWidth: AddSize.size20 * 1.6,
          backgroundColor: Color(0xffF5F5F5),
          title: Text(
            "Add Options",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppTheme.blackcolor),
          ),
          leading: Padding(
            padding: EdgeInsets.only(right: AddSize.padding10),
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
        body:
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .09,
                      child: TextField(
                        maxLines: 3,
                        controller: titleController,
                        style: const TextStyle(fontSize: 17),
                        // textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) => {},
                        decoration: InputDecoration(
                          //filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffC0CCD4)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                            borderSide:
                            BorderSide(color: Color(0xffC0CCD4)),
                          ),
                          border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffC0CCD4)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          //fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: width * .05,
                              vertical: height * .03),
                          hintText: 'Title',
                          hintStyle: GoogleFonts.ibmPlexSansArabic(
                              fontSize: 16,
                              color: Color(0xffACACB7),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                            side: BorderSide(
                                color:  AppTheme.primaryColor,
                                width: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            value: isMultiSelect,
                            onChanged: (bool? value) {
                              setState(() {
                                isMultiSelect = value!;
                              });
                            }),
                        Text(
                          "100Cal+",
                          style: GoogleFonts.ibmPlexSansArabic(
                              color: Color(0xff909090),
                              fontSize: AddSize.font14,
                              fontWeight: FontWeight.w700),
                        ),
                        Expanded(
                            child: Text(
                              "Multi-select (optional item)",
                              style: GoogleFonts.ibmPlexSansArabic(
                                  color: Color(0xff000000),
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w700),
                            )),

                      ],
                    ),
                    SizedBox(height: height * .01,),
                    SingleChildScrollView(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Choice of Add On",style: GoogleFonts
                                      .ibmPlexSansArabic(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: Color(
                                          0xff000000)),),

                                  InkWell(
                                    onTap: () {
                                      listModelData.add(ListModel1(
                                                            name: "".obs,
                                                            price: "".obs,
                                                            calories: "".obs,
                                                            addonType: "".obs,
                                                            addonTypeId: "".obs,
                                                          ));
                                                          setState(() {});

                                    },

                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppTheme.primaryColor,
                                      ),
                                      child: Icon(Icons.add,size: 38,color: Colors.white,),
                                    ),
                                  ),
                                  // Image(
                                  //   height: 90,
                                  //   width: 90,
                                  //   image:
                                  //   AssetImage(
                                  //       AppAssets.AddButton),
                                  //
                                  // ),
                                ],

                              ),
                              Obx(() {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listModelData.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Stack(children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: repeatUnit(
                                                name1: listModelData[index].name.value,
                                                price1: listModelData[index].price.value,
                                                cal1: listModelData[index].calories.value,
                                                addOn1:
                                                listModelData[index].addonType.value,
                                                index: index),
                                          ),
                                          Positioned(
                                            top: -5,
                                            right: -2,
                                            child: IconButton(
                                                onPressed: () {
                                                  listModelData.removeAt(index);
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
                                    });
                              }),



                                ],
                              ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),

        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.maxFinite, AddSize.size30 * 2),
                backgroundColor: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "SAVE",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(
                    color: AppTheme.backgroundcolor,
                    fontWeight: FontWeight.w600,
                    fontSize: AddSize.font18),
              )),
        ),
      ),

    );
  }
  Padding repeatUnit({
    required String name1,
    required String price1,
    required String cal1,
    required String addOn1,
    required int index,
  }) {
    final TextEditingController name = TextEditingController(text: name1);
    final TextEditingController price = TextEditingController(text: price1);
    final TextEditingController cal = TextEditingController(text: cal1);
    // final TextEditingController addOn = TextEditingController(text: addOn1);

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
                  hint: "Name",
                  lableText: "Name",
                  onChanged: (value) {
                    listModelData[index].name.value = value;
                  },
                  controller: name,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter price")]),
                ),
              ),

              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8.0),
              //       color: Colors.grey.shade50,
              //     ),
              //     child:
              //     Row(
              //       //mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Expanded(
              //           child: DropdownButtonFormField(
              //               focusColor: Colors.grey.shade50,
              //               isExpanded: true,
              //               iconEnabledColor: AppTheme.primaryColor,
              //               hint: Text(
              //                 'Complementary inclusions',
              //                 style: TextStyle(
              //                     color: AppTheme.userText,
              //                     fontSize: AddSize.font14),
              //                 textAlign: TextAlign.start,
              //               ),
              //               decoration: InputDecoration(
              //                 fillColor: Colors.grey.shade50,
              //                 contentPadding: const EdgeInsets.symmetric(
              //                     horizontal: 10, vertical: 18),
              //                 // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
              //                 focusedBorder: OutlineInputBorder(
              //                   borderSide:
              //                   BorderSide(color: Colors.grey.shade300),
              //                   borderRadius: BorderRadius.circular(10.0),
              //                 ),
              //                 enabledBorder: OutlineInputBorder(
              //                   borderSide:
              //                   BorderSide(color: Colors.grey.shade300),
              //                   borderRadius: BorderRadius.circular(10.0),
              //                 ),
              //                 border: OutlineInputBorder(
              //                     borderSide: BorderSide(
              //                         color: Colors.grey.shade300, width: 3.0),
              //                     borderRadius: BorderRadius.circular(15.0)),
              //               ),
              //               value: listModelData[index].addonType.value == ""
              //                   ? null
              //                   : listModelData[index].addonType.value,
              //               items: addOnsController.model.value.data?.addons!
              //                   .toList()
              //                   .map((value) {
              //                 return DropdownMenuItem(
              //                   value: value.id.toString(),
              //                   child: Text(
              //                     value.name.toString(),
              //                     style: TextStyle(
              //                         color: AppTheme.userText,
              //                         fontSize: AddSize.font14),
              //                   ),
              //                 );
              //               }).toList(),
              //               onChanged: (newValue) {
              //                 listModelData[index].addonType.value =
              //                     newValue.toString();
              //               },
              //               validator: (valid) {
              //                 if (listModelData[index]
              //                     .addonType
              //                     .value
              //                     .isEmpty) {
              //                   return "Addon Type is required";
              //                 } else {
              //                   return null;
              //                 }
              //               }),
              //         ),
              //         // const VerticalDivider(width: 1.0),
              //         // Obx(() {
              //         //return
              //         //   Expanded(
              //         //   child: DropdownButtonFormField(
              //         //     isExpanded: true,
              //         //     dropdownColor: Colors.grey.shade50,
              //         //     iconEnabledColor: AppTheme.primaryColor,
              //         //     hint: Text(
              //         //       'Type',
              //         //       style: TextStyle(
              //         //           color: AppTheme.userText,
              //         //           fontSize: AddSize.font14,
              //         //           fontWeight: FontWeight.w500),
              //         //       textAlign: TextAlign.start,
              //         //     ),
              //         //     decoration: const InputDecoration(
              //         //         enabled: true, border: InputBorder.none),
              //         //     value: listModelData[index].price.value == ""
              //         //         ? null
              //         //         : listModelData[index].price.value,
              //         //     items: qtyType.map((value) {
              //         //       return DropdownMenuItem(
              //         //         value: value.key.toString(),
              //         //         child: Text(
              //         //           value.value,
              //         //           style: TextStyle(
              //         //               color: Colors.black,
              //         //               fontSize: AddSize.font14,
              //         //               fontWeight: FontWeight.w500),
              //         //         ),
              //         //       );
              //         //     }).toList(),
              //         //     onChanged: (newValue) {
              //         //       listModelData[index].addOn.value =
              //         //           newValue as String;
              //         //     },
              //         //   ),
              //         // );
              //         //}),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          Row(
            children: [

              Expanded(
                child: RegistrationTextField1(
                  hint: "Calories",
                  lableText: "Calories",
                  onChanged: (value) {
                    listModelData[index].calories.value = value;
                  },
                  controller: cal,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter price")]),
                ),
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Expanded(
                child: RegistrationTextField1(
                  onChanged: (value) {
                    listModelData[index].price.value = value;
                  },
                  hint: "Price",
                  lableText: "Price",
                  keyboardType: TextInputType.number,
                  controller: price,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter qty")]),
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
