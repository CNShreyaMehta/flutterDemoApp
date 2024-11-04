import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameWinScreen extends StatefulWidget {
  const GameWinScreen({super.key});

  @override
  State<GameWinScreen> createState() => _GameWinScreenState();
}

class _GameWinScreenState extends State<GameWinScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);

    return Scaffold(
        body: Container(
      color: !isDark ? TColors.sudokuDarkBlue : TColors.sudocuLight,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You won!',
            style: GoogleFonts.dynaPuff(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: isDark ? TColors.sudokuDarkBlue : TColors.sudocuLight,
            ),
          ),
          Text('Game Win in 100 seconds',
              style: GoogleFonts.dynaPuff(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: isDark ? TColors.sudokuDarkBlue : TColors.sudocuLight,
              )),
          const SizedBox(height: 30),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/difficultyLevel');
            },
            child: Text('Continue',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? TColors.sudokuDarkBlue : TColors.sudocuLight,
                )),
          )
        ],
      )),
    ));
  }
}
