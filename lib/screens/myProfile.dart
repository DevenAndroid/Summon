import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/repositories/update_profile_repository.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';
import '../resources/new_helper.dart';
import '../widgets/add_text.dart';
import '../widgets/editprofile_textfield.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  static var myProfileScreen = "/myProfileScreen";
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final controller = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();

  showUploadWindow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AddSize.size10),
                    Text("Choose From Which",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font14)),
                          onPressed: () {
                            NewHelper().addFilePicker().then((value) {
                              controller.image.value = value!;
                              print(controller.image.value.path);
                            });
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text("Camera",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font14)),
                          onPressed: () {
                            NewHelper()
                                .addImagePicker(imageSource: ImageSource.camera)
                                .then((value) {
                              controller.image.value = value!;
                              print(controller.image.value.path);
                            });
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size20,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(
        title: "My Profile",
        context: context,
      ),
      body: Obx(() {
        return controller.isDataLoading.value &&
                controller.model.value.data != null
            ? SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                AppAssets.profileImage),
                                            fit: BoxFit.cover)),
                                    height: 112,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    controller.model.value.data!.name == null
                                        ? "Test Customer"
                                        : "${controller.model.value.data!.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font16),
                                  ),
                                  Text(
                                    controller.model.value.data!.email == null
                                        ? "abc@gmail.com"
                                        : "${controller.model.value.data!.email}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            fontWeight: FontWeight.w300,
                                            fontSize: AddSize.font14),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 50,
                                bottom: 85,
                                left: 0,
                                right: 0,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: Container(
                                      // margin: const EdgeInsets.only(bottom: 32),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: const ShapeDecoration(
                                        shape: CircleBorder(),
                                        // color: Colors.white,
                                      ),
                                      child: controller.image.value.path == ""
                                          ? controller.model.value.data!
                                                      .profileImage!.isEmpty ||
                                                  controller.model.value.data!
                                                          .profileImage! ==
                                                      "https://fresh2arrive.eoxyslive.com/uploads/profile-images"
                                              ? const SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                )
                                              : Image.network(
                                                  controller.model.value.data!
                                                      .profileImage
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 100,
                                                )
                                          : Image.file(
                                              controller.image.value,
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 100,
                                            ),
                                    ))),
                            Positioned(
                                right: 125,
                                top: 90,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: AppTheme.backgroundcolor),
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        showUploadWindow();
                                      },
                                      child: const Image(
                                          height: 10,
                                          width: 15,
                                          image: AssetImage(
                                              AppAssets.camaraImage)),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.backgroundcolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Edit Your Details",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AddSize.font16),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Name",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: AddSize.font14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditProfileTextFieldWidget(
                                  hint: "Enter Your Name",
                                  controller: controller.nameController,
                                  validator: validateName,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "E-mail",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: AddSize.font14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditProfileTextFieldWidget(
                                  hint: "Enter Your Email",
                                  controller: controller.emailController,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Mobile Number",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: AddSize.font14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditProfileTextFieldWidget(
                                  hint: "Enter Your Mobile Number",
                                  controller: controller.mobileController,
                                  validator: validateMobile,
                                  keyboardType: TextInputType.number,
                                  length: 10,
                                  readOnly: true,
                                  enable: false,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      controller.mobileController.text;
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        Map<String, String> mapData = {
                                          'name':
                                              controller.nameController.text,
                                          'phone':
                                              controller.mobileController.text,
                                          'email':
                                              controller.emailController.text,
                                        };
                                        editUserProfileRepo(
                                                context: context,
                                                mapData: mapData,
                                                fieldName1: "profile_image",
                                                file1: controller.image.value)
                                            .then((value) {
                                          showToast(value.message);
                                          if (value.status == true) {
                                            controller.getData();
                                          } else {
                                            showToast(value.message);
                                          }
                                        });
                                      } else {}
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(10),
                                        backgroundColor: AppTheme.primaryColor,
                                        minimumSize:
                                            const Size(double.maxFinite, 50),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    child: Text(
                                      "UPDATE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: AppTheme.backgroundcolor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font16),
                                    )),
                                SizedBox(
                                  height: AddSize.size20,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ));
      }),
    );
  }
}
