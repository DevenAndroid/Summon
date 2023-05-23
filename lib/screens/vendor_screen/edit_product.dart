import 'dart:convert';
import '../../controller/Varient_Size_controller.dart';
import '../../model/model_addons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/registration_form_textField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controller/Edit_Products_Controller.dart';
import '../../controller/VendorAllCategoryController.dart';
import '../../controller/vendor_productList_controller.dart';

import '../../model/ListModel.dart';
import '../../model/RepetedItem_Model.dart';
import '../../model/VendorEditProduct_model.dart';
import '../../model/model_addons.dart';
import '../../model/time_model.dart';
import '../../repositories/Vendor_SaveProduct_Repo.dart';
import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static var editProductScreen = "/editProductScreen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final vendorAllCategoryController = Get.put(VendorAllCategoryController());
  final editProductController = Get.put(EditProductsController());
  final vendorProductListController = Get.put(VendorProductListController());
  Rx<VendorEditProductModel> editModel = VendorEditProductModel().obs;
  final varientSizeController = Get.put(VarientSizeController());
  RxList<RepetItemData> repetedData = <RepetItemData>[].obs;
  Rx<File> image = File("").obs;
  final _formKey = GlobalKey<FormState>();
  bool chooseOptionType=false;
  RxBool showValidation = false.obs;
  //RxList<ListModel> listModelData = <ListModel>[].obs;
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
                              .headline5!
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
                            Get.back();
                            // Get.toNamed(MyRouter.chooseAddressScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(AddSize.size250, AddSize.size50),
                            primary: AppTheme.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Cancel".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
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
    editProductController.getEditProductData().then((value){
      if (editProductController.isDataLoading.value &&
          editProductController.editModel.value.data != null) {
        editProductController.productNameController.text =
            (editProductController
                .editModel.value.data!.productDetail!.name ??
                "")
                .toString();
        editProductController.skuController.text =
            (editProductController
                .editModel.value.data!.productDetail!.sKU ??
                "")
                .toString();
        editProductController.descriptionController.text =
            (editProductController
                .editModel.value.data!.productDetail!.content ??
                "")
                .toString();
        editProductController.caloryController.text =
            (editProductController
                .editModel.value.data!.productDetail!. calories??
                "")
                .toString();
        editProductController.priceController.text =
            (editProductController
                .editModel.value.data!.productDetail!.variants![0].price ??
                "")
                .toString();

      }
      setState(() {

      });
    });
    print(editProductController.id.value);
    vendorAllCategoryController.getVendorAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "Edit Products", context: context),
          body: editProductController.isDataLoading.value
              ?

                    SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AddSize.padding16,
                          vertical: AddSize.padding10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppTheme.backgroundcolor),
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding10),
                              child: Column(
                                children: [
                                  Obx(() {
                                    return DottedBorder(
                                        radius: const Radius.circular(10),
                                        borderType: BorderType.RRect,
                                        dashPattern: const [3, 5],
                                        color: Colors.grey.shade500,
                                        strokeWidth: 1,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AddSize.padding16,
                                                vertical: AddSize.padding16),
                                            width: AddSize.screenWidth,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: image.value.path == ""
                                                ? SizedBox(
                                                    height: AddSize.size40,
                                                    width: AddSize.size40,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          (editProductController
                                                              .editModel
                                                              .value
                                                              .data?.productDetail!.image ?? "").toString(),
                                                      errorWidget: (_, __, ___) =>
                                                          const SizedBox(),
                                                      placeholder: (_, __) =>
                                                          const SizedBox(),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: double.maxFinite,
                                                    height: AddSize.size100,
                                                    child: Image.file(
                                                        image.value))));
                                  }),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  RegistrationTextField(
                                    hint: "Product Name",
                                    controller: editProductController
                                        .productNameController,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Please enter product name")
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  RegistrationTextField(
                                    hint: "SKU",
                                    controller:
                                        editProductController.skuController,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Please enter SKU")
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  RegistrationTextField(
                                    hint: "Description",
                                    controller:
                                    editProductController.descriptionController,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Please enter SKU")
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RegistrationTextField(
                                          hint: "Price",
                                          controller:
                                          editProductController.priceController,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "Please enter SKU")
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: AddSize.size10,
                                      ),
                                      Expanded(
                                        child: RegistrationTextField(
                                          hint: "Calories",
                                          controller:
                                          editProductController.caloryController,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "Please enter SKU")
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: editProductController.listModelData.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return repeatUnit(
                                              qty1: editProductController.listModelData[index].qty.value,
                                              price1: editProductController
                                                  .listModelData[index]
                                                  .price
                                                  .value,
                                              minQty1: editProductController
                                                  .listModelData[index]
                                                  .minQty
                                                  .value,
                                              maxQty1: editProductController
                                                  .listModelData[index]
                                                  .maxQty
                                                  .value,
                                              marketPrice1: editProductController
                                                  .listModelData[index]
                                                  .marketPrice!
                                                  .value,
                                              index: index);
                                        });
                                  })
                                ],
                              ),
                            ),
                            SizedBox(
                              height: AddSize.size20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: AddSize.size30,
                                    width: AddSize.size30,
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade600,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                        child: GestureDetector(
                                      onTap: () {
                                        editProductController.listModelData.add(
                                            ListModel(
                                                qty: "".obs,
                                                varientId: "".obs,
                                                price: "".obs,
                                                minQty: "".obs,
                                                maxQty: "".obs,
                                                qtyType: "".obs,
                                                marketPrice: "".obs));
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.backgroundcolor,
                                        size: AddSize.size25,
                                      ),
                                    )),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: AddSize.size20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      image.value.path != "") {
                                    print("hello");
                                    Map<String, String> map = {};

                                    map['name'] = editProductController
                                        .productNameController.text;

                                    map['description'] = editProductController
                                        .descriptionController.text;

                                    map['SKU'] =
                                        editProductController.skuController.text;
                                    map['type'] = chooseOptionType.toString();
                                    map['category'] =vendorAllCategoryController.model.value.data!.categories![0].id.toString();
                                    map['calories'] = editProductController.caloryController.text;
                                    map['price'] =
                                        editProductController.priceController.text;
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
                                    List<AddonsModel> gg = [];

                                    editProductController.editModel.value.data!.singlePageAddons!.forEach((element) {
                                      AddonsModel addons = AddonsModel(addonData: []);
                                      element.addonData!.forEach((element1) {
                                        addons.addonData!.add(
                                            AddonDataaa(
                                                title: element.title,
                                                multiSelect: (element.multiSelectAddons ?? false) ? "1" : "0",
                                                price: element1.price,
                                                name: element1.name,
                                                calories: element1.calories
                                            )
                                        );
                                      });
                                      gg.add(addons);
                                    });
                                    map["addons"] = gg.map((e) => jsonEncode(e)).toList().toString();
                                    print(map);

                                    // [
                                    //   {
                                    //     "addon_data": [
                                    //       {
                                    //         "title": "protein",
                                    //         "multi_select": 0,
                                    //         "name": "pepsi1",
                                    //         "calories": 1200,
                                    //         "price": 15
                                    //       },
                                    //       {
                                    //         "title": "protein",
                                    //         "multi_select": 0,
                                    //         "name": "pepsi test",
                                    //         "calories": 1200,
                                    //         "price": 12
                                    //       }]
                                    //   },
                                    //   {
                                    //     "addon_data": [
                                    //       {
                                    //         "title": "protein",
                                    //         "multi_select": 0,
                                    //         "name": "pepsi",
                                    //         "calories": 1200,
                                    //         "price": 10
                                    //       },
                                    //       {
                                    //         "title": "protein",
                                    //         "multi_select": 0,
                                    //         "name": "pepsi2",
                                    //         "calories": 1200,
                                    //         "price": 20
                                    //       }]
                                    //   }]

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
                                        // homeController.getData();
                                        Get.back();
                                      } else {
                                        showToast(value.message);
                                      }
                                    });
                                  }
                                  else {
                                    showValidation.value = true;
                                    if (image.value.path.isEmpty) {
                                      scrollNavigation(10);
                                    } else if (editProductController
                                        .productNameController.text
                                        .trim()
                                        .isEmpty) {
                                      scrollNavigation(0);
                                    } else if (editProductController
                                        .descriptionController.text
                                        .trim()
                                        .isEmpty) {
                                      scrollNavigation(50);
                                    } else if (editProductController
                                        .skuController.text
                                        .trim()
                                        .isEmpty) {
                                      scrollNavigation(50);
                                    } else if (chooseOptionType == "") {
                                      scrollNavigation(50);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize:
                                      Size(double.maxFinite, AddSize.size45),
                                  primary: AppTheme.primaryColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  "SAVE",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: AppTheme.backgroundcolor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: AddSize.font18),
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
              : const Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }

  Padding repeatUnit({
    required String qty1,
    required String price1,
    required String minQty1,
    required String maxQty1,
    required String marketPrice1,
    required int index,
  }) {
    final TextEditingController qty = TextEditingController(text: qty1);
    final TextEditingController price = TextEditingController(text: price1);
    final TextEditingController minQty = TextEditingController(text: minQty1);
    final TextEditingController maxQty = TextEditingController(text: maxQty1);
    final TextEditingController marketPrice =
        TextEditingController(text: marketPrice1);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RegistrationTextField1(
                  hint: "Market Price",
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editProductController.listModelData[index].marketPrice!.value = value;
                  },
                  controller: marketPrice,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: "Please enter the market price")
                  ]),
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
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey.shade50,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      )),
                  child: Row(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: RegistrationTextField2(
                          onChanged: (value) {
                            editProductController
                                .listModelData[index].qty.value = value;
                          },
                          hint: "Qty",
                          keyboardType: TextInputType.number,
                          controller: qty,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Please enter qty")
                          ]),
                        ),
                      ),
                      const VerticalDivider(width: 1.0),
                      Obx(() {
                        return Expanded(
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            dropdownColor: Colors.grey.shade50,
                            iconEnabledColor: AppTheme.primaryColor,
                            hint: Text(
                              'Type',
                              style: TextStyle(
                                  color: AppTheme.userText,
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                            decoration: const InputDecoration(
                                enabled: true, border: InputBorder.none),
                            value: editProductController
                                        .listModelData[index].qtyType.value ==
                                    ""
                                ? null
                                : editProductController
                                    .listModelData[index].qtyType.value,
                            items: qtyType.map((value) {
                              return DropdownMenuItem(
                                value: value.key.toString(),
                                child: Text(
                                  value.value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AddSize.font14,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              editProductController.listModelData[index].qtyType
                                  .value = newValue as String;
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Expanded(
                child: RegistrationTextField1(
                  errorMaxLines: 2,
                  hint: "Price",
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editProductController.listModelData[index].price.value =
                        value;
                  },
                  controller: price,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter price")]),
                ),
              ),
              IconButton(
                  onPressed: () {
                    editProductController.listModelData.length == 1?null:
                    editProductController.listModelData.removeAt(index);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppTheme.primaryColor,
                    size: 30,
                  )),
            ],
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Row(
            children: [
              Expanded(
                child: RegistrationTextField1(
                  errorMaxLines: 2,
                  hint: "Min Qty",
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editProductController.listModelData[index].minQty.value =
                        value;
                  },
                  controller: minQty,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Please enter the Minimum qty")
                  ]),
                ),
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Expanded(
                child: RegistrationTextField1(
                  hint: "Max Qty",
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editProductController.listModelData[index].maxQty.value =
                        value;
                  },
                  controller: maxQty,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Please enter the Max qty")
                  ]),
                ),
              ),
            ],
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
