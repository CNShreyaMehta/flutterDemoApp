import 'package:demo_app/presentation/controllers/sudoku_result.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameResult extends StatefulWidget {
  const GameResult({super.key});

  @override
  State<GameResult> createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {
  String resultsText = "Loading results...";
  final SudokuResult _sudokuResult =
      SudokuResult(difficultyLevel: '', score: 0, timeStamp: '');
  List<SudokuResult> results = [];

  @override
  void initState() {
    super.initState();
    _fetchSudokuResults();
  }

  // Load results from SharedPreferences
  Future<void> _fetchSudokuResults() async {
    List<SudokuResult> fetchedResults = await _sudokuResult.getSudokuResults();
    setState(() {
      results = fetchedResults;
    });
  }

  // Mapping difficulty levels to emojis
  String _getEmojiForDifficulty(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return '😊'; // Smiley for easy
      case 'Medium':
        return '😅'; // Smiling face with sweat for medium
      case 'Hard':
        return '😱'; // Scared for expert
      default:
        return '🤔'; // Thinking for unknown difficulty
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Game Result',
          style: GoogleFonts.dynaPuff(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: isDark ? TColors.sudocuDark : TColors.sudocuLight,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: results.isEmpty
          ? Center(
              child: Text(
                "No results found",
                style: GoogleFonts.poppins(
                    color: TColors.sudokuDarkBlue,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Container(
              color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  String emoji = _getEmojiForDifficulty(result.difficultyLevel);

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: TColors.sudokuDarkBlue.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 24)),
                         
                        ],
                      ),
                      onTap: () {},
                      title: Text(
                        "Difficulty Level : ${result.difficultyLevel}",
                        style: GoogleFonts.dynaPuff(
                            color: TColors.sudokuDarkBlue,
                            ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Play Time : ${(result.score ~/ 60)}:${(result.score % 60).toString().padLeft(2, '0')} mm:ss",
                            style: GoogleFonts.dynaPuff(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Date : ${result.timeStamp}",
                            style: GoogleFonts.dynaPuff(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
