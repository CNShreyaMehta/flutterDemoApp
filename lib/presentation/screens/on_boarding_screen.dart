// ignore_for_file: camel_case_types

import 'package:demo_app/presentation/controllers/on_boarding_controller.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/constants/image_strings.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});
  static BuildContext? get context => null;
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final isDark = THeplerFunction.isDarkMode(context);
    final controller = Get.put(OnBoardingController());
    final dotController = OnBoardingController.instance;
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        PageView(
            controller: controller.pageController,
            onPageChanged: controller.updateCurrentIndex,
            children: [
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuPrimaryBlue,
                image: TImages.onBoardingScreenOne,
                title: "Welcome to Game Zone",
                description: "In this place, you will find all the games you need",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuLightBlue,
                image: TImages.onBoardingScreenTwo,
                title: "Interactive Games",
                description:
                    "Games that can be played in real time",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuPrimaryBlue,
                image: TImages.onBoardingScreenThree,
                title:
                    "Play with your Friends",
                description:
                    "keep track of your scores and win prizes",
              ),
            ]),
        Positioned(
          bottom: 80,
          child: OutlinedButton(
            onPressed:   () {
              //Get.offNamed(AppRoutes.login);
              OnBoardingController.instance.skipPage();
              OnBoardingController.instance.nextPage();
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: isDark ? Colors.black : TColors.sudokuDarkBlue),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: TColors.sudokuDarkBlue,
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
              onPressed: () { OnBoardingController.instance.skipPage(); } ,
              // () {
              //   Get.offNamed(AppRoutes.gamesHome);
              // }
              
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
            count: 3,
            controller: dotController.pageController,
            onDotClicked: controller.dotNavigationClicked,
            effect: ExpandingDotsEffect(
              activeDotColor: isDark ? TColors.sudokuDarkBlue : TColors.sudokuDarkBlue,
              dotColor: Colors.grey,
              dotHeight: 10,
              dotWidth: 30,
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
