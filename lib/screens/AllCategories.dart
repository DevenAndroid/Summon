import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/store_by_category.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/My_cart_controller.dart';
import '../controller/category_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/store_by_category_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final controller = Get.put(MainHomeController());
  final categoryController = Get.put(CategoryController());
  final nearStoreController= Get.put(StoreByCategoryController());
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    categoryController.getData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      categoryController.getData(context: context)
          .then((value) => setState(() {}));
    }
  }

  final myCartController = Get.put(MyCartDataListController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        // backgroundColor: Colors.white,
        body: Obx(() {
          return categoryController.isDataLoading.value
              ? Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding15),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: AddSize.size20,),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categoryController.model.value.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 140,
                          mainAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        var itemdata = categoryController.model.value.data![index];
                        return GestureDetector(
                          onTap: () {
                            nearStoreController
                                .storeId.value = categoryController.model
                                .value.data![index].id
                                .toString();
                            log(nearStoreController
                                .storeId.value);
                            Get.toNamed(StoreByCategoryListScreen.storeByCategoryScreen);
                          },
                          child: Container(
                            //height: 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding10,
                                  vertical: AddSize.padding10),
                              decoration: BoxDecoration(
                                  color: index % 3 == 0
                                      ? AppTheme.appPrimaryPinkColor
                                      : index % 3 == 2
                                      ? AppTheme.appPrimaryGreenColor
                                      : AppTheme.appPrimaryYellowColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: AddSize.size50 * 1.2,
                                    width: AddSize.size50 * 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: itemdata.image.toString(),
                                        errorWidget: (_, __, ___) => const SizedBox(),
                                        placeholder: (_, __) => const SizedBox(),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    itemdata.name.toString().capitalizeFirst!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppTheme.subText,
                                        fontSize: AddSize.font14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        );
                      }),
                ],
              ),
            ),
          )
              : const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ));
        }),
        extendBody: true,
        bottomNavigationBar: myCartController.isDataLoaded.value
            ? myCartController
            .model.value.data!.cartItems!.isNotEmpty
            ? addCartSection()
            : null
            : const SizedBox(),
      );
    });
  }
}