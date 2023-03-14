import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import '../widgets/editprofile_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static var editProfileScreen = "/editProfileScreen";
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: backAppBar(title: "Edit Profile", context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                                      image: AssetImage(AppAssets.profileImage),
                                      fit: BoxFit.cover)),
                              height: 112,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Williams Jones",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: AddSize.font16),
                            ),
                            Text(
                              '',
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
                                    color: Colors.white,
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv00m-RB7TtdPHzzer0T4rTkqkbEkmov0wUg&usqp=CAU',
                                    height: 150,
                                    width: 100,
                                    errorWidget: (_, __, ___) =>
                                        const SizedBox(),
                                    placeholder: (_, __) => const SizedBox(),
                                  )))),
                      Positioned(
                          right: 125,
                          top: 90,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: AppTheme.backgroundcolor),
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Image(
                                  height: 10,
                                  width: 15,
                                  image: AssetImage(AppAssets.camaraImage)),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                            hint: "Williams Jones",
                            controller: nameController,
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
                            hint: "williamsjones@gmail.com",
                            controller: emailController,
                            // validator: MultiValidator([
                            //   RequiredValidator(
                            //       errorText: 'Please Enter Email'),
                            //   EmailValidator(
                            //       errorText: 'Enter a valid email address')
                            // ]),
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
                            hint: "+91-9251272491",
                            controller: mobileController,
                            validator: validateMobile,
                            keyboardType: TextInputType.number,
                            length: 10,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) ;
                                // Get.toNamed(MyRouter.editProfileScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  minimumSize: const Size(double.maxFinite, 50),
                                  primary: AppTheme.primaryColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
