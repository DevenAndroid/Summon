
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/HomePageController1.dart';
import '../controller/My_cart_controller.dart';
import '../controller/single_store_controller.dart';
import '../resources/app_theme.dart';
import '../resources/helper.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'Language_Change_Screen.dart';

class SearchScreenData extends StatefulWidget {
  const SearchScreenData({Key? key}) : super(key: key);
  static var searchScreen = "/searchScreen";
  @override
  State<SearchScreenData> createState() => _SearchScreenDataState();
}

class _SearchScreenDataState extends State<SearchScreenData> {
  final homeSearchController = Get.put(HomePageController1());
  final myCartController = Get.put(MyCartDataListController());
  final scrollController = ScrollController();
  final singleStoreController = Get.put(SingleStoreController());
  final TextEditingController searchController=TextEditingController();
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      homeSearchController.page.value++;
      homeSearchController.searchingData(context: context);
      print("call");
    }else{
      print("dont call");
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeSearchController.searchingData( allowClear: true, context: context);
      // controller.searchDataModel.value.data != null
      //     ? controller.searchDataModel.value.data!.clear()
      //     : Container();
      // homeSearchController.searchingData(allowClear: true,context: context);
    });
    scrollController.addListener(_scrollListener);


  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: locale == Locale('en','US') ? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
         backgroundColor: const Color(0xffF6F6F6),
        appBar: backAppBar1(title: "Search Product".tr, context: context),
        body: SingleChildScrollView(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Column(
              children: [
                SizedBox(
                  height: height * .07,
                  child: TextField(
                    maxLines: 1,
                    controller: homeSearchController.searchController,
                    style: const TextStyle(fontSize: 17),
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {

                      homeSearchController.searchingData(allowClear: true,context: context);
                    },
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            print("hello");
                            homeSearchController.searchingData(allowClear: true, context: context);

                          },
                          icon: const Icon(
                            Icons.search_rounded,
                            color: AppTheme.primaryColor,
                            size: 30,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * .04),
                        hintText: 'Search food or restaurant'.tr,
                        hintStyle: TextStyle(
                            fontSize: AddSize.font14,
                            color: AppTheme.blackcolor,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Obx(() {
                  return homeSearchController.isDataLoading.value ? (homeSearchController.searchModel2.isNotEmpty)
                      ?
                  GridView.builder(
                            shrinkWrap: true,
                            itemCount: homeSearchController.load.value == false ?  homeSearchController.searchModel2.length + 1  :  homeSearchController.searchModel2.length  ,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 230,
                            mainAxisSpacing: 20.0),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {

                          if(index < homeSearchController.searchModel2.length){
                            return InkWell(
                                onTap: () {

                                  singleStoreController
                                      .storeId.value =
                                      homeSearchController.searchModel2[index].id
                                          .toString();
                                  print(homeSearchController.searchModel2[index].id
                                      .toString());
                                  Get.toNamed(StoreScreen
                                      .singleStoreScreen);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppTheme
                                            .backgroundcolor,
                                        borderRadius:
                                        BorderRadius
                                            .circular(16)),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(
                                          horizontal: AddSize
                                              .padding10,
                                          vertical: AddSize
                                              .padding10),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                //color: Colors.grey,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    topLeft: Radius.circular(20)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                ),
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl: homeSearchController.searchModel2[index].image
                                                      .toString(),
                                                  errorWidget: (_, __, ___) =>
                                                  const SizedBox(),
                                                  placeholder: (_, __) =>
                                                  const SizedBox(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                         // addHeight(10),
                                          Text(
                                            homeSearchController.searchModel2[
                                            index]
                                                .name
                                                .toString(),
                                            style: GoogleFonts.ibmPlexSansArabic(
                                                color:Color(0xff08141B),
                                                fontSize:
                                                AddSize
                                                    .font14,
                                                fontWeight:
                                                FontWeight
                                                    .w500),
                                          ),
                                          FittedBox(
                                            child: Row(
                                              children: [
                                                Text("SR",
                                                  style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(
                                                          0xff2C4D61)),), SizedBox(width: 3,),
                                                Text("${homeSearchController.searchModel2[index].deliveryCharge.toString()}",
                                                  style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(
                                                          0xff2C4D61)),), SizedBox(width: 5,),
                                                Icon(Icons.circle,size: 5,color: Color(
                                                    0xff2C4D61)),
                                                SizedBox(width: 5,),
                                                Text("KM",
                                                  style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(
                                                          0xff2C4D61)),), SizedBox(width: 3,),
                                                Text("${homeSearchController.searchModel2[index].distance.toString()}",
                                                  style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(
                                                          0xff2C4D61)),), SizedBox(width: 5,),
                                                Icon(Icons.circle,size: 5,color: Color(
                                                    0xff2C4D61)),
                                                SizedBox(width: 5,),

                                                Text("${homeSearchController.searchModel2[index].avgRating.toString()}",
                              style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(
                                                          0xff2C4D61)),),
                                                SizedBox(width: 5,),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    )));
                          }
                          else{
                       if(homeSearchController.load.value == true){
                         return Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SizedBox(
                                 height: 30,
                                 width: 30,
                                 child: CircularProgressIndicator()),
                           ],
                         );
                       }
                          }
                          })
                      : const Text("No data found"):Center(child: CircularProgressIndicator());
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // buildDropdownButtonFormField(int index) {
  //   return Obx(() {
  //     return DropdownButtonFormField<int>(
  //         decoration: InputDecoration(
  //           fillColor: Colors.grey.shade50,
  //           border: InputBorder.none,
  //           enabled: true,
  //         ),
  //         value:
  //             controller.searchDataModel.value.data![index].varientIndex!.value,
  //         hint: Text(
  //           'Select qty',
  //           style:
  //               TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
  //         ),
  //         items: List.generate(
  //             controller.searchDataModel.value.data![index].varints!.length,
  //             (index1) => DropdownMenuItem(
  //                   value: index1,
  //                   child: Text(
  //                     "${controller.searchDataModel.value.data![index].varints![index1].variantQty}${controller.searchDataModel.value.data![index].varints![index1].variantQtyType}",
  //                     style: const TextStyle(fontSize: 16),
  //                   ),
  //                 )),
  //         onChanged: (newValue) {
  //           controller.searchDataModel.value.data![index].varientIndex!.value =
  //               newValue!;
  //           setState(() {});
  //         });
  //   });
  // }
}
