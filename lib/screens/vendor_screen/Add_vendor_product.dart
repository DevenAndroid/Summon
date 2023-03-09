import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/registration_form_textField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controller/vendorAddProductController.dart';
import '../../model/ListModel.dart';
import '../../repositories/Vendor_SaveProduct_Repo.dart';
import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';

class AddVendorProduct extends StatefulWidget {
  const AddVendorProduct({Key? key}) : super(key: key);
  static var addVendorProduct = "/addVendorProduct";

  @override
  State<AddVendorProduct> createState() => _AddVendorProductState();
}

class _AddVendorProductState extends State<AddVendorProduct> {
  final vendorAddProductController = Get.put(VendorAddProductController());
  Rx<File> image = File("").obs;
  final _formKey = GlobalKey<FormState>();
  RxList<ListModel> listModelData = <ListModel>[].obs;
  String? selectedType;
  final List<String> quintityType = [
    "kg",
    "grm",
    "ltr",
    "ml",
    "dozen",
    "piece"
  ];

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
    vendorAddProductController.getVendorSearchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: "Add Products", context: context),
        body: vendorAddProductController.isDataLoading.value
            ? SingleChildScrollView(
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
                            color: AppTheme.backgroundcolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            maxLines: 1,
                            controller: vendorAddProductController
                                .vendorSearchProductController,
                            style: const TextStyle(fontSize: 17),
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              vendorAddProductController
                                  .getVendorSearchProductList();
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    vendorAddProductController
                                        .getVendorSearchProductList();
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: AppTheme.lightblack,
                                    size: AddSize.size25,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding20,
                                    vertical: AddSize.padding10),
                                hintText: 'Search Products',
                                hintStyle: TextStyle(
                                    fontSize: AddSize.font14,
                                    color: AppTheme.blackcolor,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        vendorAddProductController
                                .vendorSearchProductController.text.isNotEmpty
                            ? Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppTheme.backgroundcolor),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding10),
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: vendorAddProductController
                                        .model.value.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          vendorAddProductController
                                                  .productId.value =
                                              vendorAddProductController
                                                  .model.value.data![index].id
                                                  .toString();
                                          vendorAddProductController
                                              .getVendorAddProduct();
                                          vendorAddProductController
                                              .vendorSearchProductController
                                              .clear();
                                          image.value = File("");
                                          setState(() {});
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: AddSize.size40,
                                                  width: AddSize.size40,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        vendorAddProductController
                                                            .model
                                                            .value
                                                            .data![index]
                                                            .image
                                                            .toString(),
                                                    errorWidget: (_, __, ___) =>
                                                        const SizedBox(),
                                                    placeholder: (_, __) =>
                                                        const SizedBox(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: AddSize.size10,
                                                ),
                                                Text(
                                                  vendorAddProductController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .name
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              AddSize.font14,
                                                          color: AppTheme
                                                              .lightblack),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              vendorAddProductController
                                                  .model
                                                  .value
                                                  .data![index]
                                                  .regularPrice
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: AddSize.font14,
                                                      color:
                                                          AppTheme.lightblack),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              })
                            : const SizedBox(),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        // if (vendorAddProductController
                        //     .vendorSearchProductController.text.isNotEmpty)
                        editProduct(),
                        SizedBox(
                          height: AddSize.size10,
                        ),

                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("Hello this is map");

                                Map<String, String> map = {
                                  // 'product_id': vendorAddProductController
                                  //     .vendorAddProductModel.value.data!.id,
                                  // 'category_id': vendorAddProductController
                                  //     .vendorAddProductModel.value.data!.id,
                                  // 'image': vendorAddProductController
                                  //     .vendorAddProductModel.value.data!.image,
                                };
                                // map['id'] = vendorAddProductController
                                //     .vendorAddProductModel.value.data!.id
                                //     .toString();
                                map['product_id'] = vendorAddProductController
                                    .vendorAddProductModel.value.data!.id
                                    .toString();
                                map['category_id'] = vendorAddProductController
                                    .vendorAddProductModel
                                    .value
                                    .data!
                                    .category!
                                    .id
                                    .toString();
                                map['imageOld'] = vendorAddProductController
                                    .vendorAddProductModel.value.data!.image
                                    .toString();
                                // map['variant_id'] = vendorAddProductController
                                //     .vendorAddProductModel.value.data!.id;

                                for (var i = 0; i < listModelData.length; i++) {
                                  map["variants[$i][variant_qty]"] =
                                      listModelData[i].qty.value.toString();
                                  map["variants[$i][variant_qty_type]"] =
                                      listModelData[i].qtyType.value.toString();
                                  map["variants[$i][min_qty]"] =
                                      listModelData[i].minQty.value.toString();
                                  map["variants[$i][max_qty]"] =
                                      listModelData[i].maxQty.value.toString();
                                  map["variants[$i][price]"] =
                                      listModelData[i].price.value.toString();
                                }
                                // print("Map data...$map");

                                vendorSaveProductRepo(
                                        fieldName1: "image",
                                        mapData: map,
                                        context: context,
                                        file1: image.value)
                                    .then((value) {
                                  if (value.status == true) {
                                    showToast(value.message);
                                  }
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(double.maxFinite, AddSize.size45),
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: AddSize.font18),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }

  Container editProduct() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.backgroundcolor),
      padding: EdgeInsets.symmetric(
          horizontal: AddSize.padding16, vertical: AddSize.padding10),
      child: Obx(() {
        if (vendorAddProductController.isDataLoading.value &&
            vendorAddProductController.vendorAddProductModel.value.data !=
                null) {
          if (vendorAddProductController.initialSelect == false) {
            listModelData.add(ListModel(
                qty: "".obs,
                price: "".obs,
                minQty: "".obs,
                maxQty: "".obs,
                qtyType: "".obs));
            vendorAddProductController.productNameController.text =
                (vendorAddProductController
                            .vendorAddProductModel.value.data!.name ??
                        "")
                    .toString();
            vendorAddProductController.skuController.text =
                (vendorAddProductController
                            .vendorAddProductModel.value.data!.sKU ??
                        "")
                    .toString();
            // vendorAddProductController.qtyController.text =
            //     (vendorAddProductController
            //                 .vendorAddProductModel.value.data!.qty ??
            //             "")
            //         .toString();
            listModelData[0].price.value =
                "₹ ${(vendorAddProductController.vendorAddProductModel.value.data!.regularPrice ?? "").toString()}";
            listModelData[0].qty.value = (vendorAddProductController
                        .vendorAddProductModel.value.data!.qty ??
                    "")
                .toString();
            listModelData[0].qtyType.value = (vendorAddProductController
                        .vendorAddProductModel.value.data!.qtyType ??
                    "")
                .toString();
            listModelData[0].minQty.value = (vendorAddProductController
                        .vendorAddProductModel.value.data!.minQty ??
                    "")
                .toString();
            listModelData[0].maxQty.value = (vendorAddProductController
                        .vendorAddProductModel.value.data!.maxQty ??
                    "")
                .toString();
            vendorAddProductController.initialSelect = true;
          }

          print(
              "Selecting the search item ${vendorAddProductController.productNameController.text}");
        }
        return Column(
          children: [
            DottedBorder(
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: image.value.path != ""
                        ? SizedBox(
                            width: double.maxFinite,
                            height: AddSize.size100,
                            child: GestureDetector(
                              onTap: () {
                                NewHelper().addFilePicker().then((value) {
                                  image.value = value;
                                });
                              },
                              child: Image.file(image.value),
                            ))
                        : Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  NewHelper().addFilePicker().then((value) {
                                    image.value = value;
                                  });
                                },
                                child: CachedNetworkImage(
                                  imageUrl: vendorAddProductController
                                              .vendorAddProductModel
                                              .value
                                              .data !=
                                          null
                                      ? vendorAddProductController
                                              .vendorAddProductModel
                                              .value
                                              .data!
                                              .image ??
                                          "".toString()
                                      : "",
                                  errorWidget: (_, __, ___) => Icon(
                                    Icons.file_upload_outlined,
                                    size: AddSize.size30,
                                  ),
                                  placeholder: (_, __) => const SizedBox(),
                                ),
                              ),
                              SizedBox(
                                height: AddSize.size10,
                              ),
                              const Text("Upload  Product image"),
                            ],
                          ))),
            SizedBox(
              height: AddSize.size10,
            ),
            RegistrationTextField(
              readOnly: true,
              hint: "Product Name",
              controller: vendorAddProductController.productNameController,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please enter product name")]),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            RegistrationTextField(
              readOnly: true,
              hint: "SKU",
              controller: vendorAddProductController.skuController,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please enter SKU")]),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Obx(() {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: listModelData.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return repeatUnit(
                        qty1: listModelData[index].qty.value,
                        price1: listModelData[index].price.value,
                        minQty1: listModelData[index].minQty.value,
                        maxQty1: listModelData[index].maxQty.value,
                        index: index);
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
                    height: AddSize.size30,
                    width: AddSize.size30,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade600,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        listModelData.add(ListModel(
                            qty: "".obs,
                            price: "".obs,
                            minQty: "".obs,
                            maxQty: "".obs,
                            qtyType: "".obs));
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
            )
          ],
        );
      }),
    );
  }

  Padding repeatUnit({
    required String qty1,
    required String price1,
    required String minQty1,
    required String maxQty1,
    required int index,
  }) {
    final TextEditingController qty = TextEditingController(text: qty1);
    final TextEditingController price = TextEditingController(text: price1);
    final TextEditingController minQty = TextEditingController(text: minQty1);
    final TextEditingController maxQty = TextEditingController(text: maxQty1);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
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
                        child: RegistrationTextField1(
                          onChanged: (value) {
                            listModelData[index].qty.value = value;
                          },
                          hint: "Qty",
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
                            value: listModelData[index].qtyType.value == ""
                                ? null
                                : listModelData[index].qtyType.value,
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
                              listModelData[index].qtyType.value =
                                  newValue as String;
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
                  hint: "Price",
                  onChanged: (value) {
                    listModelData[index].price.value = value;
                  },
                  controller: price,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "Please enter price")]),
                ),
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
                  hint: "Min",
                  onChanged: (value) {
                    listModelData[index].minQty.value = value;
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
                  hint: "Max",
                  onChanged: (value) {
                    listModelData[index].maxQty.value = value;
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
}
