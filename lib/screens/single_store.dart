import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/main_home_controller.dart';
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
  final controller = Get.put(MainHomeController());
  final List<String> categoryData = ["Fruits", "Veggie", "Dairy", "Juice"];
  final List<String> dropDownList = ["1 pc", "2 pc", "3 pc"];
  String? selectedCAt;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar(title: "Store", context: context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            excludeHeaderSemantics: false,
            snap: false,
            floating: false,
            expandedHeight: height * .28,
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 0,
            // toolbarHeight: 150,
            // title: ,
            bottom: PreferredSize(
              preferredSize: Size(width, AddSize.size40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .03),
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
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Store abcd@3125A#",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    " ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
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
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(bottom: AddSize.size45),
                child: Image.asset(
                  AppAssets.singleStrore,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .012,
                    ),
                    const Text(
                      'Categories',
                      style: TextStyle(
                          color: AppTheme.blackcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    SizedBox(height: height * 0.13, child: categoryList()),
                    SizedBox(height: height * .015),
                    const Text(
                      "Latest Product",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: height * .015,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            // height: height * .23,
                            child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * .02,
                                        vertical: height * .01,
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: height * .12,
                                              width: width * .25,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://media.istockphoto.com/id/673162168/photo/green-cabbage-isolated-on-white.jpg?s=612x612&w=0&k=20&c=mCc4mXATvCcfp2E9taRJBp-QPYQ_LCj6nE1D7geaqVk=",
                                                errorWidget: (_, __, ___) =>
                                                    const SizedBox(),
                                                placeholder: (_, __) =>
                                                    const SizedBox(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * .01,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                      "Coriander Leaves And Greens",
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .blackcolor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  SizedBox(
                                                    height: height * .01,
                                                  ),
                                                  Container(
                                                    width: width * .60,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * .02),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        color: Colors
                                                            .grey.shade100),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        isExpanded: false,
                                                        hint: const Text(
                                                          'Select Category',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        value: selectedCAt == ""
                                                            ? null
                                                            : selectedCAt,
                                                        items: dropDownList
                                                            .map((value) {
                                                          return DropdownMenuItem(
                                                            value: value
                                                                .toString(),
                                                            child: Text(
                                                              value,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedCAt =
                                                                newValue
                                                                    as String?;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * .01,
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
                                                            width: width * .02,
                                                          ),
                                                          const Text(
                                                            "₹12.0",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            width: width * .02,
                                                          ),
                                                          const Text(
                                                            "₹12.0",
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          side: const BorderSide(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              width: 1),
                                                          backgroundColor:
                                                              AppTheme.addColor,
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text('ADD',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )
                                                      // ElevatedButton(
                                                      //     onPressed: () {
                                                      //       // Get.toNamed(MyRouter.summaryScreen);
                                                      //     },
                                                      //     style: ElevatedButton.styleFrom(
                                                      //         // backgroundColor: Colors.black
                                                      //         ),
                                                      //     child: const Text(
                                                      //       "Add",
                                                      //       style: TextStyle(
                                                      //           color: Colors.white,
                                                      //           fontWeight:
                                                      //               FontWeight.w500,
                                                      //           fontSize: 18),
                                                      //     )),
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
                                                color: AppTheme.primaryColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Text(
                                              "20% OFF",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      AppTheme.backgroundcolor,
                                                  fontWeight: FontWeight.w400),
                                            )))),
                                  ],
                                )),
                          );
                        }),
                    SizedBox(
                      height: height * .01,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.onItemTap(1);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.square(80),
                          primary: AppTheme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "5 items",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppTheme.backgroundcolor,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "₹12.0",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.backgroundcolor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Text(
                                  "View Cart",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppTheme.backgroundcolor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: 30,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  categoryList() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: categoryData.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.only(
              right: height * .01,
            ),
            decoration: BoxDecoration(
                color: index % 3 == 0
                    ? AppTheme.appPrimaryPinkColor
                    : index % 3 == 2
                        ? AppTheme.appPrimaryGreenColor
                        : AppTheme.appPrimaryYellowColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .03,
                vertical: height * .005,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  Image(
                    image: const AssetImage(
                      AppAssets.category_image,
                    ),
                    height: AddSize.size50,
                    width: AddSize.size80,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Text(
                    categoryData[index],
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: AddSize.font12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ));
      },
    );
  }
}
