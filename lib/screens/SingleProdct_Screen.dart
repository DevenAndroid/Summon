// import 'dart:convert';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
// import 'package:get/get.dart';
// import '../controller/My_cart_controller.dart';
// import '../controller/SingleProductController.dart';
// import '../controller/main_home_controller.dart';
//
// import '../model/My_Cart_Model.dart';
//
// import '../repositories/Add_To_Cart_Repo.dart';
// import '../repositories/Remove_CartItem_Repo.dart';
// import '../resources/app_assets.dart';
// import '../resources/app_theme.dart';
// import '../widgets/add_text.dart';
// import '../widgets/dimensions.dart';
//
//
//
// extension StringToInt on String {
//   int get toInt {
//     return int.tryParse(this)??0;
//   }
// }
//
// class SingleProductScreen extends StatefulWidget {
//   const SingleProductScreen({Key? key}) : super(key: key);
//   static var singleProductScreen = "/singleProductScreen";
//   @override
//   State<SingleProductScreen> createState() => _SingleProductScreenState();
// }
//
// class _SingleProductScreenState extends State<SingleProductScreen> {
//   static var singleProductScreen = "/singleProductScreen";
//   final controller = Get.put(MyCartDataListController());
//   final mainController = Get.put(MainHomeController());
//   final singleProductController = Get.put(SingleProductController());
//   final TextEditingController tipController = TextEditingController();
//   final TextEditingController variantIdController = TextEditingController();
//   RxString selectedCAt = "".obs;
//   RxBool customTip = false.obs;
//   RxBool check = false.obs;
//   RxString selectedChip = "".obs;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       singleProductController.getData();
//       controller.getAddToCartList();
//     });
//   }
//
//   // bool isApplicable() {
//   //   int value = 0;
//   //   for (var element1 in singleProductController.model.value.data!.singlePageAddons!) {
//   //     for (var element in element1.bestFreshProducts!) {
//   //       if (element.editable.value) {
//   //         value = value + element.qty.value;
//   //         if (value == singleProductController.model.value.data!.addonLimit) {
//   //           break;
//   //         }
//   //       }
//   //     }
//   //     if (value == singleProductController.model.value.data!.addonLimit) {
//   //       break;
//   //     }
//   //   }
//   //   return value < singleProductController.model.value.data!.addonLimit.toString().toInt;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Obx(() {
//       return Scaffold();
//       // return Scaffold(
//       //   backgroundColor: const Color(0xffEFFFEF),
//       //   appBar: backAppBar(
//       //       title: "",
//       //       context: context,
//       //       backgroundColor: AppTheme.lightPrimaryColor),
//       //   body: singleProductController.isDataLoading.value
//       //       ? SingleChildScrollView(
//       //     physics: const BouncingScrollPhysics(),
//       //     child: Padding(
//       //       padding: EdgeInsets.symmetric(horizontal: AddSize.padding20),
//       //       child: Column(
//       //         // crossAxisAlignment: CrossAxisAlignment.start,
//       //         children: [
//       //           SizedBox(
//       //             height: AddSize.size45,
//       //           ),
//       //           SizedBox(
//       //             height: height * .25,
//       //             width: width,
//       //             child: ClipRRect(
//       //               borderRadius: BorderRadius.circular(10),
//       //               child: CachedNetworkImage(
//       //                 imageUrl: singleProductController
//       //                     .model.value.data!.productDetail!.image
//       //                     .toString(),
//       //                 errorWidget: (_, __, ___) => const SizedBox(),
//       //                 placeholder: (_, __) => const SizedBox(),
//       //                 fit: BoxFit.cover,
//       //               ),
//       //             ),
//       //           ),
//       //           Padding(
//       //             padding:
//       //             EdgeInsets.symmetric(horizontal: AddSize.padding16),
//       //             child: Column(
//       //               crossAxisAlignment: CrossAxisAlignment.start,
//       //               children: [
//       //                 SizedBox(
//       //                   height: AddSize.size15,
//       //                 ),
//       //                 Text(
//       //                     (singleProductController
//       //                         .model.value.data!.productDetail!.name ?? "")
//       //                         .toString()
//       //                         .capitalizeFirst!,
//       //                     style: TextStyle(
//       //                         color: AppTheme.blackcolor,
//       //                         fontSize: AddSize.font16,
//       //                         fontWeight: FontWeight.w500)),
//       //                 SizedBox(height: AddSize.size10),
//       //                 Text(
//       //                     "\$" +
//       //                         (singleProductController
//       //                             .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                             .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).price).toString(),
//       //                     style: TextStyle(
//       //                         color: AppTheme.blackcolor,
//       //                         fontSize: AddSize.font16,
//       //                         fontWeight: FontWeight.w500)),
//       //                 SizedBox(height: AddSize.size10),
//       //                 Divider(
//       //                   thickness: AddSize.size5 * .4,
//       //                 ),
//       //                 SizedBox(height: AddSize.size10),
//       //                 Text("Description",
//       //                     style: TextStyle(
//       //                         color: AppTheme.blackcolor,
//       //                         fontSize: AddSize.font16,
//       //                         fontWeight: FontWeight.w400)),
//       //                 SizedBox(height: AddSize.size10),
//       //                 Text(
//       //                     (singleProductController
//       //                         .model.value.data!.productDetail!.content ?? "")
//       //                         .toString()
//       //                         .capitalizeFirst!,
//       //                     style: TextStyle(
//       //                         color: AppTheme.blackcolor,
//       //                         fontSize: AddSize.font12,
//       //                         fontWeight: FontWeight.w300)),
//       //                 SizedBox(height: AddSize.size20),
//       //                 ListView.builder(
//       //                     itemCount: singleProductController
//       //                         .model.value.data!.singlePageAddons!.length,
//       //                     shrinkWrap: true,
//       //                     padding: EdgeInsets.zero,
//       //                     physics: const NeverScrollableScrollPhysics(),
//       //                     itemBuilder: (context, index) {
//       //                       return Column(
//       //                         children: [
//       //                           Container(
//       //                             width: AddSize.screenWidth,
//       //                             decoration: BoxDecoration(
//       //                               borderRadius:
//       //                               BorderRadius.circular(10),
//       //                               color: Color(0xffF1F4F8),
//       //                             ),
//       //                             child: Padding(
//       //                               padding:
//       //                               EdgeInsets.all(AddSize.padding16),
//       //                               child: Text(
//       //                                   (singleProductController
//       //                                       .model
//       //                                       .value
//       //                                       .data!
//       //                                       .singlePageAddons![index]
//       //                                       .title ?? "")
//       //                                       .toString(),
//       //                                   style: TextStyle(
//       //                                       color: AppTheme.subText,
//       //                                       fontSize: AddSize.font14,
//       //                                       fontWeight: FontWeight.w600)),
//       //                             ),
//       //                           ),
//       //                           ListView.builder(
//       //                             physics: BouncingScrollPhysics(),
//       //                             shrinkWrap: true,
//       //                             itemCount: singleProductController
//       //                                 .model
//       //                                 .value
//       //                                 .data!
//       //                                 .singlePageAddons![index]
//       //                                 .bestFreshProducts!
//       //                                 .length,
//       //                             itemBuilder:
//       //                                 (BuildContext context, int index2) {
//       //                               return buildObx(index, index2,
//       //                                   context, height, width);
//       //                             },
//       //                           )
//       //                         ],
//       //                       );
//       //                     }),
//       //                 singleProductController
//       //                     .model
//       //                     .value
//       //                     .data!
//       //                     .productDetail!.type == "Variable"?
//       //
//       //                 Column(
//       //                   children: [
//       //                     Container(
//       //                       width: AddSize.screenWidth,
//       //                       decoration: BoxDecoration(
//       //                         borderRadius:
//       //                         BorderRadius.circular(10),
//       //                         color: Color(0xffF1F4F8),
//       //                       ),
//       //                       child: Padding(
//       //                         padding:
//       //                         EdgeInsets.all(AddSize.padding16),
//       //                         child: Text("How many of this entire order do you want?",
//       //                             style: TextStyle(
//       //                                 color: AppTheme.subText,
//       //                                 fontSize: AddSize.font14,
//       //                                 fontWeight: FontWeight.w600)),
//       //                       ),
//       //                     ),
//       //                     SizedBox(height: AddSize.size10,),
//       //                     Row(
//       //                       children: [
//       //                         Expanded(child:  Container(
//       //                             padding: EdgeInsets
//       //                                 .symmetric(
//       //                                 horizontal:
//       //                                 width *
//       //                                     .02),
//       //                             decoration: BoxDecoration(
//       //                                 borderRadius:
//       //                                 BorderRadius.circular(
//       //                                     30),
//       //                                 color: Colors.white),
//       //                             child:buildDropdownButtonFormField())),
//       //                         SizedBox(width: AddSize.size20,),
//       //                         Container(
//       //                           width: width * .20,
//       //                           decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(6)),
//       //                           child: Padding(
//       //                             padding: EdgeInsets.symmetric(
//       //                               vertical: height * .005,
//       //                               horizontal: width * .02,
//       //                             ),
//       //                             child: Row(
//       //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //                               children: [
//       //                                 InkWell(
//       //                                   onTap: () {
//       //                                     if ((controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                         .toString(), orElse: () => CartItems()).cartItemQty.toString()) == singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value||element.size.toString().isEmpty,orElse: ()=>Variants()).minQty
//       //                                         .toString()) {
//       //                                       removeCartItemRepo((controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                                           .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                           .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                           .toString(), orElse: () => CartItems()).id ?? "").toString(), context).then((value) {
//       //                                         if (value.status == true) {
//       //                                           showToast(value.message);
//       //                                           controller.getAddToCartList();
//       //                                         } else {
//       //                                           showToast(value.message);
//       //                                         }
//       //                                       });
//       //                                     } else {
//       //                                       addToCartRepo(singleProductController
//       //                                           .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                           .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                           .toString(), singleProductController
//       //                                           .model
//       //                                           .value
//       //                                           .data!
//       //                                           .productDetail!
//       //                                           .id
//       //                                           .toString(), int.parse((controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                                           .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                           .model.value.data!.productDetail!.varientIndex.value||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                           .toString(), orElse: () => CartItems()).cartItemQty ?? "0".toString()).toString()) - 1, context).then((value) {
//       //                                         showToast(value.message);
//       //                                         if (value.status == true) {
//       //                                           controller.getAddToCartList();
//       //                                         }
//       //                                         setState(() {});
//       //                                       });
//       //                                     }
//       //                                   },
//       //                                   child: const Icon(
//       //                                     Icons.remove,
//       //                                     color: AppTheme.backgroundcolor,
//       //                                     size: 15,
//       //                                   ),
//       //                                 ),
//       //                                 Obx(() {
//       //                                   return Text(
//       //                                     controller.model.value.data!.cartItems!.map((e) => e.variantId.toString()).toList().contains(singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id.toString())?
//       //                                     (controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                         .toString(), orElse: () => CartItems()).cartItemQty.toString()).toString():singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).minQty
//       //                                         .toString(),
//       //                                     style: TextStyle(fontSize: AddSize.font14, color: AppTheme.backgroundcolor, fontWeight: FontWeight.w500),
//       //                                   );
//       //                                 }),
//       //                                 InkWell(
//       //                                   onTap: () {
//       //                                     Map<String, dynamic> map = {};
//       //                                     for (int i = 0;
//       //                                     i < singleProductController.model.value.data!.singlePageAddons!.length; i++) {
//       //                                       for (var element in singleProductController.model.value.data!.singlePageAddons![i].bestFreshProducts!) {
//       //                                         if (element.editable.value) {
//       //                                           map[element.id.toString()] = element.qty.value.toString();
//       //                                         }
//       //                                       }
//       //                                     }
//       //                                     singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value||element.size.toString().isEmpty,orElse: ()=>Variants()).maxQty.toString()
//       //                                         .toString() != (controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                         .toString(), orElse: () => CartItems()).cartItemQty ?? "")
//       //                                         ? addToCartRepo1(variant_id:singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                         .toString(), product_id:singleProductController
//       //                                         .model
//       //                                         .value
//       //                                         .data!
//       //                                         .productDetail!
//       //                                         .id
//       //                                         .toString(), qty:int.parse((controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                         .toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) + 1, context:context,addOnQty: json.encode(map)).then((value) {
//       //                                       showToast(value.message);
//       //                                       if (value.status == true) {
//       //                                         controller.getAddToCartList();
//       //                                       } else {
//       //                                         showToast(value.message);
//       //                                       }
//       //                                     })
//       //                                         : showToast("You can't add more then ${singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).maxQty
//       //                                         .toString()} item");
//       //                                   },
//       //                                   child: const Icon(
//       //                                     Icons.add,
//       //                                     color: AppTheme.backgroundcolor,
//       //                                     size: 15,
//       //                                   ),
//       //                                 ),
//       //                               ],
//       //                             ),
//       //                           ),
//       //                         )
//       //                       ],
//       //                     ),
//       //                   ],
//       //                 ) : Column(
//       //                   children: [
//       //                     Container(
//       //                       width: AddSize.screenWidth,
//       //                       decoration: BoxDecoration(
//       //                         borderRadius:
//       //                         BorderRadius.circular(10),
//       //                         color: Color(0xffF1F4F8),
//       //                       ),
//       //                       child: Padding(
//       //                         padding:
//       //                         EdgeInsets.all(AddSize.padding16),
//       //                         child: Text("How many of this entire order do you want?",
//       //                             style: TextStyle(
//       //                                 color: AppTheme.subText,
//       //                                 fontSize: AddSize.font14,
//       //                                 fontWeight: FontWeight.w600)),
//       //                       ),
//       //                     ),
//       //                     SizedBox(height: AddSize.size10,),
//       //                     Align(
//       //                       alignment: Alignment.center,
//       //                       child:controller
//       //                           .isDataLoaded
//       //                           .value
//       //                           ? Container(
//       //                         alignment: Alignment.center,
//       //                         width: AddSize.size110,
//       //                         decoration: BoxDecoration(
//       //                             color: Colors.white,
//       //                             borderRadius: BorderRadius.circular(30),
//       //                             border: Border.all(color: Colors.grey)),
//       //                         child: Padding(
//       //                           padding: EdgeInsets.symmetric(
//       //                             vertical: height * .01,
//       //                             horizontal: width * .03,
//       //                           ),
//       //                           child: Row(
//       //                             mainAxisAlignment:
//       //                             MainAxisAlignment.spaceBetween,
//       //                             children: [
//       //                               InkWell(
//       //                                   onTap: () {
//       //                                     if ((controller.model.value.data!
//       //                                         .cartItems!
//       //                                         .firstWhere(
//       //                                             (element) =>
//       //                                         element
//       //                                             .variantId
//       //                                             .toString() ==
//       //                                             singleProductController
//       //                                                 .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                                 .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                                 .toString(),
//       //                                         orElse: () =>
//       //                                             CartItems())
//       //                                         .cartItemQty
//       //                                         .toString()) ==
//       //                                         singleProductController
//       //                                             .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                             .model.value.data!.productDetail!.varientIndex.value||element.size.toString().isEmpty,orElse: ()=>Variants()).minQty
//       //                                             .toString()) {
//       //                                       removeCartItemRepo(
//       //                                           (controller
//       //                                               .model
//       //                                               .value
//       //                                               .data!
//       //                                               .cartItems!
//       //                                               .firstWhere(
//       //                                                   (element) =>
//       //                                               element
//       //                                                   .productId
//       //                                                   .toString() ==
//       //                                                   singleProductController
//       //                                                       .model
//       //                                                       .value
//       //                                                       .data!
//       //                                                       .productDetail!
//       //                                                       .id
//       //                                                       .toString(),
//       //                                               orElse: () =>
//       //                                                   CartItems())
//       //                                               .id.toString())
//       //                                               .toString(),
//       //                                           context)
//       //                                           .then((value) {
//       //                                         if (value.status == true) {
//       //                                           showToast(value.message);
//       //                                           controller.getAddToCartList();
//       //                                           Get.back();
//       //                                         } else {
//       //                                           showToast(value.message);
//       //                                         }
//       //                                       });
//       //                                     } else {
//       //                                       addToCartRepo(
//       //                                           singleProductController
//       //                                               .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                               .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                               .toString(),
//       //                                           singleProductController
//       //                                               .model
//       //                                               .value
//       //                                               .data!
//       //                                               .productDetail!
//       //                                               .id
//       //                                               .toString(),
//       //                                           int.parse((controller
//       //                                               .model
//       //                                               .value
//       //                                               .data!
//       //                                               .cartItems!
//       //                                               .firstWhere(
//       //                                                   (element) =>
//       //                                               element.productId.toString() ==
//       //                                                   singleProductController.model.value.data!.productDetail!.id
//       //                                                       .toString(),
//       //                                               orElse: () =>
//       //                                                   CartItems())
//       //                                               .cartItemQty ??
//       //                                               "0")
//       //                                               .toString()) - 1,
//       //                                           context)
//       //                                           .then((value) {
//       //                                         showToast(value.message);
//       //                                         if (value.status == true) {
//       //                                           controller.getAddToCartList();
//       //                                         }
//       //                                         setState(() {});
//       //                                       });
//       //                                     }
//       //                                   },
//       //                                   child: Image.asset(
//       //                                     AppAssets.removeIcon,
//       //                                     height: AddSize.size12,
//       //                                     width: AddSize.size15,
//       //                                   )),
//       //                               // Text(
//       //                               //   (controller.model.value.data!.cartItems!
//       //                               //       .firstWhere(
//       //                               //           (element) =>
//       //                               //       element.productId
//       //                               //           .toString() ==
//       //                               //           singleProductController
//       //                               //               .model
//       //                               //               .value
//       //                               //               .data!
//       //                               //               .productDetail!
//       //                               //               .id
//       //                               //               .toString(),
//       //                               //       orElse: () =>
//       //                               //           CartItems())
//       //                               //       .cartItemQty ??
//       //                               //       "0")
//       //                               //       .toString(),
//       //                               //   style: TextStyle(
//       //                               //       fontSize: AddSize.font18,
//       //                               //       color: AppTheme.blackcolor,
//       //                               //       fontWeight: FontWeight.w600),
//       //                               // ),
//       //                               // Obx(() {
//       //                               //   return Text(
//       //                               //     (controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                               //         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                               //         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                               //         .toString(), orElse: () => CartItems()).cartItemQty.toString()),
//       //                               //     style: TextStyle(fontSize: AddSize.font16, color: AppTheme.blackcolor, fontWeight: FontWeight.w600),
//       //                               //   );
//       //                               // }),
//       //
//       //
//       //                               Obx(() {
//       //                                 return Text(
//       //                                   controller.model.value.data!.cartItems!.map((e) => e.variantId.toString()).toList().contains(singleProductController
//       //                                       .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                       .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id.toString()) ?
//       //                                   (controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == singleProductController
//       //                                       .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                       .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                       .toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString():singleProductController
//       //                                       .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                       .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).minQty
//       //                                       .toString(),
//       //                                   style: TextStyle(fontSize: AddSize.font16, color: AppTheme.blackcolor, fontWeight: FontWeight.w600),
//       //                                 );
//       //                               }),
//       //                               InkWell(
//       //                                   onTap: () {
//       //                                     Map<String, dynamic> map = {};
//       //                                     for (int i = 0;
//       //                                     i < singleProductController.model.value.data!.singlePageAddons!.length; i++) {
//       //                                       for (var element in singleProductController.model.value.data!.singlePageAddons![i].bestFreshProducts!) {
//       //                                         if (element.editable.value) {
//       //                                           map[element.id.toString()] = element.qty.value.toString();
//       //                                         }
//       //                                       }
//       //                                     }
//       //                                     singleProductController
//       //                                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).maxQty.toString() !=
//       //                                         (controller.model.value
//       //                                             .data!.cartItems!
//       //                                             .firstWhere(
//       //                                                 (element) =>
//       //                                             element.productId.toString() ==
//       //                                                 singleProductController
//       //                                                     .model
//       //                                                     .value
//       //                                                     .data!
//       //                                                     .productDetail!
//       //                                                     .id
//       //                                                     .toString(),
//       //                                             orElse: () =>
//       //                                                 CartItems())
//       //                                             .cartItemQty
//       //                                             .toString())
//       //                                         ? addToCartRepo1(
//       //                                         variant_id:singleProductController
//       //                                             .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                                             .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                                             .toString(),
//       //                                         product_id:singleProductController
//       //                                             .model
//       //                                             .value
//       //                                             .data!
//       //                                             .productDetail!
//       //                                             .id
//       //                                             .toString(),
//       //                                         qty:int.parse((controller.model.value.data!.cartItems!.firstWhere((element) => element.productId.toString() == singleProductController.model.value.data!.productDetail!.id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) + 1,
//       //                                         context:context,
//       //                                         addOnQty: json.encode(map)
//       //                                     )
//       //                                         .then((value) {
//       //                                       showToast(value.message);
//       //                                       if (value.status == true) {
//       //                                         controller
//       //                                             .getAddToCartList();
//       //                                       } else {
//       //                                         showToast(value.message);
//       //                                       }
//       //                                     })
//       //                                         : showToast("You can't add more then ${singleProductController.model.value.data!.productDetail!.variants![0].maxQty.toString()} item");
//       //                                   },
//       //                                   child: Image.asset(
//       //                                     AppAssets.addIcon,
//       //                                     height: AddSize.size12,
//       //                                     width: AddSize.size15,
//       //                                   )),
//       //                             ],
//       //                           ),
//       //                         ),
//       //                       ):SizedBox(),
//       //                     ),
//       //                   ],
//       //                 )
//       //               ],
//       //             ),
//       //           ),
//       //           SizedBox(height: AddSize.size20,)
//       //         ],
//       //       ),
//       //     ),
//       //   )
//       //       : Center(
//       //       child: CircularProgressIndicator(color: AppTheme.primaryColor)),
//       //   bottomNavigationBar: Padding(
//       //     padding: EdgeInsets.symmetric(
//       //         horizontal: AddSize.padding16, vertical: AddSize.padding16),
//       //     child: Column(
//       //       mainAxisSize: MainAxisSize.min,
//       //       children: [
//       //         ElevatedButton(
//       //             onPressed: () {
//       //               // if (int.parse((controller.model.value.data!.cartItems!
//       //               //                 .firstWhere(
//       //               //                     (element) =>
//       //               //                         element.variantId.toString() ==
//       //               //                             singleProductController
//       //               //                                 .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //               //                                 .model.value.data!.productDetail!.varientIndex.value||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //               //                             .toString(),
//       //               //                     orElse: () => CartItems())
//       //               //                 .cartItemQty ??
//       //               //             "0")
//       //               //         .toString()) < 1) {
//       //               //   showToast("Please add Product");
//       //               // }
//       //               // else {
//       //               Map<String, dynamic> map = {};
//       //               for (int i = 0;
//       //               i < singleProductController.model.value.data!.singlePageAddons!.length; i++) {
//       //                 for (var element in singleProductController.model.value.data!
//       //                     .singlePageAddons![i].bestFreshProducts!) {
//       //                   if (element.editable.value) {
//       //                     map[element.id.toString()] = element.qty.value.toString();
//       //                   }
//       //                 }
//       //               }
//       //               if (!controller.model.value.data!.cartItems!.map((e) => e.variantId.toString()).toList().contains(singleProductController
//       //                   .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                   .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id.toString())) {
//       //                 print("Hello");
//       //                 addToCartRepo1(
//       //                     variant_id: singleProductController
//       //                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                         .toString(),
//       //                     product_id: singleProductController
//       //                         .model.value.data!.productDetail!.id
//       //                         .toString(),
//       //                     qty: int.parse((singleProductController
//       //                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).minQty
//       //                         .toString())),
//       //                     context: context,
//       //                     addOnQty: json.encode(map))
//       //                     .then((value) {
//       //                   showToast(value.message);
//       //                   if (value.status == true) {
//       //                     controller.getAddToCartList();
//       //                     Get.toNamed(CustomNavigationBar.customNavigationBar);
//       //                     mainController.onItemTap(0);
//       //                   }
//       //                 });
//       //               }
//       //               else {
//       //                 print("vhfg");
//       //                 addToCartRepo1(
//       //                     variant_id: singleProductController
//       //                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                         .toString(),
//       //                     product_id: singleProductController
//       //                         .model.value.data!.productDetail!.id
//       //                         .toString(),
//       //                     qty: int.parse((controller
//       //                         .model.value.data!.cartItems!
//       //                         .firstWhere(
//       //                             (element) =>
//       //                         element.variantId.toString() ==
//       //                             singleProductController
//       //                                 .model.value.data!.productDetail!
//       //                                 .variants!.firstWhere((element) =>
//       //                             element.size.toString() == singleProductController
//       //                                 .model.value.data!.productDetail!
//       //                                 .varientIndex.value||element.size.toString().isEmpty,
//       //                                 orElse: () => Variants()).id
//       //                                 .toString(),
//       //                         orElse: () => CartItems())
//       //                         .cartItemQty + 1  ??
//       //                         "0")
//       //                         .toString()),
//       //                     context: context,
//       //                     addOnQty: json.encode(map))
//       //                     .then((value) {
//       //                   showToast(value.message);
//       //                   if (value.status == true) {
//       //                     controller.getAddToCartList();
//       //                     Get.toNamed(CustomNavigationBar.customNavigationBar);
//       //                     mainController.onItemTap(0);
//       //                   }
//       //                 });
//       //               }
//       //               // }
//       //               // Get.toNamed(CreditCardPaymentPage.creditCardPaymentPage);
//       //             },
//       //             style: ElevatedButton.styleFrom(
//       //                 padding: const EdgeInsets.all(5),
//       //                 minimumSize: Size(double.maxFinite, AddSize.size30 * 2),
//       //                 backgroundColor: Colors.black,
//       //                 elevation: 0,
//       //                 shape: RoundedRectangleBorder(
//       //                     borderRadius: BorderRadius.circular(10)),
//       //                 textStyle: const TextStyle(
//       //                     fontSize: 20, fontWeight: FontWeight.w600)),
//       //             child: Text(
//       //               "Proceed to Cart".toUpperCase(),
//       //               style: Theme.of(context).textTheme.headline5!.copyWith(
//       //                   color: AppTheme.backgroundcolor,
//       //                   fontWeight: FontWeight.w500,
//       //                   fontSize: AddSize.font16),
//       //             )),
//       //         SizedBox(height: AddSize.padding10),
//       //         ElevatedButton(
//       //             onPressed: () {
//       //               Map<String, dynamic> map = {};
//       //               for (int i = 0;
//       //               i < singleProductController.model.value.data!.singlePageAddons!.length; i++) {
//       //                 for (var element in singleProductController.model.value.data!.singlePageAddons![i].bestFreshProducts!) {
//       //                   if (element.editable.value) {
//       //                     map[element.id.toString()] = element.qty.value.toString();
//       //                   }
//       //                 }
//       //               }
//       //               if (!controller.model.value.data!.cartItems!.map((e) => e.variantId.toString()).toList().contains(singleProductController
//       //                   .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                   .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id.toString())) {
//       //                 print("Hello");
//       //                 addToCartRepo1(
//       //                     variant_id: singleProductController
//       //                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                         .toString(),
//       //                     product_id: singleProductController
//       //                         .model.value.data!.productDetail!.id
//       //                         .toString(),
//       //                     qty: int.parse((singleProductController
//       //                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).minQty
//       //                         .toString())),
//       //                     context: context,
//       //                     addOnQty: json.encode(map))
//       //                     .then((value) {
//       //                   showToast(value.message);
//       //                   if (value.status == true) {
//       //                     controller.getAddToCartList();
//       //                     Get.back();
//       //                     // Get.toNamed(CustomNavigationBar.customNavigationBar);
//       //                     // mainController.onItemTap(0);
//       //                   }
//       //                 });
//       //               }
//       //               else {
//       //                 print("vhfg");
//       //                 addToCartRepo1(
//       //                     variant_id: singleProductController
//       //                         .model.value.data!.productDetail!.variants!.firstWhere((element) => element.size.toString()==singleProductController
//       //                         .model.value.data!.productDetail!.varientIndex.value.toString()||element.size.toString().isEmpty,orElse: ()=>Variants()).id
//       //                         .toString(),
//       //                     product_id: singleProductController
//       //                         .model.value.data!.productDetail!.id
//       //                         .toString(),
//       //                     qty: int.parse((controller
//       //                         .model.value.data!.cartItems!
//       //                         .firstWhere(
//       //                             (element) =>
//       //                         element.variantId.toString() ==
//       //                             singleProductController
//       //                                 .model.value.data!.productDetail!
//       //                                 .variants!.firstWhere((element) =>
//       //                             element.size.toString() == singleProductController
//       //                                 .model.value.data!.productDetail!
//       //                                 .varientIndex.value||element.size.toString().isEmpty,
//       //                                 orElse: () => Variants()).id
//       //                                 .toString(),
//       //                         orElse: () => CartItems())
//       //                         .cartItemQty + 1 ??
//       //                         "0")
//       //                         .toString()),
//       //                     context: context,
//       //                     addOnQty: json.encode(map))
//       //                     .then((value) {
//       //                   showToast(value.message);
//       //                   if (value.status == true) {
//       //                     controller.getAddToCartList();
//       //                     Get.back();
//       //                     // Get.toNamed(CustomNavigationBar.customNavigationBar);
//       //                     // mainController.onItemTap(0);
//       //                   }
//       //                 });
//       //               }
//       //             },
//       //             style: ElevatedButton.styleFrom(
//       //                 padding: const EdgeInsets.all(5),
//       //                 minimumSize: Size(double.maxFinite, AddSize.size30 * 2),
//       //                 backgroundColor: Colors.black,
//       //                 elevation: 0,
//       //                 shape: RoundedRectangleBorder(
//       //                     borderRadius: BorderRadius.circular(10)),
//       //                 textStyle: const TextStyle(
//       //                     fontSize: 20, fontWeight: FontWeight.w600)),
//       //             child: Text(
//       //               "Add to Cart and Order More".toUpperCase(),
//       //               style: Theme.of(context).textTheme.headline5!.copyWith(
//       //                   color: AppTheme.backgroundcolor,
//       //                   fontWeight: FontWeight.w500,
//       //                   fontSize: AddSize.font16),
//       //             ))
//       //       ],
//       //     ),
//       //   ),
//       // );
//     });
//   }
//
//   Obx buildObx(int index, int index2, BuildContext context, double height,
//       double width) {
//     return Obx(() {
//       return Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)),
//                         checkColor: Colors.white,
//                         activeColor: AppTheme.primaryColor,
//                         value: singleProductController
//                             .model
//                             .value
//                             .data!
//                             .singlePageAddons![index]
//                             .bestFreshProducts![index2]
//                             .editable
//                             .value,
//                         onChanged: (value) {
//                           if (isApplicable()) {
//                             singleProductController
//                                 .model
//                                 .value
//                                 .data!
//                                 .singlePageAddons![index]
//                                 .bestFreshProducts![index2]
//                                 .editable
//                                 .value = value!;
//                             if (singleProductController
//                                 .model
//                                 .value
//                                 .data!
//                                 .singlePageAddons![index]
//                                 .bestFreshProducts![index2]
//                                 .editable
//                                 .value ==
//                                 true) {
//                               singleProductController
//                                   .model
//                                   .value
//                                   .data!
//                                   .singlePageAddons![index]
//                                   .bestFreshProducts![index2]
//                                   .qty
//                                   .value = 1;
//                             } else {
//                               singleProductController
//                                   .model
//                                   .value
//                                   .data!
//                                   .singlePageAddons![index]
//                                   .bestFreshProducts![index2]
//                                   .qty
//                                   .value = 0;
//                             }
//                           }
//                         },
//                       ),
//                       Expanded(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(child:
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(text: '${singleProductController.model.value.data!.singlePageAddons![index].bestFreshProducts![index2].name.toString().capitalizeFirst!}'),
//                                   if(singleProductController.model.value.data!.singlePageAddons![index].bestFreshProducts![index2].price!=0)
//                                     TextSpan(
//                                       text: ' (+\$${singleProductController.model.value.data!.singlePageAddons![index].bestFreshProducts![index2].price.toString()}.00)',
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                 ],
//                               ),
//                             )
//                               // Text(
//                               //   ("" +
//                               //   singleProductController
//                               //       .model
//                               //       .value
//                               //       .data!
//                               //       .singlePageAddons![index]
//                               //       .bestFreshProducts![index2]
//                               //       .name.toString() ?? "")
//                               //       .toString()
//                               //       .capitalizeFirst!,
//                               //   style: Theme.of(context).textTheme.headline6!.copyWith(
//                               //       fontWeight: FontWeight.w400,
//                               //       color: AppTheme.lightblack,
//                               //       fontSize: AddSize.font14),
//                               // ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: AddSize.size110,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: Colors.grey)),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: height * .005,
//                       horizontal: width * .02,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                             onTap: () {
//                               if (singleProductController
//                                   .model
//                                   .value
//                                   .data!
//                                   .singlePageAddons![index]
//                                   .bestFreshProducts![index2]
//                                   .qty
//                                   .value > 0) {
//                                 singleProductController
//                                     .model
//                                     .value
//                                     .data!
//                                     .singlePageAddons![index]
//                                     .bestFreshProducts![index2]
//                                     .qty
//                                     .value--;
//                               }
//                               if (singleProductController
//                                   .model
//                                   .value
//                                   .data!
//                                   .singlePageAddons![index]
//                                   .bestFreshProducts![index2]
//                                   .qty
//                                   .value ==
//                                   0) {
//                                 singleProductController
//                                     .model
//                                     .value
//                                     .data!
//                                     .singlePageAddons![index]
//                                     .bestFreshProducts![index2]
//                                     .editable
//                                     .value = false;
//                               }
//                             },
//                             child: Image.asset(
//                               AppAssets.removeIcon,
//                               height: AddSize.size12,
//                               width: AddSize.size15,
//                             )),
//                         Text(
//                           "${(singleProductController.model.value.data!.singlePageAddons![index].bestFreshProducts![index2].qty.value)}",
//                           style: TextStyle(
//                               fontSize: AddSize.font18,
//                               color: AppTheme.blackcolor,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         InkWell(
//                             onTap: () {
//                               if (isApplicable() &&
//                                   singleProductController
//                                       .model
//                                       .value
//                                       .data!
//                                       .singlePageAddons![index]
//                                       .bestFreshProducts![index2]
//                                       .editable
//                                       .value) {
//                                 singleProductController
//                                     .model
//                                     .value
//                                     .data!
//                                     .singlePageAddons![index]
//                                     .bestFreshProducts![index2]
//                                     .qty
//                                     .value++;
//                               }
//                               // if (singleProductController.model.value.data!.singlePageAddons!.bestFreshProducts![index].editable.value) {
//                               //   if (singleProductController
//                               //           .model
//                               //           .value
//                               //           .data!
//                               //           .singlePageAddons!
//                               //           .bestFreshProducts![
//                               //               index]
//                               //           .qty
//                               //           .value <
//                               //       2) {
//                               //     singleProductController
//                               //         .model
//                               //         .value
//                               //         .data!
//                               //         .singlePageAddons!
//                               //         .bestFreshProducts![
//                               //             index]
//                               //         .qty
//                               //         .value++;
//                               //   } else {
//                               //     singleProductController
//                               //         .model
//                               //         .value
//                               //         .data!
//                               //         .singlePageAddons!
//                               //         .bestFreshProducts![
//                               //             index]
//                               //         .qty
//                               //         .value;
//                               //   }
//                               // }
//                             },
//                             child: Image.asset(
//                               AppAssets.addIcon,
//                               height: AddSize.size12,
//                               width: AddSize.size15,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: AddSize.size5,
//             )
//           ]);
//     });
//   }
//
//
//   buildDropdownButtonFormField() {
//     return Obx(() {
//       return DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             fillColor: Colors.white,
//             border: InputBorder.none,
//             enabled: true,
//           ),
//           value: singleProductController.model.value.data!
//               .productDetail!.varientIndex.value,
//           hint: Text(
//             'Select qty',
//             style:
//             TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
//           ),
//           items:
//           List.generate(
//               singleProductController.model.value.data!
//                   .productDetail!.variants!.length,
//                   (index1) => DropdownMenuItem(
//                 value: singleProductController.model.value.data!
//                     .productDetail!.variants![index1].size.toString(),
//                 child: Text(
//                   "${singleProductController.model.value.data!
//                       .productDetail!.variants![index1].sizeName.toString()}",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               )),
//           //     singleProductController.model.value.data!
//           //             .productDetail!.variants!.map((e) => DropdownMenuItem(
//           // value: e.size,
//           // child: Text(
//           //   e.sizeName!,
//           // style: const TextStyle(fontSize: 16),
//           // ),
//           // )).toList(),
//           onChanged: (newValue) {
//             singleProductController.model.value.data!
//                 .productDetail!.varientIndex.value = newValue!;
//             print(singleProductController.model.value.data!
//                 .productDetail!.varientIndex.value);
//             setState(() {});
//           });
//     });
//   }
// }
