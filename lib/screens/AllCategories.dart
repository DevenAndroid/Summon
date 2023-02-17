import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/My_cart_controller.dart';
import '../controller/category_controller.dart';
import '../controller/main_home_controller.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController.getData();
  }

  final myCartController = Get.put(MyCartDataListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        // backgroundColor: Colors.transparent,
        body: Obx(() {
          return categoryController.isDataLoading.value
              ? Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding15, vertical: AddSize.padding15),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: categoryController.model.value.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    //  mainAxisExtent: 150,
                    mainAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  var itemdata = categoryController.model.value.data![index];
                  return GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.onItemTap(3);
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
                          children: [
                            SizedBox(
                              height: AddSize.size50 * 1.2,
                              width: AddSize.size50 * 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: itemdata.image.toString(),
                                  errorWidget: (_, __, ___) => SizedBox(),
                                  placeholder: (_, __) => SizedBox(),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              itemdata.name.toString(),
                              maxLines: 1,
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
        }),
        bottomNavigationBar: myCartController.isDataLoaded.value
            ? myCartController
            .model.value.data!.cartItems!.isNotEmpty
            ? addCartSection()
            : null
            : SizedBox(),
      );
    });
  }
}