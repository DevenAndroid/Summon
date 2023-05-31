import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/store_controller.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../controller/near_store_controller.dart';
import '../controller/single_store_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({Key? key}) : super(key: key);
  static var storeListScreen = "/storeListScreen";

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final TextEditingController storeSearchController=TextEditingController();
  final scrollController = ScrollController();
  final storeController = Get.put(StoreController());
  final singleStoreController = Get.put(SingleStoreController());


  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      storeController
          .getData()
          .then((value) => setState(() {}));
    }
  }

  final myCartController = Get.put(MyCartDataListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeController.getData(isFirstTime: true);
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: backAppBar1(title: 'Store List', context: context),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          color: AppTheme.primaryColor,
          onRefresh: ()async{
           await storeController.getData();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16, vertical: AddSize.padding10),
              child: Column(
                children: [
                  Obx(() {
                    return storeController.isDataLoading.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .06,
                                child: TextField(
                                  maxLines: 1,
                                  //controller:
                                  //homeSearchController.storeSearchController,
                                  style: const TextStyle(fontSize: 17),
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.search,
                                  onChanged: (value){
                                    //storeController.getData();
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                         // storeController.getData();
                                        },
                                        icon: const Icon(
                                          Icons.search_rounded,
                                          color: Color(0xff8990A7),
                                          size: 30,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: width * .05,vertical: 16),
                                      hintText: 'Search Store',
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff8990A7),
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),

                              SizedBox(
                                height: height * .01,
                              ),
                              storeController.model.value.data!.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Store Not Available',
                                        style: TextStyle(
                                            color: AppTheme.backgroundcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   '(${storeController.model.value.data!.length}) Stores Near You',
                                        //   style: const TextStyle(
                                        //       color: AppTheme.backgroundcolor,
                                        //       fontSize: 16,
                                        //       fontWeight: FontWeight.w600),
                                        // ),
                                        SizedBox(
                                          height: height * .01,
                                        ),
                                        Obx(() {
                                          return
                                            ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: storeController
                                                .model.value.data!.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                  onTap: () {
                                                    print(" store id is...${storeController.model
                                                        .value.data![index].id
                                                        .toString()}");
                                                    Get.toNamed(StoreScreen
                                                        .singleStoreScreen);
                                                    singleStoreController
                                                            .storeId.value =
                                                        storeController.model
                                                            .value.data![index].id
                                                            .toString();
                                                    setState(() {

                                                    });
                                                  },
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      decoration: BoxDecoration(
                                                        boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 3)],
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
                                                            SizedBox(
                                                              height:
                                                                  height * .19,
                                                              width: width,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: storeController
                                                                      .model
                                                                      .value
                                                                      .data![
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
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            addHeight(10),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  storeController
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(0xff21283D),
                                                                      fontSize: 17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Color(0xffFFC529),
                                                                      size: 20,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                              .02,
                                                                    ),
                                                                    Text(
                                                                      "4.5",
                                                                      style: TextStyle(
                                                                          color:Color(0xff333333),
                                                                          fontSize:
                                                                              AddSize
                                                                                  .font14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: height * .01,),
                                                            Row(
                                                              children: [
                                                                 Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: AppTheme
                                                                      .primaryColor.withOpacity(.80),
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  width *
                                                                      .02,
                                                                ),
                                                                Text(
                                                                  "${storeController.model.value.data![index].distance.toString()} KM",
                                                                  style: TextStyle(
                                                                      color: AppTheme
                                                                          .blackcolor,
                                                                      fontSize:
                                                                      AddSize
                                                                          .font12,
                                                                      fontWeight:
                                                                      FontWeight.w400),
                                                                ),
                                                              ],
                                                            ),


                                                          ],
                                                        ),

                                                      )));

                                            },
                                          );
                                        }),
                                        SizedBox(
                                          height: height * .04,
                                        )
                                      ],
                                    ),
                            ],
                          )
                        : Center(child: const CircularProgressIndicator());
                  }),
                  addHeight(30)
                ],
              ),
            ),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: myCartController.isDataLoaded.value
            ? myCartController.model.value.data!.cartItems!.isNotEmpty
                ? addCartSection()
                : null
            : const SizedBox(),
      );
    });
  }
}
