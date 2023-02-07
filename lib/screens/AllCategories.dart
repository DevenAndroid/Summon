import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/category_controller.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final controller = Get.put(MainHomeController());
  final categoryController = Get.put(CategoryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          return categoryController.isDataLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding15,
                      vertical: AddSize.padding15),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: categoryController.model.value.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisExtent: 150,
                              mainAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        var itemdata =
                            categoryController.model.value.data![index];
                        return GestureDetector(
                          onTap: () {
                            Get.back();
                            controller.onItemTap(3);
                          },
                          child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: AddSize.size50 * 1.5,
                                    width: AddSize.size45 * 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: itemdata.image.toString(),
                                        errorWidget: (_, __, ___) => SizedBox(),
                                        placeholder: (_, __) => SizedBox(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Image(
                                  //   image:
                                  //       AssetImage(AppAssets.category_image),
                                  //   height: AddSize.size50,
                                  //   width: AddSize.size30 * 2,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Text(
                                    itemdata.name.toString(),
                                    style: TextStyle(
                                        color: AppTheme.subText,
                                        fontSize: AddSize.font14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        );
                      }),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ));
        }));
  }
}
