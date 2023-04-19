import 'package:localization/localization.dart';

import '../resources/app_assets.dart';

class OnBoardModelResponse {
  final String? image, title, description;

  OnBoardModelResponse({
    this.image,
    this.title,
    this.description,
  });
}

List<OnBoardModelResponse> OnBoardingData = [
  OnBoardModelResponse(
      image: AppAssets.ONB1,
      title: "You first",
      description:
      "We don’t charge you order fees. We don’t spy on you. We just help you enjoy your meals"),
  OnBoardModelResponse(
      image: AppAssets.ONB2,
      title: "Beautifully-designed\n menus",
      description:
      "Every menu item is manually reviewed by our team"),
  OnBoardModelResponse(
      image: AppAssets.ONB3,
      title: "Unbeatable rates",
      description:
      "We don’t charge any order fees. Delivery fees go where they belong."),
];
