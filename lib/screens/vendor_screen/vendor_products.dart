import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fresh2_arrive/screens/vendor_screen/edit_product.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/Edit_Products_Controller.dart';
import '../../controller/vendorAddProductController.dart';
import '../../controller/vendor_productList_controller.dart';
import '../../model/ListModel.dart';
import '../../repositories/ToggleStatus_Repo.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';
import 'Add_vendor_product.dart';

class VendorProductScreen extends StatefulWidget {
  const VendorProductScreen({Key? key}) : super(key: key);
  static var vendorProductScreen = "/vendorProductScreen";

  @override
  State<VendorProductScreen> createState() => _VendorProductScreenState();
}

class _VendorProductScreenState extends State<VendorProductScreen> {
  final vendorProductListController = Get.put(VendorProductListController());
  final editProductsController = Get.put(EditProductsController());
  final vendorAddProductController = Get.put(VendorAddProductController());
  // final TextEditingController searchController = TextEditingController();
  final RxList<bool> _store = <bool>[].obs;
  RxList<ListModel> listModelData = <ListModel>[].obs;
  Rx<File> image = File("").obs;
  RxList<File> imageList = <File>[].obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vendorProductListController.getVendorProductList();

      for (var i = 0; i < 10; i++) {
        _store.add(false);
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "All Products", context: context),
        body: Obx(() {
          return vendorProductListController.isDataLoading.value
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
                    child: Column(
                      children: [
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: AddSize.size80 * 3.6,
                              decoration: BoxDecoration(
                                  color: AppTheme.backgroundcolor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        // offset: Offset(2, 2),
                                        blurRadius: 05)
                                  ]),
                              child: TextField(
                                maxLines: 1,
                                controller: vendorProductListController
                                    .searchController,
                                style: const TextStyle(fontSize: 17),
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.search,
                                onChanged: (value) => {
                                  vendorProductListController
                                      .getVendorProductList()
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        vendorProductListController
                                            .getVendorProductList();
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        color: AppTheme.lightblack,
                                        size: AddSize.size25,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding20,
                                        vertical: AddSize.padding10),
                                    hintText: 'Search Products',
                                    hintStyle: TextStyle(
                                        fontSize: AddSize.font12,
                                        color: AppTheme.blackcolor,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AddVendorProduct.addVendorProduct);
                              },
                              child: Container(
                                height: AddSize.size20 * 2.2,
                                width: AddSize.size20 * 2.2,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
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
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        vendorProductListController
                            .model.value.data!.isNotEmpty ?
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: vendorProductListController
                              .model.value.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: AddSize.size5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundcolor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding10),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: AddSize.size80,
                                        width: AddSize.size80,
                                        child: CachedNetworkImage(
                                          imageUrl: vendorProductListController
                                              .model.value.data![index].image
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      print(
                                                          vendorProductListController
                                                              .model
                                                              .value
                                                              .data![index]
                                                              .product!
                                                              .id
                                                              .toString());
                                                    },
                                                    child: Text(
                                                      vendorProductListController
                                                          .model
                                                          .value
                                                          .data![index]
                                                          .product!
                                                          .name
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: AddSize
                                                                  .font16,
                                                              color: AppTheme
                                                                  .blackcolor),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    editProductsController
                                                            .id.value =
                                                        vendorProductListController
                                                            .model
                                                            .value
                                                            .data![index]
                                                            .id
                                                            .toString();
                                                    Get.toNamed(
                                                      EditProductScreen
                                                          .editProductScreen,
                                                    );
                                                  },
                                                  child: Container(
                                                      height: AddSize.size30,
                                                      width: AddSize.size30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: AppTheme
                                                                  .primaryColor)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: AppTheme
                                                              .primaryColor,
                                                          size: AddSize.size15,
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  vendorProductListController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .product!
                                                      .qty
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              AddSize.font14,
                                                          color:
                                                              AppTheme.subText),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  vendorProductListController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .product!
                                                      .qtyType
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              AddSize.font14,
                                                          color:
                                                              AppTheme.subText),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹${vendorProductListController.model.value.data![index].product!.regularPrice.toString()}",
                                                  //"100",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              AddSize.font16,
                                                          color: AppTheme
                                                              .primaryColor),
                                                ),
                                                Obx(() {
                                                  return FlutterSwitch(
                                                    width: AddSize.size30 * 2.2,
                                                    height:
                                                        AddSize.size20 * 1.4,
                                                    valueFontSize:
                                                        AddSize.font12,
                                                    toggleSize: AddSize.size20,
                                                    activeTextFontWeight:
                                                        FontWeight.w500,
                                                    activeText: "   IN",
                                                    inactiveText: "   OUT",
                                                    inactiveTextColor: AppTheme
                                                        .backgroundcolor,
                                                    activeTextColor: AppTheme
                                                        .backgroundcolor,
                                                    inactiveTextFontWeight:
                                                        FontWeight.w500,
                                                    inactiveColor:
                                                        Colors.grey.shade400,
                                                    activeColor:
                                                        AppTheme.primaryColor,
                                                    value:
                                                        vendorProductListController
                                                            .model
                                                            .value
                                                            .data![index]
                                                            .status!,
                                                    borderRadius: 20.0,
                                                    showOnOff: true,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        vendorProductListController
                                                            .model
                                                            .value
                                                            .data![index]
                                                            .status = val;
                                                        print(val);

                                                        toggleStatusRepo(
                                                                id: vendorProductListController
                                                                    .model
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString())
                                                            .then((value) {
                                                          if (value.status ==
                                                              true) {}
                                                          showToast(value
                                                              .message
                                                              .toString());
                                                          print(value.message
                                                              .toString());
                                                        });
                                                      });
                                                    },
                                                  );
                                                })
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ):
                        Center(
                            child: Padding(
                                padding: EdgeInsets.only(top: AddSize.size200),
                                child: Text(
                                  "Product Not Available",
                                  style: TextStyle(
                                      fontSize: AddSize.font16,
                                      color: AppTheme.blackcolor,
                                      fontWeight: FontWeight.w500),
                                )))
                      ],
                    ),
                  ))
              : const Center(child: CircularProgressIndicator());
        }));
  }
}
