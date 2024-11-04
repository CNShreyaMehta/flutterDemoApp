import 'package:demo_app/presentation/screens/games/sudoku/difficulty_level_screen.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class GameWinScreen extends StatefulWidget {
  const GameWinScreen({super.key});

  @override
  State<GameWinScreen> createState() => _GameWinScreenState();
}

class _GameWinScreenState extends State<GameWinScreen> {
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String difficultyLevelText = '';
  int difficultyLevelNumber = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the confetti controller with an indefinite duration
    _confettiController = ConfettiController(duration: const Duration(seconds: 50));
    _confettiController.play();

    // Play success audio
    _playSuccessMusic();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      difficultyLevelText = arguments['difficultyLevel'];
      difficultyLevelNumber = arguments['score'];

      print('args.score>>><<<> ${difficultyLevelText ?? 'No score available'}');
    }
  }

  void _playSuccessMusic() async {
    await _audioPlayer.play('assets/audio/success.mp3', isLocal: true);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose(); // Dispose the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: isDark ? TColors.sudokuDarkBlue : TColors.sudocuLight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Text(
                            'Congratulation!',
                            style: GoogleFonts.dynaPuff(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? TColors.sudokuDarkBlue
                                  : TColors.sudocuLight,
                            ),
                          ),
                          Text(
                            '🏆',
                            style: TextStyle(fontSize: 50),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'You Won!',
                            style: GoogleFonts.dynaPuff(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? TColors.sudokuDarkBlue
                                  : TColors.sudocuLight,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            
                            'Game Won in ${(difficultyLevelNumber ~/ 60)}:${(difficultyLevelNumber % 60).toString().padLeft(2, '0')} mm:ss', // Access score here
                            style: GoogleFonts.dynaPuff(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: isDark
                                  ? TColors.sudokuDarkBlue
                                  : TColors.sudocuLight,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DifficultyLevelScreen(),
                                ),
                                (Route<dynamic> route) => false, // This removes all previous routes
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDark
                                    ? TColors.sudokuDarkBlue
                                    : TColors.sudocuLight,
                              ),
                            ),
                            child: Text(
                              'Go to Main',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? TColors.sudokuDarkBlue
                                    : TColors.sudocuLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Full-screen confetti animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Direction is downward
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              gravity: 0.2, // Control how fast confetti falls
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.red,
                Colors.lightBlue,
              ], // Colors of the confetti
              numberOfParticles: 60, // Adjust this for more/less confetti
            ),
          ),
        ],
      ),
    );
  }
}
