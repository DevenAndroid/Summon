import '../resources/app_assets.dart';

class OnBoardModelResponse {
  final String? image, title, description;

  OnBoardModelResponse({
    this.image,
    this.title,
    this.description,
  });
}

List<OnBoardModelResponse> OnBoardData = [
  OnBoardModelResponse(
      image: AppAssets.onboarding1,
      title: "Best quality grocery\nat your doorstep!",
      description:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
  OnBoardModelResponse(
      image: AppAssets.onboarding2,
      title: "Peace of mind same day\ndelivery guaranteed!",
      description:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
  OnBoardModelResponse(
      image: AppAssets.onboarding3,
      title: "Big savings with seasonal\ndiscounts all products",
      description:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
];
