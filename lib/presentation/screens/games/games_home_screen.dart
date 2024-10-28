import 'package:demo_app/presentation/controllers/Theme_controller.dart';
import 'package:demo_app/presentation/screens/games/2048/game_2048.dart';
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
          'Games',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        backgroundColor: TColors.sudokuPrimaryBlue,
        actions: [
          IconButton(
            icon: isDark
                ? const Icon(
                    Icons.light_mode_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.black,
                  ),
            onPressed: () {
              themeController.toggleTheme();
            },
          )
        ],
      ),
      body: Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const game2048()),
            );
          },
          child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 246, 150),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Center(
                child: Text(
                  '2048',
                 style:GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: isDark ? TColors.sudokuDarkBlue : Colors.black),
                ),
              )),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const DifficultyLevelScreen()), //SudokuScreen
            );
          },
          child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 144, 234, 175),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Center(
                child: Text(
                  'Sudoku',
                  style:GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: isDark ? TColors.sudokuDarkBlue : Colors.black),
                ),
              )),
        )
      ])),
    );
  }
}
