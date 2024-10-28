// ignore_for_file: camel_case_types

import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/constants/image_strings.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
   const OnBoardingScreen({super.key});

  static BuildContext? get context => null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = THeplerFunction.isDarkMode(context);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        LiquidSwipe(
            slideIconWidget: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 30,
            ),
            enableSideReveal: true,
            pages: [
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuPrimaryBlue,
                image: TImages.onBoardingScreenOne,
                title: "Welcome to Game Zone",
                description: "In this course, you will learn Flutter",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuLightBlue,
                image: TImages.onBoardingScreenTwo,
                title: "Flutter is a cross-platform",
                description:
                    "Flutter is Google's UI toolkit",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuPrimaryBlue,
                image: TImages.onBoardingScreenThree,
                title:
                    "Flutter is Google's UI",
                description:
                    "Flutter is Google's UI toolkit",
              ),
            ]),
        Positioned(
          bottom: 80,
          child: OutlinedButton(
            onPressed: () {
              Get.offNamed(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: isDark ? Colors.black : TColors.sudokuDarkBlue),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios, color:  Colors.white ),
            ),
          ),
        ),
        Positioned(
            top: 50,
            right: 30,
            child: TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.gamesHome);
              },
              child: const Text("Skip",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline, // Underline the text
                    decorationColor:
                        Colors.black, // Set the underline color to black
                    decorationThickness:
                        1.0, // Optional: Set the thickness of the underline
                  )),
            )),
        Positioned(
          bottom: 40,
          child: SmoothPageIndicator(
            count: 4,
            controller: PageController(),
            effect: ExpandingDotsEffect(
              activeDotColor: isDark ? TColors.sudokuDarkBlue : TColors.sudokuMediumBlue,
              dotColor: TColors.sudokuLightBlue,
              dotHeight: 15,
              dotWidth: 20,
              spacing: 10,
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    ));
  }
}

class commonOnboardingWidget extends StatelessWidget {
  const commonOnboardingWidget({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.description,
    required this.bgColor,
  });

  final Size size;
  final String image, title, description;

  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);
    return Container(
      padding:  const EdgeInsets.all(30),
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(image),
            height: size.height * 0.4,
          ),
          Column(
            children: [
              Text(
                title,
                style:  TextStyle(fontSize: 22, color: isDark ? Colors.white : Colors.black,fontWeight: FontWeight.w500),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style:  TextStyle(fontSize: 12,color: isDark ? Colors.white : Colors.black),
              ),
              // const Text(
              //   "2/3",
              //   style: TextStyle(fontSize: 20),
              // ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
