import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/model/ListDataModel.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/registration_form_textField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controller/Addons_Controller.dart';
import '../../controller/Varient_Size_controller.dart';
import '../../controller/VendorAllCategoryController.dart';
import '../../controller/home_page_controller.dart';
import '../../controller/vendorAddProductController.dart';
import '../../controller/vendor_productList_controller.dart';
import '../../model/ListModel.dart';
import '../../model/RepetedItem_Model.dart';
import '../../repositories/Vendor_SaveProduct_Repo.dart';

import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';

class AddVendorProduct1 extends StatefulWidget {
  const AddVendorProduct1({Key? key}) : super(key: key);
  static var addVendorProduct1 = "/addVendorProduct1";

  @override
  State<AddVendorProduct1> createState() => _AddVendorProduct1State();
}

class _AddVendorProduct1State extends State<AddVendorProduct1> {
  final vendorAddProductController = Get.put(VendorAddProductController());
  final vendorAllCategoryController = Get.put(VendorAllCategoryController());
  final vendorProductListController = Get.put(VendorProductListController());
  final addOnsController = Get.put(AddonsController());
  final varientSizeController = Get.put(VarientSizeController());
  RxBool showValidation = false.obs;
  final homeController = Get.put(HomePageController());
  Rx<File> image = File("").obs;
  final _formKey = GlobalKey<FormState>();
  RxList<ListModel1> listModelData = <ListModel1>[].obs;
  RxList<RepetItemData> repetedData = <RepetItemData>[].obs;
  String? selectedType;
  String? selectedTypeAddons;
  String? chooseOptionType;
  String? chooseCategory;
  final List<String> optionMenu = ["Simple", "Variable"];
  bool _isValue = false;
  final List<String> quintityType = [
    "kg",
    "grm",
    "ltr",
    "ml",
    "dozen",
    "piece"
  ];
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.easeOutSine);
  }

  showChangeAddressSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: AddSize.size20,
              ),
              Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding16,
                      vertical: AddSize.padding16),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          NewHelper()
                              .addImagePicker(imageSource: ImageSource.camera)
                              .then((value) {
                            for (var i = 0; i < imageList.length; i++) {
                              if (imageList[i].path == "") {
                                imageList[i] = value!;
                                Get.back();
                                break;
                              }
                            }
                          });
                        },
                        child: Text(
                          "Take picture",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: AddSize.font16),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size12,
                      ),
                      const Divider(),
                      SizedBox(
                        height: AddSize.size12,
                      ),
                      InkWell(
                        onTap: () {
                          NewHelper().addFilePickerList().then((value) {
                            if (value != null) {
                              for (var item in value) {
                                if (imageList.length < 6) {
                                  imageList.add(item);
                                }
                              }
                            }
                          });
                        },
                        child: Text(
                          "Choose From Gallery",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: AddSize.font16),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size12,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // Get.toNamed(MyRouter.chooseAddressScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(AddSize.size250, AddSize.size50),
                            backgroundColor: AppTheme.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Cancel".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                color: AppTheme.backgroundcolor,
                                fontWeight: FontWeight.w500,
                                fontSize: AddSize.font16),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  RxList<File> imageList = <File>[].obs;

  @override
  void initState() {
    super.initState();
    vendorAllCategoryController.getVendorAllCategory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vendorAddProductController.getVendorSearchProductList().then((value) {
        if (listModelData.isEmpty && addOnsController.isDataLoading.value) {
          listModelData.add(ListModel1(
              name: "".obs,
              price: "".obs,
              addonType: "".obs,
              addonTypeId: "".obs));
          setState(() {});
        }
      });
      if (repetedData.isEmpty && varientSizeController.isDataLoading.value) {
        repetedData.add(RepetItemData(
          itemSize: "".obs,
          price: "".obs,
          minQty: "".obs,
          maxQty: "".obs,
          id: "".obs,
        ));
        setState(() {});
      }

    });

    //vendorAddProductController.getVendorAddProduct();
    addOnsController.getAddonsData().then((va) {
      if (listModelData.isEmpty && addOnsController.isDataLoading.value) {
        listModelData.add(ListModel1(
            name: "".obs,
            price: "".obs,
            addonType: "".obs,
            addonTypeId: "".obs));
        setState(() {});
      }
    });
    varientSizeController.getSizeData().then((value) {
      if (repetedData.isEmpty && varientSizeController.isDataLoading.value) {
        repetedData.add(RepetItemData(
            itemSize: "".obs,
            price: "".obs,
            minQty: "".obs,
            maxQty: "".obs,
            id: "".obs));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Add Products", context: context),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  editProduct(),
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: repetedData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: repeatUnit2(
                                  minQt1: repetedData[index].minQty.value,
                                  price1: repetedData[index].price.value,
                                  maxQt1: repetedData[index].maxQty.value,
                                  index: index,
                                ),
                              ),
                              Positioned(
                                top: -5,
                                right: -2,
                                child: IconButton(
                                    onPressed: () {
                                      repetedData.length == 1
                                          ? null
                                          : repetedData.removeAt(index);
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
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  chooseOptionType == "Variable" ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: AddSize.size40,
                          width: AddSize.size40,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  repetedData.add(RepetItemData(
                                    itemSize: "".obs,
                                    price: "".obs,
                                    minQty: "".obs,
                                    maxQty: "".obs,
                                    id: "".obs,
                                  ));
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: AppTheme.backgroundcolor,
                                      size: AddSize.size25,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      )
                    ],
                  ):SizedBox(),
                  SizedBox(
                    height: AddSize.size10,
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
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: AddSize.size40,
                          width: AddSize.size40,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  listModelData.add(ListModel1(
                                    name: "".obs,
                                    price: "".obs,
                                    addonType: "".obs,
                                    addonTypeId: "".obs,
                                  ));
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: AppTheme.backgroundcolor,
                                      size: AddSize.size25,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AddSize.size15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            image.value.path != "") {
                          print("hello");
                          Map<String, String> map = {};

                          map['name'] = vendorAddProductController
                              .productNameController.text;

                          map['description'] = vendorAddProductController
                              .descriptionController.text;

                          map['SKU'] =
                              vendorAddProductController.skuController.text;
                          map['type'] = chooseOptionType.toString();
                          map['category'] = chooseCategory.toString();
                          // print(map);
                          //map['image'] = image.value;

                          for (var i = 0; i < repetedData.length; i++) {
                            map["variants[$i][size_id]"] =
                                repetedData[i].itemSize.value.toString();
                            map["variants[$i][min_qty]"] =
                                repetedData[i].minQty.value.toString();
                            map["variants[$i][max_qty]"] =
                                repetedData[i].maxQty.value.toString();
                            map["variants[$i][price]"] =
                                repetedData[i].price.value.toString();
                          }
                          for (var i = 0; i < listModelData.length; i++) {
                            map["addons[$i][name]"] =
                                listModelData[i].name.value.toString();
                            map["addons[$i][price]"] =
                                listModelData[i].price.value.toString();
                            map["addons[$i][addon_id]"] =
                                listModelData[i].addonType.value.toString();
                          }
                          print(map);

                          vendorSaveProductRepo(
                              context: context,
                              mapData: map,
                              fieldName1: "image",
                              file1: image.value)
                              .then((value) {
                            showToast(value.message);
                            if (value.status == true) {
                              vendorProductListController
                                  .getVendorProductList();
                              homeController.getData();
                              Get.back();
                            } else {
                              showToast(value.message);
                            }
                          });
                        } else {
                          showValidation.value = true;
                          if (image.value.path.isEmpty) {
                            scrollNavigation(10);
                          } else if ( vendorAddProductController
                              .productNameController.text.trim().isEmpty) {
                            scrollNavigation(0);
                          } else if ( vendorAddProductController
                              .descriptionController.text
                              .trim()
                              .isEmpty) {
                            scrollNavigation(50);
                          } else if ( vendorAddProductController
                              .skuController.text
                              .trim()
                              .isEmpty) {
                            scrollNavigation(50);
                          }
                          else if (chooseOptionType=="") {
                            scrollNavigation(50);
                          }
                        }
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
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  Container editProduct() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.backgroundcolor),
      padding: EdgeInsets.symmetric(
          horizontal: AddSize.padding16, vertical: AddSize.padding10),
      child: Obx(() {
        return Column(
          children: [
            DottedBorder(
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              dashPattern: const [3, 5],
              color: !checkValidation(
                  showValidation.value, image.value.path == "")
                  ? Colors.grey.shade400
                  : Colors.red,
              strokeWidth: 1,
              child: Obx(() {
                return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding16),
                    width: AddSize.screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: image.value.path == ""
                        ? Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              NewHelper()
                                  .addFilePicker()
                                  .then((value) {
                                image.value = value;
                              });
                            },
                            child: Center(
                                child: Icon(Icons.file_upload_outlined,size: AddSize.size30,)),
                          ),
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          Text(
                            "Upload product image",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: const Color(
                                    0xff555654)),
                          ),
                        ]
                    )
                        : SizedBox(
                        width: double.maxFinite,
                        height: AddSize.size100,
                        child: Image.file(image.value)));
              }),),
            SizedBox(
              height: AddSize.size10,
            ),
            RegistrationTextField(
              hint: "Enter Product Name",
              controller: vendorAddProductController.productNameController,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please enter product name")]),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            RegistrationTextField(
              hint: "Description",
              controller: vendorAddProductController.descriptionController,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please enter description")]),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            RegistrationTextField(
              hint: "SKU",
              controller: vendorAddProductController.skuController,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please enter SKU")]),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey.shade50,
                    ),
                    child:
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                              focusColor: Colors.grey.shade50,
                              isExpanded: true,
                              iconEnabledColor: AppTheme.primaryColor,
                              hint: Text(
                                'All Category',
                                style: TextStyle(
                                    color: AppTheme.userText,
                                    fontSize: AddSize.font14),
                                textAlign: TextAlign.start,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade50,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                                // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 3.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                              value:chooseCategory,
                              items: vendorAllCategoryController.model.value.data?.categories!.toList()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value.id.toString(),
                                  child: Text(
                                    value.name.toString(),
                                    style: TextStyle(
                                        color: AppTheme.userText,
                                        fontSize: AddSize.font14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                chooseCategory =
                                    newValue.toString();
                              },
                              validator: (valid) {
                                if (chooseCategory!.isEmpty) {
                                  return "Addon Type is required";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                        // const VerticalDivider(width: 1.0),
                        // Obx(() {
                        //return
                        //   Expanded(
                        //   child: DropdownButtonFormField(
                        //     isExpanded: true,
                        //     dropdownColor: Colors.grey.shade50,
                        //     iconEnabledColor: AppTheme.primaryColor,
                        //     hint: Text(
                        //       'Type',
                        //       style: TextStyle(
                        //           color: AppTheme.userText,
                        //           fontSize: AddSize.font14,
                        //           fontWeight: FontWeight.w500),
                        //       textAlign: TextAlign.start,
                        //     ),
                        //     decoration: const InputDecoration(
                        //         enabled: true, border: InputBorder.none),
                        //     value: listModelData[index].price.value == ""
                        //         ? null
                        //         : listModelData[index].price.value,
                        //     items: qtyType.map((value) {
                        //       return DropdownMenuItem(
                        //         value: value.key.toString(),
                        //         child: Text(
                        //           value.value,
                        //           style: TextStyle(
                        //               color: Colors.black,
                        //               fontSize: AddSize.font14,
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //       );
                        //     }).toList(),
                        //     onChanged: (newValue) {
                        //       listModelData[index].addOn.value =
                        //           newValue as String;
                        //     },
                        //   ),
                        // );
                        //}),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.shade50,
                    ),
                    child: Row(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                              focusColor: Colors.grey.shade50,
                              isExpanded: true,
                              iconEnabledColor: AppTheme.primaryColor,
                              hint: Text(
                                'Choose Product type',
                                style: TextStyle(
                                    color: AppTheme.userText,
                                    fontSize: AddSize.font14),
                                textAlign: TextAlign.start,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade50,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                              value: chooseOptionType,
                              items: optionMenu.map((value) {
                                return DropdownMenuItem(
                                  value: value.toString(),
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(
                                        color: AppTheme.userText,
                                        fontSize: AddSize.font14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                chooseOptionType = newValue.toString();
                                setState(() {});
                              },
                              validator: (valid) {
                                if (chooseOptionType == null) {
                                  return "Type Type is required";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Add more here
            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         chooseOptionType == "Simple"
            //             ? SizedBox()
            //             : Expanded(
            //                 child: DropdownButtonFormField(
            //                   focusColor: Colors.grey.shade50,
            //                   isExpanded: true,
            //                   iconEnabledColor: AppTheme.primaryColor,
            //                   hint: Text(
            //                     'Size',
            //                     style: TextStyle(
            //                         color: AppTheme.userText,
            //                         fontSize: AddSize.font14),
            //                     textAlign: TextAlign.start,
            //                   ),
            //                   decoration: InputDecoration(
            //                       fillColor: Colors.grey.shade50,
            //                       contentPadding: const EdgeInsets.symmetric(
            //                           horizontal: 10, vertical: 18),
            //                       // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderSide:
            //                             BorderSide(color: Colors.grey.shade300),
            //                         borderRadius: BorderRadius.circular(10.0),
            //                       ),
            //                       enabledBorder: OutlineInputBorder(
            //                           borderSide: BorderSide(
            //                               color: Colors.grey.shade300),
            //                           borderRadius: const BorderRadius.all(
            //                               Radius.circular(10.0))),
            //                       border: OutlineInputBorder(
            //                           borderSide: BorderSide(
            //                               color: Colors.grey.shade300,
            //                               width: 3.0),
            //                           borderRadius:
            //                               BorderRadius.circular(15.0))),
            //                   value: selectedType,
            //                   items: varientSizeController
            //                       .model.value.data!.variants!
            //                       .toList()
            //                       .map((value) {
            //                     return DropdownMenuItem(
            //                       value: value.id.toString(),
            //                       child: Text(
            //                         value.size.toString(),
            //                         style: TextStyle(
            //                             color: AppTheme.userText,
            //                             fontSize: AddSize.font14),
            //                       ),
            //                     );
            //                   }).toList(),
            //                   onChanged: (newValue) {
            //                     selectedType = newValue as String;
            //                     setState(() {});
            //                     print(
            //                         "Selected value issssss.....${selectedType}");
            //                   },
            //                   validator: MultiValidator([
            //                     RequiredValidator(
            //                         errorText: "Please enter size")
            //                   ]),
            //                 ),
            //               ),
            //         SizedBox(
            //           width: AddSize.size10,
            //         ),
            //         Expanded(
            //           child: RegistrationTextField1(
            //             hint: "Price",
            //             controller: vendorAddProductController.priceController,
            //             validator: MultiValidator([
            //               RequiredValidator(errorText: "Please enter price")
            //             ]),
            //           ),
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       height: AddSize.size10,
            //     ),
            //     Row(
            //       children: [
            //         Expanded(
            //           child: RegistrationTextField1(
            //             hint: "Min Qty",
            //             controller: vendorAddProductController.minQtyController,
            //             validator: MultiValidator([
            //               RequiredValidator(errorText: "Please enter Max Qty")
            //             ]),
            //           ),
            //         ),
            //         SizedBox(
            //           width: AddSize.size10,
            //         ),
            //         Expanded(
            //           child: RegistrationTextField1(
            //             hint: "Max Qty",
            //             controller: vendorAddProductController.maxQtyController,
            //             validator: MultiValidator([
            //               RequiredValidator(errorText: "Please enter Min Qty")
            //             ]),
            //           ),
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       height: AddSize.size10,
            //     ),
            //     chooseOptionType == "Variable"
            //         ? Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               GestureDetector(
            //                 onTap: () {
            //                   repetedData.add(RepetItemData(
            //                     itemSize: "".obs,
            //                     price: "".obs,
            //                     minQty: "".obs,
            //                     maxQty: "".obs,
            //                   ));
            //                   setState(() {});
            //                 },
            //                 child: Container(
            //                   height: AddSize.size30,
            //                   width: AddSize.size30,
            //                   decoration: BoxDecoration(
            //                     color: AppTheme.primaryColor,
            //                     borderRadius: BorderRadius.circular(50),
            //                   ),
            //                   child: Icon(
            //                     Icons.add,
            //                     color: AppTheme.backgroundcolor,
            //                     size: AddSize.size25,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           )
            //         : SizedBox(),
            //   ],
            // ),
          ],
        );
      }),
    );
  }

  Padding repeatUnit({
    required String name1,
    required String price1,
    required String addOn1,
    required int index,
  }) {
    final TextEditingController name = TextEditingController(text: name1);
    final TextEditingController price = TextEditingController(text: price1);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade50,
                  ),
                  child:
                  Row(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                            focusColor: Colors.grey.shade50,
                            isExpanded: true,
                            iconEnabledColor: AppTheme.primaryColor,
                            hint: Text(
                              'Complementary inclusions',
                              style: TextStyle(
                                  color: AppTheme.userText,
                                  fontSize: AddSize.font14),
                              textAlign: TextAlign.start,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                            value: listModelData[index].addonType.value == ""
                                ? null
                                : listModelData[index].addonType.value,
                            items: addOnsController.model.value.data?.addons!
                                .toList()
                                .map((value) {
                              return DropdownMenuItem(
                                value: value.id.toString(),
                                child: Text(
                                  value.name.toString(),
                                  style: TextStyle(
                                      color: AppTheme.userText,
                                      fontSize: AddSize.font14),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              listModelData[index].addonType.value =
                                  newValue.toString();
                            },
                            validator: (valid) {
                              if (listModelData[index]
                                  .addonType
                                  .value
                                  .isEmpty) {
                                return "Addon Type is required";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      // const VerticalDivider(width: 1.0),
                      // Obx(() {
                      //return
                      //   Expanded(
                      //   child: DropdownButtonFormField(
                      //     isExpanded: true,
                      //     dropdownColor: Colors.grey.shade50,
                      //     iconEnabledColor: AppTheme.primaryColor,
                      //     hint: Text(
                      //       'Type',
                      //       style: TextStyle(
                      //           color: AppTheme.userText,
                      //           fontSize: AddSize.font14,
                      //           fontWeight: FontWeight.w500),
                      //       textAlign: TextAlign.start,
                      //     ),
                      //     decoration: const InputDecoration(
                      //         enabled: true, border: InputBorder.none),
                      //     value: listModelData[index].price.value == ""
                      //         ? null
                      //         : listModelData[index].price.value,
                      //     items: qtyType.map((value) {
                      //       return DropdownMenuItem(
                      //         value: value.key.toString(),
                      //         child: Text(
                      //           value.value,
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: AddSize.font14,
                      //               fontWeight: FontWeight.w500),
                      //         ),
                      //       );
                      //     }).toList(),
                      //     onChanged: (newValue) {
                      //       listModelData[index].addOn.value =
                      //           newValue as String;
                      //     },
                      //   ),
                      // );
                      //}),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size20,
          ),
        ],
      ),
    );
  }

  Padding repeatUnit2({
    required String minQt1,
    required String price1,
    required String maxQt1,
    required int index,
  }) {
    //final TextEditingController nameCon = TextEditingController(text: minQt1);
    final TextEditingController priceCon = TextEditingController(text: price1);
    final TextEditingController minCon = TextEditingController(text: minQt1);
    final TextEditingController maxQtCon = TextEditingController(text: maxQt1);

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
              chooseOptionType == "Variable"
                  ? Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade50,
                  ),
                  child: Row(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                            focusColor: Colors.grey.shade50,
                            isExpanded: true,
                            iconEnabledColor: AppTheme.primaryColor,
                            hint: Text(
                              'Size',
                              style: TextStyle(
                                  color: AppTheme.userText,
                                  fontSize: AddSize.font14),
                              textAlign: TextAlign.start,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 3.0),
                                  borderRadius:
                                  BorderRadius.circular(15.0)),
                            ),
                            value: repetedData[index].itemSize.value == ""
                                ? null
                                : repetedData[index].itemSize.value,
                            items: varientSizeController
                                .model.value.data?.variants!
                                .toList()
                                .map((value) {
                              return DropdownMenuItem(
                                value: value.id.toString(),
                                child: Text(
                                  value.size.toString(),
                                  style: TextStyle(
                                      color: AppTheme.userText,
                                      fontSize: AddSize.font14),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              repetedData[index].itemSize.value =
                                  newValue.toString();
                            },
                            validator: (valid) {
                              if (repetedData[index]
                                  .itemSize
                                  .value
                                  .isEmpty) {
                                return "Size is required";
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              )
                  : SizedBox(),
              chooseOptionType == "Variable"
                  ? SizedBox(
                width: AddSize.size10,
              )
                  : SizedBox(),
              Expanded(
                child: RegistrationTextField1(
                  onChanged: (value) {
                    repetedData[index].price.value = value;
                  },
                  hint: "Price",
                  lableText: "Price",
                  controller: priceCon,
                  keyboardType: TextInputType.number,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter price")]),
                ),
              ),
              SizedBox(
                height: AddSize.size10,
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Row(
            children: [
              Expanded(
                child: RegistrationTextField1(
                    hint: "Min Qty",
                    lableText: "Min Qty",
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      repetedData[index].minQty.value = value;
                    },
                    controller: minCon,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Min Qty";
                      } else if (int.parse(minCon.text) < 1) {
                        return "Enter at least one Qty";
                      } else if (int.parse(minCon.text) >
                          int.parse(maxQtCon.text)) {
                        return "Min Qty should be less than Max Qty";
                      }
                      return null;
                    }),
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Expanded(
                child: RegistrationTextField1(
                    hint: "Max Qty",
                    lableText: "Max Qty",
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      repetedData[index].maxQty.value = value;
                    },
                    controller: maxQtCon,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Min Qty";
                      } else if (int.parse(maxQtCon.text) < 1) {
                        return "Enter at least one Qty";
                      } else if (int.parse(maxQtCon.text) <
                          int.parse(minCon.text)) {
                        return "Min Qty should be less than Max Qty";
                      }
                      return null;
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}