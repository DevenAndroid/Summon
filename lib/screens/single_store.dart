import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/single_category_product.dart';
import 'package:fresh2_arrive/screens/store_by_category.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../controller/cart_related_product_controller.dart';
import '../controller/category_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/single_store_controller.dart';
import '../controller/store_by_category_controller.dart';
import '../controller/store_controller.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  static var singleStoreScreen = "/singleStoreScreen";

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final singleStoreController = Get.put(StoreController());
  final storeController = Get.put(SingleStoreController());
  final myCartController = Get.put(MyCartDataListController());
  final relatedCartController = Get.put(CartRelatedProductController());
  final controller = Get.put(MainHomeController());
  final categoryController = Get.put(CategoryController());
  final singleCategoryController = Get.put(SingleCategoryController());
  final nearStoreController = Get.put(StoreByCategoryController());
  String? selectedCAt;
  final RxBool _isValue = false.obs;
  final scrollController = ScrollController();


  void _scrollListener1() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      storeController
          .getStoreDetails()
          .then((value) => setState(() {}));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      storeController.searchController.clear();
      storeController.getStoreDetails(isFirstTime: true);
      scrollController.addListener(_scrollListener1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: "Store", context: context),
        body: storeController.isDataLoading.value  && categoryController.isDataLoading.value && storeController.storeDetailsModel.value.data != null ||(storeController.storeDetailsModel.value.data !=null)
                ? CustomScrollView(
          controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        excludeHeaderSemantics: false,
                        snap: false,
                        floating: false,
                        expandedHeight: height * .285,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        leadingWidth: 0,
                        // toolbarHeight: 150,
                        // title: ,
                        bottom: PreferredSize(
                            preferredSize: Size(width, AddSize.size40 * 1.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .03),
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AddSize.padding16,
                                          vertical: AddSize.padding16),
                                      // height: 100,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  storeController
                                                      .storeDetailsModel
                                                      .value
                                                      .data!
                                                      .storeDetails!
                                                      .storeName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Expanded(
                                                child: Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w100),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * .01,
                                )
                              ],
                            )),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: EdgeInsets.only(bottom: AddSize.size45),
                            child: CachedNetworkImage(
                              imageUrl: storeController.storeDetailsModel
                                  .value.data!.storeDetails!.storeImage
                                  .toString(),
                              errorWidget: (_, __, ___) => const SizedBox(),
                              placeholder: (_, __) => const SizedBox(),
                              fit: BoxFit.cover,
                            ),
                            // Image.network(
                            //   storeController.storeDetailsModel.value.data!
                            //       .storeDetails!.storeImage
                            //       .toString(),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * .03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
//                                 SizedBox(
//                                   height: height * .012,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text(
//                                       'Categories',
//                                       style: TextStyle(
//                                           color: AppTheme.blackcolor,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.back();
//                                         Get.back();
//                                         Get.back();
//                                         controller.currentIndex.value = 0;
//                                       },
//                                       child: const Text(
//                                         'View All',
//                                         style: TextStyle(
//                                             color: AppTheme.primaryColor,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: height * .01,
//                                 ),
//                                 SizedBox(
//                                     height: height * 0.13,
//                                     child: Obx(() {
//                                  return ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: const BouncingScrollPhysics(),
//                                       itemCount: min(4,
//                                         categoryController
//                                             .model.value.data!.length,
//                                       ),
//                                       scrollDirection: Axis.horizontal,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         return GestureDetector(
//                                           onTap: () {
//                                             singleCategoryController.categoryId.value =
//                                                 categoryController.model.value.data![index].id
//                                                     .toString();
//                                             singleCategoryController.storeId.value = storeController.storeDetailsModel
//                                                 .value.data!.storeDetails!.id.toString();
//                                             singleCategoryController.getData(isFirstTime: true);
//                                             _isValue.value = true;
//                                             setState(() {
//
//                                             });
//                                             // Get.toNamed(
//                                             //     StoreByCategoryListScreen
//                                             //         .storeByCategoryScreen);
//                                           },
//                                           child: Container(
//                                               width: AddSize.size50 * 2,
//                                               margin: EdgeInsets.only(
//                                                   right: AddSize.padding10),
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: AddSize.padding10,
//                                                   vertical: AddSize.size5),
//                                               decoration: BoxDecoration(
//                                                   color: index % 3 == 0
//                                                       ? AppTheme
//                                                           .appPrimaryPinkColor
//                                                       : index % 3 == 2
//                                                           ? AppTheme
//                                                               .appPrimaryGreenColor
//                                                           : AppTheme
//                                                               .appPrimaryYellowColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10)),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   SizedBox(
//                                                     height: AddSize.size50,
//                                                     width: AddSize.size50 * 1.2,
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10),
//                                                       child: CachedNetworkImage(
//                                                         imageUrl:
//                                                             categoryController
//                                                                 .model
//                                                                 .value
//                                                                 .data![index]
//                                                                 .image
//                                                                 .toString(),
//                                                         errorWidget: (_, __,
//                                                                 ___) =>
//                                                             const SizedBox(),
//                                                         placeholder: (_, __) =>
//                                                             const SizedBox(),
//                                                         fit: BoxFit.contain,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     categoryController.model
//                                                         .value.data![index].name
//                                                         .toString(),
//                                                     maxLines: 2,
//                                                     style: TextStyle(
//                                                         color: AppTheme.subText,
//                                                         fontSize:
//                                                             AddSize.font14,
//                                                         fontWeight:
//                                                             FontWeight.w500),
//                                                   )
//                                                 ],
//                                               )),
//                                         );
//                                       },
//                                     );
// })),

                                SizedBox(height: AddSize.size10,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppTheme.backgroundcolor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextField(
                                     controller: storeController.searchController,
                                    cursorColor: AppTheme.primaryColor,
                                    style: TextStyle(fontSize: AddSize.font16),
                                    textAlignVertical: TextAlignVertical.center,
                                    textInputAction: TextInputAction.search,
                                    onChanged: (value) => {
                                      // searchListData(searchController.text).then((value) {
                                      //   searchControllerList.searchList.value = value;
                                      // }),
                                      setState(() {})
                                    },
                                    onSubmitted: (value){
                                      storeController.getStoreDetails(isFirstTime: true);
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  storeController.getStoreDetails(isFirstTime: true);
                                                },
                                                  child: Icon(Icons.search,color: AppTheme.primaryColor,)),
                                              storeController.searchController.text.isNotEmpty?
                                              GestureDetector(
                                                  onTap: (){
                                                    storeController.searchController.clear();
                                                    storeController.getStoreDetails(isFirstTime: true);
                                                  },
                                                  child: Icon(Icons.clear,color: AppTheme.primaryColor,)):SizedBox(),
                                            ],
                                          ),
                                        ),
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding20,
                                            vertical: AddSize.padding16),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: AppTheme.primaryColor),
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: AppTheme.primaryColor),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(12.0))),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppTheme.primaryColor, width: 3.0),
                                            borderRadius: BorderRadius.circular(12.0)),
                                        hintText: 'Search product',
                                        hintStyle: TextStyle(
                                            fontSize: AddSize.font14,
                                            color: const Color(0xffB9B6B6),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),


                                SizedBox(height: height * .015),
                                const Text(
                                  "Latest Product",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              _isValue.value == true ? singleCategoryController.isDataLoading.value?
                              singleCategoryController
                                  .singleCategoryModel
                                  .value
                                  .data!.isNotEmpty ? ListView.builder(
                                    itemCount: singleCategoryController
                                        .singleCategoryModel
                                        .value
                                        .data!
                                        .length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                      top: height * .015,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // height: height * .23,
                                        child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: width * .02,
                                                    vertical: height * .01,
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              AddSize.size50 *
                                                                  1.2,
                                                          width:
                                                              AddSize.size50 *
                                                                  1.6,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: singleCategoryController
                                                                  .singleCategoryModel
                                                                  .value
                                                                  .data![index]
                                                                  .image
                                                                  .toString(),
                                                              errorWidget: (_,
                                                                      __,
                                                                      ___) =>
                                                                  const SizedBox(),
                                                              placeholder: (_,
                                                                      __) =>
                                                                  const SizedBox(),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * .02,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  (singleCategoryController
                                                                      .singleCategoryModel
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .name ?? "")
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      color: AppTheme
                                                                          .blackcolor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Container(
                                                                // width: width * .60,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            width *
                                                                                .02),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100),
                                                                child:
                                                                    buildDropdownButtonFormField(
                                                                        index),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: width *
                                                                            .02,
                                                                      ),
                                                                      Text(
                                                                        "₹${singleCategoryController
                                                                            .singleCategoryModel
                                                                            .value
                                                                            .data![
                                                                        index].varints![singleCategoryController
                                                                            .singleCategoryModel
                                                                            .value
                                                                            .data![
                                                                        index].varientIndex!.value].price.toString()}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                AppTheme.primaryColor,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            .02,
                                                                      ),
                                                                      Text(
                                                                        "₹${singleCategoryController
                                                                            .singleCategoryModel
                                                                            .value
                                                                            .data![
                                                                        index].varints![singleCategoryController
                                                                            .singleCategoryModel
                                                                            .value
                                                                            .data![
                                                                        index].varientIndex!.value].marketPrice.toString()}",
                                                                        style: const TextStyle(
                                                                            decoration: TextDecoration
                                                                                .lineThrough,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                      // SizedBox(
                                                                      //   width: width *
                                                                      //       .02,
                                                                      // ),
                                                                      // Text(
                                                                      //   "Qty: ${storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].maxQty.toString()}",
                                                                      //   style: TextStyle(
                                                                      //       fontSize: AddSize.font14,
                                                                      //       color: AppTheme.primaryColor,
                                                                      //       fontWeight: FontWeight.w500),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  myCartController
                                                                          .isDataLoaded
                                                                          .value
                                                                      ? myCartController
                                                                              .model
                                                                              .value
                                                                              .data!
                                                                              .cartItems!
                                                                              .map((e) => e.variantId.toString())
                                                                              .toList()
                                                                              .contains(singleCategoryController
                                                                      .singleCategoryModel
                                                                      .value
                                                                      .data![
                                                                  index].varints![singleCategoryController
                                                                      .singleCategoryModel
                                                                      .value
                                                                      .data![
                                                                  index].varientIndex!.value].id.toString())
                                                                          ? Container(
                                                                              width: width * .20,
                                                                              decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(6)),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(
                                                                                  vertical: height * .005,
                                                                                  horizontal: width * .02,
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        // removeCartItemRepo(storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString(), context);
                                                                                        if ((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() ==
                                                                                            singleCategoryController
                                                                                                .singleCategoryModel
                                                                                                .value
                                                                                                .data![
                                                                                            index].varints![singleCategoryController
                                                                                                .singleCategoryModel
                                                                                                .value
                                                                                                .data![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString() == singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varints![singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varientIndex!.value].minQty.toString()) {
                                                                                          removeCartItemRepo((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleCategoryController
                                                                                              .singleCategoryModel
                                                                                              .value
                                                                                              .data![
                                                                                          index].varints![singleCategoryController
                                                                                              .singleCategoryModel
                                                                                              .value
                                                                                              .data![
                                                                                          index].varientIndex!.value].id.toString(), orElse: () => CartItems()).id ?? "").toString(), context).then((value) {
                                                                                            if (value.status == true) {
                                                                                              showToast(value.message);
                                                                                              myCartController.getAddToCartList();
                                                                                            } else {
                                                                                              showToast(value.message);
                                                                                            }
                                                                                          });
                                                                                        } else {
                                                                                          addToCartRepo(singleCategoryController
                                                                                              .singleCategoryModel
                                                                                              .value
                                                                                              .data![
                                                                                          index].varints![singleCategoryController
                                                                                              .singleCategoryModel
                                                                                              .value
                                                                                              .data![
                                                                                          index].varientIndex!.value].id.toString(), singleCategoryController
                                                                                              .singleCategoryModel
                                                                                              .value
                                                                                              .data![
                                                                                          index].id.toString(), int.parse((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleCategoryController
                                                                                              .singleCategoryModel
                                                                                              .value
                                                                                              .data![
                                                                                          index].varints![singleCategoryController
                                                                                              .singleCategoryModel
                                                                                              .value
                                                                                              .data![
                                                                                          index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) - 1, context).then((value) {
                                                                                            showToast(value.message);
                                                                                            if (value.status == true) {
                                                                                              myCartController.getAddToCartList();
                                                                                            }
                                                                                            setState(() {});
                                                                                          });
                                                                                        }
                                                                                      },
                                                                                      child: const Icon(
                                                                                        Icons.remove,
                                                                                        color: AppTheme.backgroundcolor,
                                                                                        size: 15,
                                                                                      ),
                                                                                    ),
                                                                                    Obx(() {
                                                                                      return Text(
                                                                                        (myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varints![singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "").toString(),
                                                                                        style: TextStyle(fontSize: AddSize.font14, color: AppTheme.backgroundcolor, fontWeight: FontWeight.w500),
                                                                                      );
                                                                                    }),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varints![singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varientIndex!.value].maxQty != (myCartController.model.value
                                                                                            .data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varints![singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index]
                                                                                                    .varientIndex!
                                                                                                    .value]
                                                                                                    .id
                                                                                                    .toString(),
                                                                                            orElse: () =>
                                                                                                CartItems())
                                                                                            .cartItemQty ??
                                                                                            "") ?
                                                                                        addToCartRepo(singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varints![singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varientIndex!.value].id.toString(), singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].id.toString(), int.parse((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varints![singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) + 1, context).then((value) {
                                                                                          showToast(value.message);
                                                                                          if (value.status == true) {
                                                                                            myCartController.getAddToCartList();
                                                                                          } else {
                                                                                            showToast(value.message);
                                                                                          }
                                                                                        }):showToast("You can't add more then ${singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varints![singleCategoryController
                                                                                            .singleCategoryModel
                                                                                            .value
                                                                                            .data![
                                                                                        index].varientIndex!.value].maxQty.toString()} item");
                                                                                      },
                                                                                      child: const Icon(
                                                                                        Icons.add,
                                                                                        color: AppTheme.backgroundcolor,
                                                                                        size: 15,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : OutlinedButton(
                                                                              style: OutlinedButton.styleFrom(
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                                                                                minimumSize: Size(AddSize.size50, AddSize.size30),
                                                                                side: const BorderSide(color: AppTheme.primaryColor, width: 1),
                                                                                backgroundColor: AppTheme.addColor,
                                                                              ),
                                                                              onPressed: () {
                                                                                int vIndex = singleCategoryController
                                                                                    .singleCategoryModel
                                                                                    .value
                                                                                    .data![
                                                                                index].varientIndex!.value;
                                                                                addToCartRepo(singleCategoryController
                                                                                    .singleCategoryModel
                                                                                    .value
                                                                                    .data![
                                                                                index].varints![vIndex].id.toString(), singleCategoryController
                                                                                    .singleCategoryModel
                                                                                    .value
                                                                                    .data![
                                                                                index].id.toString(),singleCategoryController
                                                                                    .singleCategoryModel
                                                                                    .value
                                                                                    .data![
                                                                                index].varints![singleCategoryController
                                                                                    .singleCategoryModel
                                                                                    .value
                                                                                    .data![
                                                                                index].varientIndex!.value].minQty, context).then((value) {
                                                                                  if (value.status == true) {
                                                                                    showToast(value.message);
                                                                                    myCartController.getAddToCartList();
                                                                                    relatedCartController.getAddToCartRelatedList();
                                                                                  } else {
                                                                                    showToast(value.message);
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: Text("ADD", style: TextStyle(fontSize: AddSize.font12, color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
                                                                            )
                                                                      : const SizedBox()
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                                Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child: Container(
                                                        height: height * .03,
                                                        width: width * .18,
                                                        decoration: const BoxDecoration(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                        child: Center(
                                                            child: Text(
                                                              singleCategoryController
                                                                  .singleCategoryModel
                                                                  .value
                                                                  .data![
                                                              index]
                                                              .varints![singleCategoryController
                                                                  .singleCategoryModel
                                                                  .value
                                                                  .data![
                                                              index]
                                                                  .varientIndex!
                                                                  .value]
                                                              .discountOff
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color: AppTheme
                                                                  .backgroundcolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )))),
                                              ],
                                            )),
                                      );
                                    }):Center(child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text("Product Not Available",style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                  fontWeight:
                                  FontWeight.w500,
                                  fontSize: AddSize.font16),),
                                    )) : const Center(child: CircularProgressIndicator(),):
                                  storeController.storeDetailsModel.value.data!.latestProducts!.isNotEmpty?
                              ListView.builder(
                                  itemCount: storeController.isPaginationLoading.value ? storeController
                                      .storeDetailsModel
                                      .value
                                      .data!
                                      .latestProducts!
                                      .length:storeController
                                      .storeDetailsModel
                                      .value
                                      .data!
                                      .latestProducts!
                                      .length+1,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    top: height * .015,
                                  ),
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if(storeController.isPaginationLoading.value)
                                      {
                                        return products(width, height, index, context);
                                      }else{
                                      if(index <storeController
                                          .storeDetailsModel
                                          .value
                                          .data!
                                          .latestProducts!
                                          .length){
                                       return products(width, height, index, context);
                                      }
                                      else{
                                        return Center(child:CircularProgressIndicator(),);
                                      }
                                    }
                                  }):Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text("Product Not Available",style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                        fontWeight:
                                        FontWeight.w500,
                                        fontSize: AddSize.font16),),
                                  )),
                                SizedBox(
                                  height: height * .13,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
        extendBody: true,
        bottomNavigationBar: myCartController.isDataLoaded.value &&
                myCartController.model.value.data!.cartItems!.isNotEmpty
            ? addCartSection()
            : null,
      );
    });
  }

  Container products(double width, double height, int index, BuildContext context) {
    return Container(decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        // height: height * .23,
                                        child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: width * .02,
                                                    vertical: height * .01,
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                          AddSize.size50 *
                                                              1.2,
                                                          width:
                                                          AddSize.size50 *
                                                              1.6,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                            child:
                                                            CachedNetworkImage(
                                                              imageUrl: storeController
                                                                  .storeDetailsModel
                                                                  .value
                                                                  .data!
                                                                  .latestProducts![
                                                              index]
                                                                  .image
                                                                  .toString(),
                                                              errorWidget: (_,
                                                                  __,
                                                                  ___) =>
                                                              const SizedBox(),
                                                              placeholder: (_,
                                                                  __) =>
                                                              const SizedBox(),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * .02,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                  storeController
                                                                      .storeDetailsModel
                                                                      .value
                                                                      .data!
                                                                      .latestProducts![
                                                                  index]
                                                                      .name
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      color: AppTheme
                                                                          .blackcolor,
                                                                      fontSize:
                                                                      16,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Container(
                                                                // width: width * .60,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    width *
                                                                        .02),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        8.0),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100),
                                                                child:
                                                                buildDropdownButtonFormField(
                                                                    index),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: width *
                                                                            .02,
                                                                      ),
                                                                      Text(
                                                                        "₹${storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString()}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                            15,
                                                                            color:
                                                                            AppTheme.primaryColor,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            .02,
                                                                      ),
                                                                      Text(
                                                                        "₹${storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].marketPrice.toString()}",
                                                                        style: const TextStyle(
                                                                            decoration: TextDecoration
                                                                                .lineThrough,
                                                                            fontSize:
                                                                            12,
                                                                            color:
                                                                            Colors.grey,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                      // SizedBox(
                                                                      //   width: width *
                                                                      //       .02,
                                                                      // ),
                                                                      // Text(
                                                                      //   "Qty: ${storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].maxQty.toString()}",
                                                                      //   style: TextStyle(
                                                                      //       fontSize: AddSize.font14,
                                                                      //       color: AppTheme.primaryColor,
                                                                      //       fontWeight: FontWeight.w500),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  myCartController
                                                                      .isDataLoaded
                                                                      .value
                                                                      ? myCartController
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .cartItems!
                                                                      .map((e) => e.variantId.toString())
                                                                      .toList()
                                                                      .contains(storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].id.toString())
                                                                      ? Container(
                                                                    width: width * .20,
                                                                    decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(6)),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                        vertical: height * .005,
                                                                        horizontal: width * .02,
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap: () {
                                                                              // removeCartItemRepo(storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString(), context);
                                                                              if ((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() ==
                                                                                  storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.
                                                                                  latestProducts![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString() == storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].minQty.toString()) {
                                                                                removeCartItemRepo((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).id ?? "").toString(), context).then((value) {
                                                                                  if (value.status == true) {
                                                                                    showToast(value.message);
                                                                                    myCartController.getAddToCartList();
                                                                                  } else {
                                                                                    showToast(value.message);
                                                                                  }
                                                                                });
                                                                              } else {
                                                                                addToCartRepo(storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].id.toString(), storeController.storeDetailsModel.value.data!.latestProducts![index].id.toString(), int.parse((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) - 1, context).then((value) {
                                                                                  showToast(value.message);
                                                                                  if (value.status == true) {
                                                                                    myCartController.getAddToCartList();
                                                                                  }
                                                                                  setState(() {});
                                                                                });
                                                                              }
                                                                            },
                                                                            child: const Icon(
                                                                              Icons.remove,
                                                                              color: AppTheme.backgroundcolor,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                          Obx(() {
                                                                            return Text(
                                                                              (myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "").toString(),
                                                                              style: TextStyle(fontSize: AddSize.font14, color: AppTheme.backgroundcolor, fontWeight: FontWeight.w500),
                                                                            );
                                                                          }),
                                                                          InkWell(
                                                                            onTap: () {
                                                                              storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].maxQty != (myCartController.model.value
                                                                                  .data!.cartItems!.firstWhere((element) => element.variantId.toString() == storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index]
                                                                                  .varientIndex!
                                                                                  .value]
                                                                                  .id
                                                                                  .toString(),
                                                                                  orElse: () =>
                                                                                      CartItems())
                                                                                  .cartItemQty ??
                                                                                  "") ?
                                                                              addToCartRepo(storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].id.toString(), storeController.storeDetailsModel.value.data!.latestProducts![index].id.toString(), int.parse((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) + 1, context).then((value) {
                                                                                showToast(value.message);
                                                                                if (value.status == true) {
                                                                                  myCartController.getAddToCartList();
                                                                                } else {
                                                                                  showToast(value.message);
                                                                                }
                                                                              }):showToast("You can't add more then ${storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].maxQty.toString()} item");
                                                                            },
                                                                            child: const Icon(
                                                                              Icons.add,
                                                                              color: AppTheme.backgroundcolor,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                      : OutlinedButton(
                                                                    style: OutlinedButton.styleFrom(
                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                                                                      minimumSize: Size(AddSize.size50, AddSize.size30),
                                                                      side: const BorderSide(color: AppTheme.primaryColor, width: 1),
                                                                      backgroundColor: AppTheme.addColor,
                                                                    ),
                                                                    onPressed: () {
                                                                      int vIndex = storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value;
                                                                      addToCartRepo(storeController.storeDetailsModel.value.data!.latestProducts![index].varints![vIndex].id.toString(), storeController.storeDetailsModel.value.data!.latestProducts![index].id.toString(),storeController.storeDetailsModel.value.data!.latestProducts![index].varints![storeController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].minQty, context).then((value) {
                                                                        if (value.status == true) {
                                                                          showToast(value.message);
                                                                          myCartController.getAddToCartList();
                                                                          relatedCartController.getAddToCartRelatedList();
                                                                        } else {
                                                                          showToast(value.message);
                                                                        }
                                                                      });
                                                                    },
                                                                    child: Text("ADD", style: TextStyle(fontSize: AddSize.font12, color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
                                                                  )
                                                                      : const SizedBox()
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                                Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child: Container(
                                                        height: height * .03,
                                                        width: width * .18,
                                                        decoration: const BoxDecoration(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                    10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                    10))),
                                                        child: Center(
                                                            child: Text(
                                                              storeController
                                                                  .storeDetailsModel
                                                                  .value
                                                                  .data!
                                                                  .latestProducts![
                                                              index]
                                                                  .varints![storeController
                                                                  .storeDetailsModel
                                                                  .value
                                                                  .data!
                                                                  .latestProducts![
                                                              index]
                                                                  .varientIndex!
                                                                  .value]
                                                                  .discountOff
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: AppTheme
                                                                      .backgroundcolor,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                            )))),
                                              ],
                                            )),
                                      );
  }
  buildDropdownButtonFormField(int index) {
    return Obx(() {
      return DropdownButtonFormField<int>(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade50,
            border: InputBorder.none,
            enabled: true,
          ),
          value: storeController.storeDetailsModel.value.data!
              .latestProducts![index].varientIndex!.value,
          hint: Text(
            'Select qty',
            style:
                TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          ),
          items: List.generate(
              storeController.storeDetailsModel.value.data!
                  .latestProducts![index].varints!.length,
              (index1) => DropdownMenuItem(
                    value: index1,
                    child: Text(
                      "${storeController.storeDetailsModel.value.data!.latestProducts![index].varints![index1].variantQty} " " ${storeController.storeDetailsModel.value.data!.latestProducts![index].varints![index1].variantQtyType}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
          onChanged: (newValue) {
            storeController.storeDetailsModel.value.data!
                .latestProducts![index].varientIndex!.value = newValue!;
            setState(() {});
          });
    });
  }


  buildDropdownButtonFormField1(int index) {
    return Obx(() {
      return DropdownButtonFormField<int>(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade50,
            border: InputBorder.none,
            enabled: true,
          ),
          value: singleCategoryController
              .singleCategoryModel
              .value
              .data![
          index].varientIndex!.value,
          hint: Text(
            'Select qty',
            style:
            TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          ),
          items: List.generate(
              singleCategoryController
                  .singleCategoryModel
                  .value
                  .data![
              index].varints!.length,
                  (index1) => DropdownMenuItem(
                value: index1,
                child: Text(
                  "${singleCategoryController
                      .singleCategoryModel
                      .value
                      .data![
                  index].varints![index1].variantQty} " " ${singleCategoryController
                      .singleCategoryModel
                      .value
                      .data![
                  index].varints![index1].variantQtyType}",
                  style: const TextStyle(fontSize: 16),
                ),
              )),
          onChanged: (newValue) {
            singleCategoryController
                .singleCategoryModel
                .value
                .data![
            index].varientIndex!.value = newValue!;
            setState(() {});
          });
    });
  }
}
