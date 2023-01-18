import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fresh2_arrive/screens/vendor_screen/edit_product.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../../resources/app_theme.dart';
import '../../widgets/add_text.dart';
import '../../widgets/dimensions.dart';
import 'Add_vendor_product.dart';

class VendorProductScreen extends StatefulWidget {
  const VendorProductScreen({Key? key}) : super(key: key);
  static var vendorProductScreen = "/vendorProductScreen";
  @override
  State<VendorProductScreen> createState() => _VendorProductScreenState();
}

class _VendorProductScreenState extends State<VendorProductScreen> {
  final TextEditingController searchController = TextEditingController();
  final RxList<bool> _store = <bool>[].obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < 10; i++) {
      _store.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "All Products", context: context),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16, vertical: AddSize.padding10),
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
                          controller: searchController,
                          style: const TextStyle(fontSize: 17),
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => {},
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {},
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
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: AddSize.size5),
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
                                    imageUrl:
                                        "https://media.istockphoto.com/id/673162168/photo/green-cabbage-isolated-on-white.jpg?s=612x612&w=0&k=20&c=mCc4mXATvCcfp2E9taRJBp-QPYQ_LCj6nE1D7geaqVk=",
                                    errorWidget: (_, __, ___) =>
                                        const SizedBox(),
                                    placeholder: (_, __) => const SizedBox(),
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
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Broccoli Flower Broccoli Flower",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: AddSize.font16,
                                                      color:
                                                          AppTheme.blackcolor),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(EditProductScreen
                                                  .editProductScreen);
                                            },
                                            child: Container(
                                                height: AddSize.size30,
                                                width: AddSize.size30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: Border.all(
                                                        color: AppTheme
                                                            .primaryColor)),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color:
                                                        AppTheme.primaryColor,
                                                    size: AddSize.size15,
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "50 KG",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font14,
                                                color: AppTheme.subText),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$10.00",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font16,
                                                    color:
                                                        AppTheme.primaryColor),
                                          ),
                                          Obx(() {
                                            return FlutterSwitch(
                                              width: AddSize.size30 * 2.2,
                                              height: AddSize.size20 * 1.4,
                                              valueFontSize: AddSize.font12,
                                              toggleSize: AddSize.size20,
                                              activeTextFontWeight:
                                                  FontWeight.w500,
                                              activeText: "   IN",
                                              inactiveText: "   OUT",
                                              inactiveTextColor:
                                                  AppTheme.backgroundcolor,
                                              activeTextColor:
                                                  AppTheme.backgroundcolor,
                                              inactiveTextFontWeight:
                                                  FontWeight.w500,
                                              inactiveColor:
                                                  Colors.grey.shade400,
                                              activeColor:
                                                  AppTheme.primaryColor,
                                              value: _store[index],
                                              borderRadius: 20.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                _store[index] = val;
                                              },
                                            );
                                          }),
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
                  )
                ],
              ),
            )));
  }
}
