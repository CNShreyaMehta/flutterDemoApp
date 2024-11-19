import 'package:demo_app/presentation/controllers/login_controller.dart';
import 'package:demo_app/presentation/controllers/sudoku_result.dart';
import 'package:demo_app/presentation/routes/app_pages.dart';
import 'package:demo_app/presentation/screens/home_screen.dart';
import 'package:demo_app/presentation/screens/login_screen.dart';
import 'package:demo_app/presentation/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LoginController authController = Get.put(LoginController());

  final SudokuResult showCaseController =
      Get.put(SudokuResult());

        final SudokuResult timerControllerMain = Get.put(SudokuResult());
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  print("didChangeDependencies in ROOT my_app >>>");
}
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      // onFinish: () {
      //   //print('ShowCaseWidget on finish');
        
      // },
       onComplete: (index, key) {
            if (index == 2) {
              print('>>>>>>>>>>>>>>');
              showCaseController.completeShowCaseWidget();
              timerControllerMain.startTimer(timerControllerMain.firstGameLevel);  //timerControllerMain.firstGameLevel.value
            }
          },
      builder: (context) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Example App',
      initialRoute: AppPages.beforeAuthentication,
      getPages: AppPages.routes,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: authController.checkAuthToken(), // Check token on app startup
        builder: (context, snapshot) {
          // Show a loading indicator while token is being checked
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // If logged in, show Home screen, otherwise show Login screen
          return Obx(() => authController.isLoggedIn.value
              ? const HomeScreen()
              : const LoginScreen());  //SplashScreen()
        },
      ),
            ),
    );
  }
}