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
  Rx<CategoriesModel> model = CategoriesModel().obs;
  RxBool isDataLoaded = false.obs;
  getCategory(){
    vendorCategoryRepo().then((value1) {
      model.value = value1;
      if(value1.status == true){
        isDataLoaded.value = true;
      }
    });
  }

  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return   Obx(() {
      return  Dialog(
        insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery
              .of(context)
              .size
              .height * .30,
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
            child: isDataLoaded.value  ?
            ListView.builder(
                itemCount: model.value.data!.categories!.length,
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
                              model.value.data!.categories![index].name
                                  .toString(), style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: AddSize.font14,color: AppTheme.userText,),),
                            value: model.value.data!.categories![index]
                                .selected,
                            onChanged: (_) {
                              setState(() {
                                if (model.value.data!.categories![index]
                                    .selected == false) {
                                  model.value.data!.categories![index]
                                      .selected = true; //
                               vendorCategoryController.categoryController.text  = model.value.data!.categories![index]
                                      .name.toString();
                                } else {
                                  model.value.data!.categories![index]
                                      .selected = false; // select
                                  vendorCategoryController.categoryController.clear();
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            autofocus: false,
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            //selected: _value,
                            // value: _value,
                            /* onChanged: (value) {
                                                          */ /*      setState(() {
                                                                  _isValue1 = value;
                                                                });*/ /*
                                                              },*/
                          ),
                          /*  Text(model.value.data!.categories![index].name.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                                            SizedBox(height: 10,),*/

                        ],
                      ),
                    ),
                  );
                }) :

            CircularProgressIndicator()
          ),
        ),
      );
    });
  }
}
