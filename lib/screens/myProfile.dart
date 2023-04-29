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
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Obx(() {
        return controller.isDataLoading.value &&
                controller.model.value.data != null
            ?
        Column(
          children: [
            Expanded(
              child: Stack(
                    children: [
                      Positioned(
                          top: -height * .02,
                          left:  width* .24,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(

                                image: DecorationImage(
                                    image: AssetImage(AppAssets.profileIcon1)
                                )
                            ),
                          )),
                      Positioned(
                          top:  -height * .01,
                          left: -width * .05,
                          child: Container(
                            height: 150,
                            width: 140,
                            decoration: BoxDecoration(

                                image: DecorationImage(
                                    image: AssetImage(AppAssets.profileIcon2)
                                )
                            ),
                          )),
                      Positioned(
                          top: -height * .08,
                          right: -width * .04,
                          child: Container(
                            height: 285,
                            width: 180,
                            decoration: BoxDecoration(

                                image: DecorationImage(
                                    image: AssetImage(AppAssets.profileIcon3)
                                )
                            ),
                          )),
                      Positioned(
                          top: height * .11,
                          //bottom: 10,
                          left: width * .35,
                          //right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffF45D28),
                            ),
                            height: 120,
                            width: 120,
                            child: CircleAvatar(
                                backgroundColor: Color(0xffF45D28),
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
                                )),
                          )),
                      Positioned(
                          right: width * .38,
                          top: height * .20,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(

                              //color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  showUploadWindow();
                                },
                                child: const Image(
                                    height: 45,
                                    width: 45,
                                    image: AssetImage(
                                        AppAssets.cameraImage)),
                              ),
                            ),
                          )),
                      Positioned(
                          right: width * .4,
                          top: height * .25,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white,width: 3),
                              shape: BoxShape.circle,
                              color: AppTheme.primaryColor

                                ),
                          )),

                      Positioned.fill(
                        top: height * .25,
                        child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Form(
                          key: _formKey,
                          child: Container(
                             //color: Color(0xffF9F9F9),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                  ],
                                ),
                                SizedBox(height: height* .02,),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              //color: AppTheme.backgroundcolor,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Text(
                                                  "First name",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: AddSize.font14,color: Color(0xff828282)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                EditProfileTextFieldWidget(
                                                  hint: "Enter Your Fist Name",
                                                  controller: controller.firstNameController,
                                                  validator: validateName,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  "Last name",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: AddSize.font14,color: Color(0xff828282)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                EditProfileTextFieldWidget(
                                                  hint: "Enter Your Last Name",
                                                  controller: controller.lastNameController,
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
                                                      fontSize: AddSize.font14,color: Color(0xff828282)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                EditProfileTextFieldWidget(
                                                  hint: "Enter Your Email",
                                                  controller: controller.emailController,
                                                  readOnly: true,
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
                                                      fontSize: AddSize.font14,color: Color(0xff828282)),
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
                                                          'first_name':
                                                          controller.firstNameController.text,
                                                          'last_name':
                                                          controller.lastNameController.text,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ),)
                    ],
                  ),
            ),

          ],
        )
            : const Center(
                child:
                CircularProgressIndicator(
                color: AppTheme.primaryColor,
              )
        );
      }),
    );
  }
}
