import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DifficultyLevelScreen extends StatefulWidget {
  const DifficultyLevelScreen({super.key});

  @override
  State<DifficultyLevelScreen> createState() => _DifficultyLevelScreenState();
}

class _DifficultyLevelScreenState extends State<DifficultyLevelScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Difficulty Level',
            style: GoogleFonts.dynaPuff(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
          backgroundColor: isDark ? TColors.sudocuDark : TColors.sudocuLight,
          iconTheme: const IconThemeData(color: Colors.white), // Set back arrow color to white
          centerTitle: false,
      ),
      body: Container(
        color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sudoku', arguments: {
                    'text': 'Easy',
                    'number': 80,
                  });
                },
                text: 'Easy'),
            const SizedBox(height: 20),
            GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sudoku', arguments: {
                    'text': 'Medium',
                    'number': 20,
                  });
                },
                text: 'Medium'),
            const SizedBox(height: 20),
            GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sudoku', arguments: {
                    'text': 'Hard',
                    'number': 10,
                  });
                },
                text: 'Hard'),
          ],
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: !isDark
                  ? [Colors.blue, const Color.fromARGB(255, 0, 47, 255)]
                  : [
                      const Color.fromARGB(255, 255, 255, 255),
                      const Color.fromARGB(255, 106, 133, 255)
                    ],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.transparent, // Makes the button background transparent
              shadowColor: Colors.transparent, // Hides default button shadow
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed,
            child: Text(text,
                style: GoogleFonts.dynaPuff(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: !isDark ? Colors.white : TColors.sudokuDarkBlue)),
          ),
        ),
      ),
    );
  }
}
