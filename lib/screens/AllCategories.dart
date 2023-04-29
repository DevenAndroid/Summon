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
import '../resources/app_assets.dart';
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

  int currentIndex = -1;

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
      return
        Scaffold(
          appBar:  AppBar(
              backgroundColor: Color(0xffFFFFFF),
              elevation: 0,
              leadingWidth: AddSize.size80,
              leading: Padding(
                padding: EdgeInsets.only(left: 33,right: 20),
                child: GestureDetector(
                  child: Image.asset(
                    AppAssets.BACKICON,
                    height: AddSize.size30,
                  ),
                  onTap: () {

                  },
                ),
              ),
              centerTitle: false,
              title: Text("Category", style: TextStyle(
                  color: Color(0xff423E5E),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),)


          ),
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
                          crossAxisCount: 4,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 140,
                          mainAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        var itemdata = categoryController.model.value.data![index];
                        return GestureDetector(
                          onTap: () {
                            currentIndex=index;
                            setState(() {

                            });
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
                                  color: currentIndex == index ? AppTheme.primaryColor.withOpacity(.80): Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(

                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                    height: AddSize.size50 * 1,
                                    width: AddSize.size50 * 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl: "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?cs=srgb&dl=pexels-pixabay-461198.jpg&fm=jpg",
                                          // itemdata.image.toString(),
                                          errorWidget: (_, __, ___) => const SizedBox(),
                                          placeholder: (_, __) => const SizedBox(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    itemdata.name.toString().capitalizeFirst!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: currentIndex == index ? Colors.white: Color(0xff67666D) ,
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