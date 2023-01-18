import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/dimensions.dart';
import 'app_theme.dart';
postingShimmer() {
  return Container(
    decoration:
    BoxDecoration(boxShadow: blurBoxShadow, color: AppTheme.primaryColor),
    width: AddSize.screenWidth,
    margin: EdgeInsets.only(bottom: AddSize.size15),
    padding: EdgeInsets.all(AddSize.size15),
    child: Column(
      children: [
        SizedBox(height: AddSize.size10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: AddSize.size10),
                child: buildShimmerCircle(size: AddSize.size30*2.2)
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmer(
                    width: AddSize.screenWidth * .48,
                    height: AddSize.font18,
                  ),
                  SizedBox(height: AddSize.size12),
                  buildShimmer(
                    width: AddSize.screenWidth * .42,
                    height: AddSize.font12,
                  ),
                  SizedBox(height: AddSize.size14),
                  buildShimmer(
                    width: AddSize.screenWidth * .2,
                    height: AddSize.font12,
                  ),
                  SizedBox(height: AddSize.size10),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AddSize.size20),
        buildShimmer(
          width: AddSize.screenWidth*.75,
          height: AddSize.font12,
        ),
        SizedBox(height: AddSize.size10),
        buildShimmer(
          width: AddSize.screenWidth*.75,
          height: AddSize.font12,
        ),
        SizedBox(height: AddSize.size10),
      ],
    ),
  );
}

buildShimmer({
  required height,
  required width,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.white,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: Colors.white),
    ),
  );
}

buildShimmerCircle({
  required size,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.white,
    child: Container(
      width: size,
      height: size,
      decoration:
      const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    ),
  );
}