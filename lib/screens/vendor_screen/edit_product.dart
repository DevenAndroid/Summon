import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/registration_form_textField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../resources/app_assets.dart';
import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static var editProductScreen = "/editProductScreen";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController marketPriceController = TextEditingController();
  final TextEditingController myPriceController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  Rx<File> image = File("").obs;
  final _formKey = GlobalKey<FormState>();

  showChangeAddressSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: AddSize.size20,
              ),
              Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding16,
                      vertical: AddSize.padding16),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          NewHelper()
                              .addImagePicker(imageSource: ImageSource.camera)
                              .then((value) {
                            for (var i = 0; i < imageList.length; i++) {
                              if (imageList[i].path == "") {
                                imageList[i] = value!;
                                Get.back();
                                break;
                              }
                            }
                          });
                        },
                        child: Text(
                          "Take picture",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font16),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size12,
                      ),
                      Divider(),
                      SizedBox(
                        height: AddSize.size12,
                      ),
                      InkWell(
                        onTap: () {
                          NewHelper().addFilePickerList().then((value) {
                            if (value != null) {
                              for (var item in value) {
                                if (imageList.length < 6) {
                                  imageList.add(item);
                                }
                              }
                            }
                          });
                        },
                        child: Text(
                          "Choose From Gallery",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font16),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size12,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                            // Get.toNamed(MyRouter.chooseAddressScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(AddSize.size250, AddSize.size50),
                            primary: AppTheme.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Cancel".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: AppTheme.backgroundcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AddSize.font16),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  RxList<File> imageList = <File>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: "Edit Products", context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16, vertical: AddSize.padding10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.backgroundcolor),
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding16,
                      vertical: AddSize.padding10),
                  child: Column(
                    children: [
                      Obx(() {
                        return DottedBorder(
                            radius: const Radius.circular(10),
                            borderType: BorderType.RRect,
                            dashPattern: const [3, 5],
                            color: Colors.grey.shade500,
                            strokeWidth: 1,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding16),
                                width: AddSize.screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: image.value.path == ""
                                    ? Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              NewHelper()
                                                  .addFilePicker()
                                                  .then((value) {
                                                image.value = value;
                                              });
                                            },
                                            child: Icon(
                                              Icons.file_upload_outlined,
                                              size: AddSize.size30,
                                            ),
                                          ),
                                          SizedBox(
                                            height: AddSize.size10,
                                          ),
                                          const Text("Upload  Product image"),
                                        ],
                                      )
                                    : SizedBox(
                                        width: double.maxFinite,
                                        height: AddSize.size100,
                                        child: Image.file(image.value))));
                      }),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      RegistrationTextField(
                        hint: "Product Name",
                        controller: productNameController,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Please enter product name")
                        ]),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      RegistrationTextField(
                        hint: "Market Price",
                        controller: marketPriceController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Please enter price")
                        ]),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      RegistrationTextField(
                        hint: "My Price",
                        controller: myPriceController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Please enter my price")
                        ]),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      RegistrationTextField(
                        hint: "SKU",
                        controller: skuController,
                        validator: MultiValidator(
                            [RequiredValidator(errorText: "Please enter SKU")]),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RegistrationTextField(
                              hint: "Qty",
                              controller: qtyController,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Please enter qty")
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: AddSize.size10,
                          ),
                          Expanded(
                            child: RegistrationTextField(
                              hint: "Price",
                              controller: priceController,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please enter price")
                              ]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: AddSize.size30,
                              width: AddSize.size30,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade600,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.add,
                                color: AppTheme.backgroundcolor,
                                size: AddSize.size25,
                              )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.backgroundcolor),
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Image Gallery",
                                style: TextStyle(
                                    fontSize: AddSize.font14,
                                    color: AppTheme.blackcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  showChangeAddressSheet();
                                },
                                child: Text(
                                  "Choose From Gallery",
                                  style: TextStyle(
                                      fontSize: AddSize.font12,
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                        Obx(() {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: imageList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding16),
                                    margin: const EdgeInsets.all(05),
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: imageList[index].path == ""
                                        ? GestureDetector(
                                            onTap: () {
                                              NewHelper()
                                                  .addFilePicker()
                                                  .then((value) {
                                                if (imageList[index].path ==
                                                    "") {
                                                  imageList[index] = value!;
                                                  // Get.back();
                                                  // break;
                                                }
                                              });
                                              // NewHelper()
                                              //     .addFilePicker()
                                              //     .then((value) {
                                              //   image.value = value;
                                              // });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Center(
                                                  child: Image(
                                                      height: AddSize.size25,
                                                      width: AddSize.size25,
                                                      color:
                                                          Colors.grey.shade500,
                                                      image: const AssetImage(
                                                          AppAssets
                                                              .camaraImage))),
                                            ),
                                          )
                                        : SizedBox(
                                            width: double.maxFinite,
                                            height: AddSize.size100,
                                            child: Image.file(
                                                File(imageList[index].path))));
                              },
                            ),
                          );
                        }),
                      ],
                    )),
                SizedBox(
                  height: AddSize.size10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.maxFinite, AddSize.size45),
                      primary: AppTheme.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "SAVE",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: AppTheme.backgroundcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: AddSize.font18),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
