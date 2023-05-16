import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../controller/vendor_category_controller.dart';
import '../model/vendor_category_model.dart';
import '../repositories/vendor_categories_repo.dart';
import 'app_theme.dart';

class ShowDialogForCategories extends StatefulWidget {
  const ShowDialogForCategories({Key? key}) : super(key: key);

  @override
  State<ShowDialogForCategories> createState() => _ShowDialogForCategoriesState();
}



class _ShowDialogForCategoriesState extends State<ShowDialogForCategories> {

  final vendorCategoryController = Get.put(VendorCategoryController());




  @override
  Widget build(BuildContext context) {
    return   Obx(() {
      return  Dialog(
        insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery
              .of(context)
              .size
              .height * .23,
          horizontal: MediaQuery
              .of(context)
              .size
              .width * .08,
        ),
        child: Container(
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child:   SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: vendorCategoryController.isDataLoaded.value  ?
            Column(
              children: [
                ListView.builder(
                    itemCount: vendorCategoryController.model.value.data!.categories!.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text(
                                  vendorCategoryController.model.value.data!.categories![index].name
                                      .toString(), style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: AddSize.font14,color: AppTheme.userText,),),
                                value: vendorCategoryController.model.value.data!.categories![index]
                                    .selected,
                                onChanged: (_) {
                                  setState(() {
                                    if (vendorCategoryController.model.value.data!.categories![index]
                                        .selected == false) {
                                      vendorCategoryController.model.value.data!.categories![index]
                                          .selected = true; //

                                    } else {
                                      vendorCategoryController.model.value.data!.categories![index]
                                          .selected = false; // select
                    /*                  vendorCategoryController.categoryController.clear();*/
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                                autofocus: false,
                                activeColor: AppTheme.primaryColor,
                                checkColor: Colors.white,
                                //selected: _value,
                                // value: _value,
                                /* onChanged: (value) {
                                                              */ /*      setState(() {
                                                                      _isValue1 = value;
                                                                    });*/ /*
                                                                  },*/
                              ),
                              SizedBox(height: AddSize.size5,),

                              /*  Text(model.value.data!.categories![index].name.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                                                SizedBox(height: 10,),*/

                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(height: AddSize.size5,),
                ElevatedButton(
                onPressed: (){
                  vendorCategoryController.categoryController.text  = vendorCategoryController.model.value.data!.categories!.where((element) => element.selected == true).toList().map((e) => e.name.toString()).toList().join(',');

                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                    backgroundColor: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: Text('Add',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                SizedBox(height: AddSize.size5,),
              ],
            )

                :
            CupertinoActivityIndicator(radius: 20,)
          ),
        ),
      );
    });
  }
}
