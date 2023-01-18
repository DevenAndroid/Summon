import '../resources/app_assets.dart';

class DashBoardDataResponse {
  final String? image, title, description;

  DashBoardDataResponse({
    this.image,
    this.title,
    this.description,
  });
}

List<DashBoardDataResponse> OnBoardData = [
  DashBoardDataResponse(
      image: AppAssets.onboarding1,
      title: "Best quality grocery at your doorstep!",
      description:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
  DashBoardDataResponse(
      image: AppAssets.onboarding3,
      title: "Peace of mind same day delivery guaranteed!",
      description:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
  DashBoardDataResponse(
      image: AppAssets.onboarding3,
      title: "Big savings with seasonal discounts all products",
      description:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
];
