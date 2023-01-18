import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({Key? key}) : super(key: key);

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final List<String> categoryData = [
    "Fruits",
    "Vegie",
    "Dairy",
    "Fruits",
    "Vegie",
    "Dairy",
    "Fruits",
    "Vegie",
    "Dairy",
    "Fruits",
    "Vegie",
    "Dairy",
    "Fruits",
    "Vegie",
    "Dairy"
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Get.toNamed(StoreScreen.singleStoreScreen);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: AppTheme.backgroundcolor,
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding10,
                                  vertical: AddSize.padding10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * .19,
                                    width: width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://media.istockphoto.com/id/1328991116/photo/fresh-vegetables-and-fruits-on-counter-in-grocery-supermarket.jpg?b=1&s=170667a&w=0&k=20&c=yPu0rw6pU8oD4c3YR91bzKQx2GxyZxBQFpzMwVwR_g4=",
                                        errorWidget: (_, __, ___) =>
                                            const SizedBox(),
                                        placeholder: (_, __) =>
                                            const SizedBox(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  addHeight(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Store abcd@3125A#",
                                        style: TextStyle(
                                            color: AppTheme.blackcolor,
                                            fontSize: AddSize.font14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppTheme.primaryColor,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: width * .02,
                                          ),
                                          Text(
                                            "2KM",
                                            style: TextStyle(
                                                color: AppTheme.blackcolor,
                                                fontSize: AddSize.font12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )));
                  },
                ),
                addHeight(30)
              ],
            ),
          ),
        ));
  }
}
