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
import '../../controller/vendorAddProductController.dart';
import '../../resources/app_assets.dart';
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
                                                      .headline6!
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
                                                  .headline6!
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
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.backgroundcolor),
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding16,
                              vertical: AddSize.padding10),
                          child: Obx(() {
                            if (vendorAddProductController
                                    .isDataLoading.value &&
                                vendorAddProductController
                                        .vendorAddProductModel.value.data !=
                                    null) {
                              vendorAddProductController
                                      .productNameController.text =
                                  vendorAddProductController
                                      .vendorAddProductModel.value.data!.name
                                      .toString();
                              vendorAddProductController
                                      .marketPriceController.text =
                                  vendorAddProductController
                                      .vendorAddProductModel
                                      .value
                                      .data!
                                      .marketPrice
                                      .toString();
                              vendorAddProductController
                                      .myPriceController.text =
                                  vendorAddProductController
                                      .vendorAddProductModel
                                      .value
                                      .data!
                                      .regularPrice
                                      .toString();
                              vendorAddProductController.skuController.text =
                                  vendorAddProductController
                                      .vendorAddProductModel.value.data!.sKU
                                      .toString();
                              vendorAddProductController.qtyController.text =
                                  vendorAddProductController
                                      .vendorAddProductModel.value.data!.qty
                                      .toString();

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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                    child: Icon(
                                                      Icons
                                                          .file_upload_outlined,
                                                      size: AddSize.size30,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: AddSize.size10,
                                                  ),
                                                  const Text(
                                                      "Upload  Product image"),
                                                ],
                                              )
                                            : vendorAddProductController
                                                    .vendorAddProductModel
                                                    .value
                                                    .data!
                                                    .image!
                                                    .isNotEmpty
                                                ? SizedBox(
                                                    width: double.maxFinite,
                                                    height: AddSize.size100,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          vendorAddProductController
                                                              .vendorAddProductModel
                                                              .value
                                                              .data!
                                                              .image!
                                                              .toString(),
                                                      errorWidget:
                                                          (_, __, ___) =>
                                                              const SizedBox(),
                                                      placeholder: (_, __) =>
                                                          const SizedBox(),
                                                    ))
                                                : SizedBox(
                                                    width: double.maxFinite,
                                                    height: AddSize.size100,
                                                    child: Image.file(
                                                        image.value)))),
                                SizedBox(
                                  height: AddSize.size10,
                                ),
                                RegistrationTextField(
                                  hint: "Product Name",
                                  controller: vendorAddProductController
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
                                  hint: "Market Price",
                                  controller: vendorAddProductController
                                      .marketPriceController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please enter price")
                                  ]),
                                ),
                                SizedBox(
                                  height: AddSize.size10,
                                ),
                                RegistrationTextField(
                                  hint: "My Price",
                                  controller: vendorAddProductController
                                      .myPriceController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please enter my price")
                                  ]),
                                ),
                                SizedBox(
                                  height: AddSize.size10,
                                ),
                                RegistrationTextField(
                                  hint: "SKU",
                                  controller:
                                      vendorAddProductController.skuController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please enter SKU")
                                  ]),
                                ),
                                SizedBox(
                                  height: AddSize.size10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: RegistrationTextField(
                                        hint: "Qty",
                                        controller: vendorAddProductController
                                            .qtyController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Please enter qty")
                                        ]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AddSize.size10,
                                    ),
                                    Expanded(
                                      child: RegistrationTextField(
                                        hint: "Price",
                                        controller: vendorAddProductController
                                            .priceController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Please enter price")
                                        ]),
                                      ),
                                    )
                                  ],
                                ),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          color: AppTheme.backgroundcolor,
                                          size: AddSize.size25,
                                        )),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          }),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppTheme.backgroundcolor),
                            padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding16,
                                vertical: AddSize.padding10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Image Gallery",
                                        style: TextStyle(
                                            fontSize: AddSize.font14,
                                            color: AppTheme.blackcolor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          showChangeAddressSheet();
                                        },
                                        child: Text(
                                          "Choose From Gallery",
                                          style: TextStyle(
                                              fontSize: AddSize.font12,
                                              color: AppTheme.primaryColor,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                                Obx(() {
                                  return Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: imageList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AddSize.padding16,
                                                vertical: AddSize.padding16),
                                            margin: EdgeInsets.all(05),
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300)),
                                            child: imageList[index].path == ""
                                                ? GestureDetector(
                                                    onTap: () {
                                                      NewHelper()
                                                          .addFilePicker()
                                                          .then((value) {
                                                        if (imageList[index]
                                                                .path ==
                                                            "") {
                                                          imageList[index] =
                                                              value!;
                                                          // Get.back();
                                                          // break;
                                                        }
                                                      });
                                                      // NewHelper()
                                                      //     .addFilePicker()
                                                      //     .then((value) {
                                                      //   image.value = value;
                                                      // });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Center(
                                                          child: Image(
                                                              height: AddSize
                                                                  .size25,
                                                              width: AddSize
                                                                  .size25,
                                                              color: Colors.grey
                                                                  .shade500,
                                                              image: const AssetImage(
                                                                  AppAssets
                                                                      .camaraImage))),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: double.maxFinite,
                                                    height: AddSize.size100,
                                                    child: Image.file(File(
                                                        imageList[index]
                                                            .path))));
                                      },
                                    ),
                                  );
                                }),
                              ],
                            )),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Get.back();
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
      );
    });
  }
}
