import 'package:demo_app/presentation/constants/colors.dart';
import 'package:demo_app/presentation/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  static BuildContext? get context => null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              Container(
                color: onboardingColorOne,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: const AssetImage(onBoardingScreenOne),
                      height: size.height * 0.4,
                    ),
                    const Column(
                      children: [
                        Text(
                          "Welcome to Flutter Learning Path",
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 40, right: 40,),
                          child: Text(
                            "Let's start with the basics of Flutter & Dart Language, and learn how to build apps with Flutter.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          
                        ),
                         Text(
                      "2/3",
                      style: TextStyle(fontSize: 20),
                    ),
                      ],
                    ),
                    
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Container(color: onboardingColorTwo),
              Container(color: onboardingColorThree),
            ]),
        Positioned(
          bottom: 60,
          child: OutlinedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Colors.black),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ),
        ),
        Positioned(
            top: 50,
            right: 30,
            child: TextButton(
              onPressed: () {},
              child: const Text("Skip", style: TextStyle(color: Colors.black)),
            )),
        const Positioned(
          bottom: 30,
          child: AnimatedSmoothIndicator(activeIndex: 1, count: 4),
        ),
        const SizedBox( height: 60,),
      ],
    ));
  }
}
