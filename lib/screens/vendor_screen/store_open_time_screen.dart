import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';

class SetTimeScreen extends StatefulWidget {
  const SetTimeScreen({Key? key}) : super(key: key);
  static var setTimeScreen = "/setTimeScreen";

  @override
  State<SetTimeScreen> createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  // bool isAvailable = false;
  TimeOfDay? result = TimeOfDay.now();
  TimeOfDay? result1 = TimeOfDay.now();
  RxString time = "--:--".obs, time1 = "--:--".obs;
  final RxList<bool> isAvailable = <bool>[].obs;

  Future<void> displayOpenTimeDialog(int index) async {
    result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      time.value = result!.format(context);
    }
  }

  Future<void> displayCloseTimeDialog(int index) async {
    result1 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      time1.value = result1!.format(context);
    }
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 7; i++) {
      isAvailable.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundcolor,
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(78.0), // here the desired height
            child: backAppBar(title: "Set Store Time", context: context)),
        body: Obx(() {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  ...List.generate(
                      7,
                      (index) => Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: isAvailable[index] == true
                                        ? AppTheme.primaryColor
                                        : AppTheme.greycolor)),
                            child: Theme(
                              data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              child: CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: AppTheme.primaryColor,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(
                                  ("Mon").capitalizeFirst!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppTheme.lightblack,
                                          fontSize: AddSize.font14),
                                ),
                                value: isAvailable[index],
                                onChanged: (value) {
                                  isAvailable[index] = value!;
                                  setState(() {});
                                },
                                secondary: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (isAvailable[index] == true) {
                                              displayOpenTimeDialog(index);
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AddSize.padding10,
                                                vertical: AddSize.padding10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  time.value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppTheme
                                                              .lightblack,
                                                          fontSize:
                                                              AddSize.font14),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  color: AppTheme.lightblack,
                                                )
                                              ],
                                            ),
                                          )),
                                      const Spacer(),
                                      Text(
                                        "To",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppTheme.lightblack,
                                                fontSize: AddSize.font14),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          if (isAvailable[index] == true) {
                                            displayCloseTimeDialog(index);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding10,
                                              vertical: AddSize.padding10),
                                          child: Row(
                                            children: [
                                              Text(
                                                time1.value.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppTheme.lightblack,
                                                        fontSize:
                                                            AddSize.font14),
                                              ),
                                              const Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: AppTheme.lightblack,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                  SizedBox(
                    height: AddSize.size40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          minimumSize: Size(double.maxFinite, AddSize.size50),
                          primary: AppTheme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: TextStyle(
                              fontSize: AddSize.font18,
                              fontWeight: FontWeight.w600)),
                      child: Text(
                        "Save".toUpperCase(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppTheme.backgroundcolor,
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font18),
                      )),
                ],
              ),
            ),
          );
        }));
  }
}
