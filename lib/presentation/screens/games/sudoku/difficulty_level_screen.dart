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
    return  Scaffold(
      appBar: AppBar(
        title:  Text('Sudoku Difficulty Level',style:GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('Select Level!', style:GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),),
            const SizedBox(height: 10),
            GradientButton( onPressed: () {
              Navigator.pushNamed(context, '/sudoku',arguments: 'Easy');
            }, text: 'Easy'),
              const SizedBox(height: 20),
              GradientButton( onPressed: () {
              Navigator.pushNamed(context, '/sudoku',arguments: 'Medium');
            }, text: 'Medium'),
              const SizedBox(height: 20),
              GradientButton( onPressed: () {
              Navigator.pushNamed(context, '/sudoku',arguments: 'Hard');
            }, text: 'Hard'),
          ],),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
final VoidCallback onPressed;
  final String text;

  const GradientButton({super.key,
  required this.onPressed,
    required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 0, 47, 255)],
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
            backgroundColor: Colors.transparent, // Makes the button background transparent
            shadowColor: Colors.transparent, // Hides default button shadow
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
          child:  Text(text,
            style:GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)
          ),
        ),
      ),
    );
  }
}