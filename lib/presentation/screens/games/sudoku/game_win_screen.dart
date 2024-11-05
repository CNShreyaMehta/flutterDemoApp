import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:demo_app/presentation/screens/games/sudoku/difficulty_level_screen.dart';
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
  late ConfettiController _confettiController;
  late AudioPlayer _audioPlayer;

  String difficultyLevelText = '';
  int difficultyLevelNumber = 0;
  String gameStatus = ''; // This can be either 'win' or 'loss'

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 50));
    _audioPlayer = AudioPlayer();

    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      difficultyLevelText = arguments['difficultyLevel'];
      difficultyLevelNumber = arguments['score'];
      gameStatus = arguments['gameStatus'] ?? 'win'; // Set based on the passed argument
    }

    if (gameStatus == 'win') {
      _confettiController.play();
      _playSuccessMusic();
    }else if(gameStatus == 'loss'){
      _playlossMusic();
    }

  }

  Future<void> _playSuccessMusic() async {
    try {
      _audioPlayer.setReleaseMode(ReleaseMode.stop);
      await _audioPlayer.setSource(AssetSource('audio/success.mp3'));
      await _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }
  Future<void> _playlossMusic() async {
    try {
      _audioPlayer.setReleaseMode(ReleaseMode.stop);
      await _audioPlayer.setSource(AssetSource('audio/wrong.mp3'));
      await _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
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
                            gameStatus == 'win' ? 'Congratulations!' : 'Game Over',
                            style: GoogleFonts.dynaPuff(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: 
                              gameStatus == 'win' ?
                              isDark
                                  ? TColors.sudokuDarkBlue
                                  : TColors.sudocuLight
                                  : Colors.red,
                            ),
                          ),
                          Text(
                            gameStatus == 'win' ? '🏆' : '😢',
                            style: const TextStyle(fontSize: 50),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            gameStatus == 'win' ? 'You Won!' : 'Better luck next time!',
                            style: GoogleFonts.dynaPuff(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? TColors.sudokuDarkBlue
                                  : TColors.sudocuLight,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (gameStatus == 'win')
                            Text(
                              'Game Won in ${(difficultyLevelNumber ~/ 60)}:${(difficultyLevelNumber % 60).toString().padLeft(2, '0')} mm:ss',
                              style: GoogleFonts.dynaPuff(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: isDark
                                    ? TColors.sudokuDarkBlue
                                    : TColors.sudocuLight,
                              ),
                            ),
                          const SizedBox(height: 20),
                          if (gameStatus == 'win')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (index) => const Icon(
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
                                (Route<dynamic> route) => false,
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
          if (gameStatus == 'win')
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                gravity: 0.2,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                  Colors.red,
                  Colors.lightBlue,
                ],
                numberOfParticles: 60,
              ),
            ),
        ],
      ),
    );
  }
}
