import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/home_page_controller.dart';
import '../resources/app_theme.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        toolbarHeight: 60,
        leadingWidth: 45,
        leading: Container(
          height: 21,
          width: 23,
          decoration: BoxDecoration(
            color: Color(0xff4169E2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: Color(0xffFFFFFF),
        title: const Text(
          "Add Product",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff292F45),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_rounded,
                        color: AppTheme.primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                return ListView.builder(
                    itemCount: controller.searchDataModel.value.data != null
                        ? controller.searchDataModel.value.data!.length
                        : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // leading: Text(controller
                        //     .searchDataModel.value.data![index].image
                        //     .toString()),
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
    );
  }
}
