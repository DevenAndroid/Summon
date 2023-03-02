import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controller/SetStoreTIme_Controller.dart';
import '../../repositories/Updated_StoreTime_Repo.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';

class SetTimeScreen extends StatefulWidget {
  const SetTimeScreen({Key? key}) : super(key: key);
  static var setTimeScreen = "/setTimeScreen";

  @override
  State<SetTimeScreen> createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  final setStoreTimeController = Get.put(SetStoreTimeControlller());

  Future<void> displayOpenTimeDialog(int index) async {
    TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateFormat("hh:mm")
            .parse(setStoreTimeController.model.value.data![index].startTime)),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        setStoreTimeController.model.value.data![index].startTime =
            result.format(context);
        // time.value = result!.format(context);
      });
    } else {
      return;
    }
  }

  Future<void> displayCloseTimeDialog(int index) async {
    TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateFormat("hh:mm")
            .parse(setStoreTimeController.model.value.data![index].endTime)),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        setStoreTimeController.model.value.data![index].endTime =
            result.format(context);
        // time.value = result!.format(context);
      });
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setStoreTimeController.getSetStoreTime();
    });
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
          return setStoreTimeController.isDataLoading.value
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        ...List.generate(
                            setStoreTimeController.model.value.data!.length,
                            (index) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: setStoreTimeController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .status ==
                                                  true
                                              ? AppTheme.primaryColor
                                              : AppTheme.greycolor)),
                                  child: Theme(
                                    data: ThemeData(
                                        checkboxTheme: CheckboxThemeData(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)))),
                                    child:
                                        buildCheckboxListTile(index, context),
                                  ),
                                )),
                        SizedBox(
                          height: AddSize.size40,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              updatedSetStoreTimeRepo(
                                  setStoreTimeController.model.value.data!);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10),
                                minimumSize:
                                    Size(double.maxFinite, AddSize.size50),
                                primary: AppTheme.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                textStyle: TextStyle(
                                    fontSize: AddSize.font18,
                                    fontWeight: FontWeight.w600)),
                            child: Text(
                              "Save".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: AppTheme.backgroundcolor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AddSize.font18),
                            )),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        }));
  }

  CheckboxListTile buildCheckboxListTile(int index, BuildContext context) {
    return CheckboxListTile(
      checkColor: Colors.white,
      activeColor: AppTheme.primaryColor,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        (setStoreTimeController.model.value.data![index].weekDay!
                .substring(0, 3)
                .toString())
            .capitalizeFirst!,
        style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w400,
            color: AppTheme.lightblack,
            fontSize: AddSize.font14),
      ),
      value: setStoreTimeController.model.value.data![index].status!,
      onChanged: (value) {
        setStoreTimeController.model.value.data![index].status = value!;
        setState(() {});
      },
      secondary: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  if (setStoreTimeController.model.value.data![index].status ==
                      true) {
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
                        setStoreTimeController
                            .model.value.data![index].startTime
                            .toString(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.lightblack,
                            fontSize: AddSize.font14),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppTheme.lightblack,
                      )
                    ],
                  ),
                )),
            const Spacer(),
            Text(
              "To",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppTheme.lightblack,
                  fontSize: AddSize.font14),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (setStoreTimeController.model.value.data![index].status ==
                    true) {
                  displayCloseTimeDialog(index);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding10, vertical: AddSize.padding10),
                child: Row(
                  children: [
                    Text(
                      setStoreTimeController.model.value.data![index].endTime
                          .toString(),
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppTheme.lightblack,
                          fontSize: AddSize.font14),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: AppTheme.lightblack,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
