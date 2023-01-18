import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);
  static var orderDetailsScreen = "/orderDetailsScreen";
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with SingleTickerProviderStateMixin {
  bool value = false;
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar(title: "Order Details", context: context),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16, vertical: AddSize.padding10),
                child: Column(
                  children: [
                    Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding15,
                              vertical: AddSize.padding15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const ImageIcon(
                                          AssetImage(AppAssets.orderList),
                                          color: AppTheme.primaryColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: AddSize.size15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order ID: #258147",
                                              style: TextStyle(
                                                  color: AppTheme.primaryColor,
                                                  fontSize: AddSize.font16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "Monday, 2 June, 2021",
                                              style: TextStyle(
                                                  color: AppTheme.blackcolor,
                                                  fontSize: AddSize.font12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppTheme.primaryColor),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .04,
                                              vertical: height * .005),
                                          child: Text(
                                            "Successful",
                                            style: TextStyle(
                                                fontSize: AddSize.font14,
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ))
                                  ]),
                              SizedBox(
                                height: height * .02,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      orderList("Coriander Leaves And Greens",
                                          "₹10.00", "5Kg * 3"),
                                      SizedBox(
                                        height: height * .005,
                                      ),
                                      index != 2 ? const Divider() : SizedBox(),
                                      SizedBox(
                                        height: height * .005,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: AddSize.size14,
                    ),
                    Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * .005),
                          child: TabBar(
                            physics: const BouncingScrollPhysics(),
                            unselectedLabelColor: AppTheme.blackcolor,
                            labelColor: AppTheme.backgroundcolor,
                            tabs: const [
                              Tab(
                                child: Text(
                                  "Driver  Detail",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Store Information",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                            labelStyle: const TextStyle(
                                color: AppTheme.blackcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            unselectedLabelStyle: const TextStyle(
                                color: AppTheme.blackcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            controller: tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          controller: tabController,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                ),
                child: Column(
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding15,
                              vertical: AddSize.padding15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Diver Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: AppTheme.lightblack,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AddSize.font14),
                                        ),
                                        Text(
                                          "Rajesh Sharma",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AddSize.font16),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Container(
                                    height: AddSize.size45,
                                    width: AddSize.size45,
                                    decoration: const ShapeDecoration(
                                        color: Colors.orange,
                                        shape: CircleBorder()),
                                    child: Center(
                                        child: Icon(
                                      Icons.person_rounded,
                                      color: AppTheme.backgroundcolor,
                                    )),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Driver Number",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: AppTheme.lightblack,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AddSize.font14),
                                        ),
                                        Text(
                                          "+91 9876454321",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AddSize.font16),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Container(
                                      height: AddSize.size45,
                                      width: AddSize.size45,
                                      decoration: const ShapeDecoration(
                                          color: AppTheme.primaryColor,
                                          shape: CircleBorder()),
                                      child: Center(
                                          child: Icon(
                                        Icons.phone,
                                        color: AppTheme.backgroundcolor,
                                      ))),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delivery Address",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: AppTheme.lightblack,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AddSize.font14),
                                        ),
                                        Text(
                                          "Douglas, Cork, T16 XN73, uk",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AddSize.font16),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Container(
                                    height: AddSize.size45,
                                    width: AddSize.size45,
                                    decoration: const ShapeDecoration(
                                        color: AppTheme.lightYellow,
                                        shape: CircleBorder()),
                                    child: Center(
                                        child: Icon(
                                      Icons.location_on,
                                      color: AppTheme.backgroundcolor,
                                    )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    paymentDetails()
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AddSize.padding16),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: AppTheme.backgroundcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding15,
                              vertical: AddSize.padding15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Store Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: AppTheme.lightblack,
                                              fontWeight: FontWeight.w400,
                                              fontSize: AddSize.font14),
                                    ),
                                    Text(
                                      "Store abcd@3125A#",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font16),
                                    ),
                                  ],
                                ),
                              ]),
                              Container(
                                height: AddSize.size45,
                                width: AddSize.size45,
                                decoration: const ShapeDecoration(
                                    color: AppTheme.primaryColor,
                                    shape: CircleBorder()),
                                child: Center(
                                    child: Image(
                                  image: AssetImage(AppAssets.store1Icon),
                                  height: AddSize.size20,
                                  width: AddSize.size20,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      paymentDetails()
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AddSize.padding16, vertical: AddSize.padding16),
        child: ElevatedButton(
            onPressed: () {
              // Get.toNamed(MyRouter.editProfileScreen);
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                minimumSize: Size(double.maxFinite, AddSize.size50),
                primary: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: TextStyle(
                    fontSize: AddSize.font18, fontWeight: FontWeight.w600)),
            child: Text(
              "Mark Delivered",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppTheme.backgroundcolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            )),
      ),
    );
  }

  orderList(name, price, qty) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: AddSize.font16,
                      color: AppTheme.blackcolor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                    fontSize: AddSize.font16,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .01,
        ),
        Text(
          qty,
          style: TextStyle(
              fontSize: AddSize.font14,
              color: AppTheme.lightblack,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  paymentDetails() {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding15, vertical: AddSize.padding15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                details("Subtotal:", "₹30.30"),
                SizedBox(
                  height: AddSize.size5,
                ),
                details("Tax & fee:", "₹5.00"),
                SizedBox(
                  height: AddSize.size5,
                ),
                details("Delivery:", "Free"),
                SizedBox(
                  height: AddSize.size5,
                ),
                details("Packing fee:", "Free"),
                SizedBox(
                  height: AddSize.size5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500)),
                    Text("₹40.00",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: AddSize.font14,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: AddSize.size5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Get.toNamed(MyRouter.editProfileScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(AddSize.size50, AddSize.size30),
                          primary: AppTheme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          "COD",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: AppTheme.backgroundcolor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font14),
                        )),
                  ],
                )
              ],
            )));
  }

  details(title, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: AppTheme.blackcolor,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500)),
        Text(price,
            style: TextStyle(
                color: Colors.grey,
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
