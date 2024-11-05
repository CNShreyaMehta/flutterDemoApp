// ignore_for_file: camel_case_types

import 'package:demo_app/presentation/controllers/on_boarding_controller.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/constants/image_strings.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                title: "Select Your Game",
                description: "Pick from classic or timed modes and start your Sudoku journey.",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuLightBlue,
                image: TImages.onBoardingScreenTwo,
                title: "Choose Your Difficulty",
                description:
                    "From easy to expert, select a level that matches your skill.",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuPrimaryBlue,
                image: TImages.onBoardingScreenThree,
                title:
                    "View Your Game History",
                description:
                    "Monitor your progress, review completed puzzles, and improve over time.",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuLightBlue,
                image: TImages.onBoardingScreenFour,
                title:
                    "Time to Play!",
                description:
                    "Tap a cell to select it, then choose a number to fill it in. The timer at the top keeps track of your speed.",
              ),
              commonOnboardingWidget(
                size: size,
                bgColor: TColors.sudokuPrimaryBlue,
                image: TImages.onBoardingScreenFive,
                title:
                    "Congratulations!",
                description:
                    "You’ve completed the puzzle! Challenge yourself with the next one or try a harder level!.",
              ),
            ]),
        Positioned(
          bottom: size.height * 12 / 100,
          child: OutlinedButton(
            onPressed:   () {
              //Get.offNamed(AppRoutes.login);
              //OnBoardingController.instance.skipPage();
              //OnBoardingController.instance.nextPage();
              OnBoardingController.instance.completeOnboarding();
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
            top: 35,
            right: 15,
            child: TextButton(
              onPressed: () { OnBoardingController.instance.skipPage(); } ,
              // () {
              //   Get.offNamed(AppRoutes.gamesHome);
              // }
              
              child: const Text("Skip",
                  style: TextStyle(
                    color: TColors.sudokuDarkBlue,
                    decoration: TextDecoration.underline, // Underline the text
                    decorationColor:
                        TColors.sudokuDarkBlue, // Set the underline color to black
                    decorationThickness:
                        1.0, // Optional: Set the thickness of the underline
                  )),
            )),
        Positioned(
          bottom: size.height * 0.05,
          child: SmoothPageIndicator(
            count: 5,
            controller: dotController.pageController,
            onDotClicked: controller.dotNavigationClicked,
            effect: ExpandingDotsEffect(
              activeDotColor: isDark ? TColors.sudokuDarkBlue : TColors.sudokuDarkBlue,
              dotColor: Colors.grey,
              dotHeight: 8,
              dotWidth: 25,
              spacing: 10,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
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
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           SizedBox(
            height: size.height * 0.05,
          ),
          Image(
            image: AssetImage(image),
            height: size.height * 0.5,
            width: size.width * 0.8,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style:  GoogleFonts.dynaPuff(fontSize: 26, color: Colors.white ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style:  GoogleFonts.dynaPuff(fontSize: 14,color:Colors.white ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
