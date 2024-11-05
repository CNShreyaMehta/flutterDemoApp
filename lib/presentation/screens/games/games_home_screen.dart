import 'package:demo_app/presentation/controllers/Theme_controller.dart';
import 'package:demo_app/presentation/custom_widgets/custom_card.dart';
import 'package:demo_app/presentation/screens/games/sudoku/difficulty_level_screen.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GamesHomeScreen extends StatelessWidget {
  const GamesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);
    final ThemeController themeController =
        Get.put(ThemeController()); // Initialize the controller

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Brain Block',
          style: GoogleFonts.dynaPuff(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: isDark ? TColors.sudocuDark : TColors.sudocuLight,
        iconTheme: const IconThemeData(
            color: Colors.white), // Set back arrow color to white
        actions: [
          IconButton(
            icon: !isDark
                ? const Icon(
                    Icons.light_mode_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.dark_mode_outlined,
                  ),
                              iconSize: 30,

            onPressed: () {
              themeController.toggleTheme();
            },
          )
        ],
      ),
      body: Container(
        color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const game2048()),
            //     );
            //   },
            //   child: Column(
            //     children: [
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(5),
            //         child: Image.asset(
            //           height: MediaQuery.of(context).size.height * 0.15,
            //           width: MediaQuery.of(context).size.width * 0.3,
            //           'assets/images/2048_bg.png', // Replace with your image path
            //           fit: BoxFit.cover, // Ensures the image fills the area
            //         ),
            //       ),
            //       Text(
            //         '2048',
            //         style: GoogleFonts.dynaPuff(
            //             fontSize: 22,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.black),
            //       ),
            //     ],
            //   ),
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               const DifficultyLevelScreen()), //SudokuScreen
            //     );
            //   },
            //   child: Center(
            //     child: Column(
            //       children: [
            //         ClipRRect(
            //           borderRadius: BorderRadius.circular(10),
            //           child: Image.asset(
            //             width: MediaQuery.of(context).size.width * 0.3,
            //             height: MediaQuery.of(context).size.height * 0.15,

            //             'assets/images/sudoku_bg.jpeg', // Replace with your image path
            //             fit: BoxFit.cover, // Ensures the image fills the area
            //           ),
            //         ),
            //         Text(
            //           'Sudoku',
            //           style: GoogleFonts.dynaPuff(
            //               fontSize: 22,
            //               fontWeight: FontWeight.w400,
            //               color: Colors.black),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
           CustomCard(
          imageUrl:
              'assets/images/sudoku.png',
          title: 'Sudoku Game',
          subtitle: 'Solve Sudoku Puzzles',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DifficultyLevelScreen(),
              ),
            );
          },
        ),
            CustomCard(
          imageUrl:
              'assets/images/2048.png',
          title: '2048',
          subtitle: 'Solve 2048 Puzzles',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Game is coming soon!',
          style: TextStyle(
              color: TColors.sudokuDarkBlue,
              fontWeight: FontWeight.w500,
              fontSize: 20), // Set text color to black
        ),
        backgroundColor: Colors.white, // Set background color to green
      ),
    );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const game2048(),
            //   ),
            // );
            // AlertDialog(
            //       title: Text('Alert'),
            //       content: Text('This is a simple alert dialog.'),
            //       actions: [
            //         TextButton(
            //           child: Text('OK'),
            //           onPressed: () {
            //             Navigator.of(context).pop(); // Close the dialog
            //           },
            //         ),
            //       ],
            //     );
          },
        ),
          ],
        ),
      ),
    );
  }
}
