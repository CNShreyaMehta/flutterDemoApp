import 'package:demo_app/presentation/controllers/splash_controller.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());
  bool animated = false;
  @override
  void initState() {
    super.initState();
    startAnimation();
  }
  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);


    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                TColors.sudokuDarkBlue,
                TColors.sudokuMediumBlue,
                TColors.sudokuPrimaryBlue,
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.4, 0.7, 1.0],
            ),
          ),
      //color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
          child: Stack(children: [
                AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animated ? 0 : -30,
            left: animated ? 0 : -20,
            child: Image.asset(
              "assets/images/purple-shape.png",
              height: MediaQuery.of(context).size.height * 0.20,
            )),
                //SizedBox( height: 50, ),
                AnimatedPositioned(
          duration: const Duration(milliseconds: 1600),
          top: 130,
          left: animated ? 20 : -80,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1600),
            opacity: animated ? 1 : 0,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 10,),
              Text(
                "Welcome",
                style: GoogleFonts.dynaPuff(
              fontSize: 40, color: Colors.white),
              ),
               Text(
                "to",
                style: GoogleFonts.dynaPuff(
              fontSize: 25, color: Colors.white),
              ),
               Text(
                "Game Zone",
                style:GoogleFonts.dynaPuff(
              fontSize: 25,color: Colors.white),
              )
            ]),
          ),
                ),
                AnimatedPositioned(
          duration: const Duration(milliseconds: 2600),
          top: 290,
          left: 50,
          //height: 100,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1600),
            opacity: animated ? 1 : 0,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/happy-boy.png",
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                
              ],
            ),
          ),
                ),
                AnimatedPositioned(
          duration: const Duration(milliseconds: 1600),
          bottom: animated ? 0 : -50,
          right: animated ? -60 : -100,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Image.asset(
            "assets/images/brown-solid-color.png",
          ),
                ),
              ]),
        ));
  }
  
  Future startAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      animated = true;
    });

  }
}
