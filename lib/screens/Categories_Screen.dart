import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';

import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.white,
          appBar:  AppBar(
            backgroundColor: Color(0xffFFFFFF),
            elevation: 0,
            leadingWidth: AddSize.size80,
            leading: Padding(
              padding: EdgeInsets.only(left: 33,right: 20),
              child: GestureDetector(
                child: Image.asset(
                  AppAssets.BACKICON,
                  height: AddSize.size30,
                ),
                onTap: () {

                },
              ),
            ),
            centerTitle: false,
            title: Text("Category", style: TextStyle(
                color: Color(0xff423E5E),
                fontWeight: FontWeight.w600,
                fontSize: 20),)


          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            //physics: ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding15),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .02,
                  ),
                  SizedBox(
                    height: height * .07,
                    child: TextField(
                      maxLines: 3,

                      // controller:
                      // homeSearchController.searchController,
                      style: const TextStyle(fontSize: 17),
                     // textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) => {},
                      decoration: InputDecoration(
                          filled: true,

                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8))),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: width * .05,vertical: height * .03),
                          hintText: 'Search Category',
                          hintStyle: TextStyle(
                              fontSize: AddSize.font14,
                              color: Color(0xff8990A7),
                              fontWeight: FontWeight.w400),
                          suffixIcon: IconButton(
                          onPressed: () {
                      // Get.to(const SearchScreenData());

                    },
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xff8990A7),
                        size: 30,
                      ),
                    ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                      itemCount: 10,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 10.0),
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Container(
                                height: 150,
                                width: 190,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  image: DecorationImage(
                                    image: AssetImage(AppAssets.foodIMG,),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                            ),
                            Column(
                              children: [
                                Text("Chinese Hut Fast Food And Biryani",
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Color(0xff08141B)),),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text("15 SR • 25 mins •",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff2C4D61)),),
                                    SizedBox(width: 3,),
                                    Text("★4.5",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffFE724C)),),
                                  ],
                                ),
                              ],
                            ),

                          ],
                        );

                  }),
                  SizedBox(
                    height: height * .03,
                  ),
                ],
              ),
            ),
          )


      ),
    );
  }

}
