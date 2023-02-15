import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/home_page_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';

class SearchScreenData extends StatefulWidget {
  const SearchScreenData({Key? key}) : super(key: key);

  @override
  State<SearchScreenData> createState() => _SearchScreenDataState();
}

class _SearchScreenDataState extends State<SearchScreenData> {
  final controller = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    controller.getSearchData();
    controller.searchDataModel.value.data != null
        ? controller.searchDataModel.value.data!.clear()
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xff4169E2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              const Text(
                "Search Product",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff292F45),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 19),
            child: Column(
              children: [
                SizedBox(
                  height: height * .07,
                  child: TextField(
                    maxLines: 1,
                    controller: controller.searchController,
                    style: const TextStyle(fontSize: 17),
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      controller.getSearchData();
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.getSearchData().then((value) {
                              if (value.status == false) {
                                showToast("No data found");
                              }
                            });
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
                        hintText: 'Search Your Groceries',
                        hintStyle: TextStyle(
                            fontSize: AddSize.font14,
                            color: AppTheme.blackcolor,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                // Row(
                //   children: [
                //     Container(
                //         width: 23,
                //         height: 21,
                //         decoration: BoxDecoration(
                //           color: const Color(0xff4169E2),
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //         child: IconButton(
                //           padding: EdgeInsets.zero,
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           icon: const Icon(
                //             Icons.arrow_back_ios,
                //             color: Colors.white,
                //             size: 15,
                //           ),
                //         )),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     const Text(
                //       "Add Product",
                //       style: TextStyle(
                //           fontSize: 20,
                //           color: Color(0xff292F45),
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Card(
                //   elevation: 5,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   child: SizedBox(
                //     height: 176,
                //     width: 336,
                //     child: TextField(
                //       //maxLines: 1,
                //       controller: controller.searchController,
                //       style: const TextStyle(fontSize: 17),
                //       textAlignVertical: TextAlignVertical.center,
                //
                //       textInputAction: TextInputAction.search,
                //       onSubmitted: (value) {
                //         controller.getSearchData();
                //       },
                //       textAlign: TextAlign.center,
                //       decoration: InputDecoration(
                //         hintText: 'search here..',
                //         hintStyle: TextStyle(),
                //         border: const UnderlineInputBorder(
                //             borderSide: BorderSide.none),
                //         // filled: true,
                //         suffixIcon: IconButton(
                //           onPressed: () {},
                //           icon: const Icon(
                //             Icons.search_rounded,
                //             color: Colors.black,
                //             size: 30,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Obx(() {
                  return ListView.builder(
                      itemCount: controller.searchDataModel.value.data != null
                          ? controller.searchDataModel.value.data!.length
                          : 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(controller
                              .searchDataModel.value.data![index].image
                              .toString()),
                          title: Text(controller
                              .searchDataModel.value.data![index].name
                              .toString()),
                          // leading: Image.network(homeSearchController
                          //     .searchModel.value.data![index].image
                          //     .toString()),
                        );
                      });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
