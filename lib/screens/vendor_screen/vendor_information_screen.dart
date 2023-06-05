import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/controller/home_page_controller.dart';
import 'package:fresh2_arrive/controller/store_controller.dart';
import 'package:fresh2_arrive/repositories/vendor_registration_repo.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../controller/MyAddress_controller.dart';
import '../../controller/VendorInformation_Controller.dart';
import '../../controller/main_home_controller.dart';
import '../../controller/vendor_category_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../resources/showDialog.dart';
import '../../widgets/registration_form_textField.dart';
import '../Language_Change_Screen.dart';
import 'add_address_screen.dart';

class VendorInformation extends StatefulWidget {
  const VendorInformation({Key? key}) : super(key: key);
  static var vendorInformation = "/vendorInformation";

  @override
  State<VendorInformation> createState() => _VendorInformationState();
}

class _VendorInformationState extends State<VendorInformation> {
  final vendorInformationController = Get.put(VendorInformationController());
  final vendorCategoryController = Get.put(VendorCategoryController());
  final myAddressController = Get.put(MyAddressController());


  assignMissingCategory(){
    if(vendorInformationController.isDataLoading.value && vendorCategoryController.model.value.data != null){
      List<String> ids = vendorInformationController.model.value.data!.storeCategory!.map((e) => e.toString()).toList();
      for(var item in vendorCategoryController.model.value.data!.categories!){
        if(ids.contains(item.id.toString())){
          item.selected = true;
        }
      }
      vendorCategoryController.categoryController.text  = vendorCategoryController.model.value.data!.categories!.where((element) => element.selected == true).toList().map((e) => e.name.toString()).toList().join(',');
      setState(() {});
    }
  }

  final controller = Get.put(MainHomeController());
  final homeController = Get.put(HomePageController());
  final storeController = Get.put(StoreController());
  Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  RxString selectedCAt = "".obs;

  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;

  @override
  void initState() {
    super.initState();
    vendorInformationController.getVendorInformation().then((value) {
      assignMissingCategory();
    });
    vendorCategoryController.getCategory().then((value) {
      assignMissingCategory();
    });
  }

  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.easeOutSine);
  }

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        appBar: backAppBar(title: "Vendor Information".tr, context: context),
        body: Obx(() {
          return vendorInformationController.isDataLoading.value
              ? SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RegistrationTextField(
                                      controller:
                                      vendorInformationController.storeName,
                                      hint: "Store Name",
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Store name is required')
                                      ])),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  RegistrationTextField(
                                      controller:
                                      vendorInformationController.phoneController,
                                      hint: "Phone number",
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Store Phone number is required')
                                      ])),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  RegistrationTextField(
                                      controller:
                                      vendorInformationController.businessIdController,
                                      hint: "Business ID (number)",
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Business ID (number) is required')
                                      ])),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  RegistrationTextField(
                                    readOnly: true,
                                    controller: vendorCategoryController.categoryController,
                                    hint: "Select Category",
                                    //length: 12,
                                    // keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please chose category';
                                      }
                                      return null;
                                    },
                                    suffix: InkWell(onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context){
                                            return ShowDialogForCategories();
                                          });
                                    },
                                      child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,),),
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  Text(
                                    "Store Logo".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font16,color: Color(0xff2F2F2F)),
                                  ),
                                  SizedBox(
                                    height: AddSize.padding12,
                                  ),
                                  Obx(() {
                                    return image.value.path == ""
                                        ? Stack(
                                      children: [
                                        SizedBox(
                                          height: AddSize.size125,
                                          width: AddSize.screenWidth,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              vendorInformationController
                                                  .model
                                                  .value
                                                  .data!
                                                  .storeImage
                                                  .toString(),
                                              errorWidget: (_, __, ___) =>
                                              const SizedBox(),
                                              placeholder: (_, __) =>
                                              const SizedBox(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: AddSize.padding10,
                                          top: AddSize.padding10,
                                          child: GestureDetector(
                                            onTap: () {
                                              NewHelper()
                                                  .addFilePicker()
                                                  .then((value) {
                                                image.value = value;
                                              });
                                            },
                                            child: Container(
                                              height: AddSize.size30,
                                              width: AddSize.size30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppTheme
                                                          .backgroundcolor),
                                                  color:
                                                  AppTheme.primaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50)),
                                              child: const Center(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: AppTheme
                                                        .backgroundcolor,
                                                    size: 20,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : Container(
                                      width: double.maxFinite,
                                      height: AddSize.size100,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AddSize.padding16,
                                          vertical: AddSize.padding16),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: SizedBox(
                                        height: AddSize.size125,
                                        width: AddSize.screenWidth,
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            child: Image.file(image.value)),
                                      ),
                                    );
                                  }),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),


                                  Text(
                                    "Business ID".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font16,color: Color(0xff2F2F2F)),
                                  ),
                                  SizedBox(
                                    height: AddSize.padding12,
                                  ),
                                  Obx(() {
                                    return image1.value.path == ""
                                        ? Stack(
                                      children: [
                                        SizedBox(
                                          height: AddSize.size125,
                                          width: AddSize.screenWidth,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            child:
                                            CachedNetworkImage(
                                              imageUrl:
                                              vendorInformationController
                                                  .model
                                                  .value
                                                  .data!
                                                  .businessIdImage
                                                  .toString(),
                                              errorWidget: (_, __, ___) =>
                                              const SizedBox(),
                                              placeholder: (_, __) =>
                                              const SizedBox(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: AddSize.padding10,
                                          top: AddSize.padding10,
                                          child: GestureDetector(
                                            onTap: () {
                                              NewHelper()
                                                  .addFilePicker()
                                                  .then((value) {
                                                image1.value = value;
                                              });
                                            },
                                            child: Container(
                                              height: AddSize.size30,
                                              width: AddSize.size30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppTheme
                                                          .backgroundcolor),
                                                  color:
                                                  AppTheme.primaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50)),
                                              child: const Center(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: AppTheme
                                                        .backgroundcolor,
                                                    size: 20,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : Container(
                                      width: double.maxFinite,
                                      height: AddSize.size100,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AddSize.padding16,
                                          vertical: AddSize.padding16),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: SizedBox(
                                        height: AddSize.size125,
                                        width: AddSize.screenWidth,
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            child: Image.file(image1.value)),
                                      ),
                                    );
                                  }),
                                  SizedBox(
                                    height: AddSize.padding12,
                                  ),
                                  Text(
                                    "Location".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font16,color: Color(0xff2F2F2F)),
                                  ),
                                  SizedBox(
                                    height: AddSize.padding12,
                                  ),
                                  Stack(
                                      children: [
                                        Image.asset('assets/images/mapimg.png'),
                                        Positioned(top: 50,
                                          right: 150,
                                          child: InkWell(onTap: (){
                                            Get.toNamed(AddAddressScreen.addAddressScreen);
                                          },
                                              child: CircleAvatar(backgroundColor: Colors.white,
                                                  radius: 22,
                                                  child: Icon((Icons.telegram),size: 30,color: Color(0xFFFE724C),))),
                                        ),
                                      ]
                                  ),
                                  SizedBox(
                                    height: AddSize.padding12,
                                  ),

                                  SizedBox(
                                    height: AddSize.padding12,
                                  ),


                                  ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {

                                          var item= vendorCategoryController.model.value.data!.categories!.where((element) => element.selected == true)
                                              .map((e) => e.id.toString()).toList();
                                          Map<String, dynamic> map1={};
                                          for(var i=0; i<item.length; i++){
                                            map1[i.toString()]=item[i];
                                          }

                                          Map<String, String> mapData = {
                                            'store_name':
                                            vendorInformationController
                                                .storeName.text
                                                .trim(),
                                            'phone':
                                            vendorInformationController
                                                .phoneController.text
                                                .trim(),
                                            'latitude':
                                                myAddressController.latLong2 ?? '',
                                            'longitude': myAddressController.latLong1 ?? '',
                                            'business_id': vendorInformationController.businessIdController.text,
                                            'category': jsonEncode(map1),

                                          };
                                          vendorInformationEditRepo(
                                              context: context,
                                              mapData: mapData,
                                              fieldName1: "store_image",
                                              fieldName2: "business_id_image",
                                              file1:image.value,
                                              file2: image1.value)
                                              .then((value) {
                                            showToast(value.message);
                                            if (value.status == true) {
                                              vendorInformationController.getVendorInformation();
                                            } else {
                                              showToast(value.message);
                                            }
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            const Size(double.maxFinite, 60),
                                        primary: AppTheme.primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        "APPLY".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font18),
                                      )),
                                  SizedBox(
                                    height: AddSize.size15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
          ));
        }),
      ),
    );
  }
}
