import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/notification_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'Language_Change_Screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static var notificationScreen = "/notificationScreen";
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
          appBar: backAppBar(title: "Notification".tr, context: context),
          body: Obx(() {
  return controller.isDataLoading.value ? controller.model.value.data!.notificationData!.isNotEmpty ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * .01),
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: controller.model.value.data!.notificationData!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return notificationList(
                            controller.model.value.data!.notificationData![index].time.toString(),
                            controller.model.value.data!.notificationData![index].title.toString(),
                          controller.model.value.data!.notificationData![index].body.toString());
                      })
                ],
              ),
            ),
          ):Padding(
            padding: EdgeInsets.only(top: AddSize.padding20 * 2,left: AddSize.padding20 * 5),
            child: Text("Notification Not Available".tr),
          ):const Center(child: CircularProgressIndicator(),);
})),
    );
  }

  Widget notificationList(date, title, description) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        elevation: 0,
        child: Row(
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .005,
              ),
              child: Container(
                width: width * .010,
                height: height * .08,
                decoration:  BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(.80),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.03,
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 8, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date,
                      style: GoogleFonts.ibmPlexSansArabic(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                            fontSize: 14,
                          ),
                    ),
                    addHeight(4),
                    Text(
                      title,
                      style: GoogleFonts.ibmPlexSansArabic(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff2A3757),
                            fontSize: 14,
                          ),
                    ),
                    //textBold(snapshot.data!.data.notifications[index].title),
                    addHeight(4),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.ibmPlexSansArabic(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff797F8F),
                            fontSize: 12,
                          ),
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
// return loader(context);
}
//);
// }
//}
