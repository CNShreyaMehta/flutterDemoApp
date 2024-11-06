import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart'; // Import confetti package
import 'package:demo_app/presentation/controllers/sudoku_result.dart';
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen>
    with TickerProviderStateMixin {
  List<Map<String, int>> undoStack = []; // Stack to track moves for undo
  List<List<int>> gridData = [];
  List<List<bool>> fixedCells = [];
  int? selectedRow;
  int? selectedCol;
  bool gameWon = false; // Track if the game has been won
  bool _hasStarted = false;
  late ConfettiController _confettiController; // Confetti controller
  final List<AnimationController> _balloonControllers =
      []; // Controllers for multiple balloons
  final List<Animation<double>> _balloonAnimations =
      []; // Animations for multiple balloons
  Timer? _timer;
  int _elapsedTime = 0; // Time in seconds
  bool _isRunning = false;
  //late String difficultyLevel;
  String difficultyLevelText = '';
  int difficultyLevelNumber = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    difficultyLevelText = arguments['text'];
    difficultyLevelNumber = arguments['number'];
    // Retrieve the arguments passed from the previous screen
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is String) {
      difficultyLevelText = args; // Cast to String
    } else if (args is int) {
      difficultyLevelNumber = args; // Cast to int
    }
    gridData = generateSudoku(difficultyLevelNumber);

    print(difficultyLevelText);
    print(difficultyLevelNumber);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Are you sure you want to go back?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // No
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Yes
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false; // Return false if dialog is dismissed
  }

  @override
  void initState() {
    super.initState();
    _startTimer();

    _confettiController = ConfettiController(
        duration: const Duration(seconds: 5)); // Initialize confetti controller

    // Create multiple balloons
    for (int i = 0; i < 15; i++) {
      // Adjust the number of balloons here
      AnimationController controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 6),
      );

      Animation<double> animation =
          Tween<double>(begin: 1.5, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut, // Smooth out the animation
      ));

      _balloonControllers.add(controller);
      _balloonAnimations.add(animation);
    }

    //gridData = generateSudoku(difficultyLevelNumber);
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Dispose confetti controller
    for (var controller in _balloonControllers) {
      controller.dispose(); // Dispose each balloon controller
    }
    _timer?.cancel();

    super.dispose();
  }

  void undoLastMove() {
    if (undoStack.isNotEmpty) {
      final lastMove = undoStack.removeLast();
      setState(() {
        gridData[lastMove['row']!][lastMove['col']!] = 0;
        selectedRow = lastMove['row'];
        selectedCol = lastMove['col'];
      });
    }
  }

  List<List<int>> generateSudoku(dynamic a) {
    List<List<int>> grid = List.generate(9, (_) => List.generate(9, (_) => 0));
    solveSudoku(grid);
    print("inside func >> $a, $difficultyLevelText");
    int difficulty = a;
    int remainingCells = 81 - difficulty;
    Random random = Random();
    while (remainingCells > 0) {
      int row = random.nextInt(9);
      int col = random.nextInt(9);
      if (grid[row][col] != 0) {
        grid[row][col] = 0;
        remainingCells--;
      }
    }

    fixedCells =
        List.generate(9, (i) => List.generate(9, (j) => grid[i][j] != 0));

    return grid;
  }

  bool solveSudoku(List<List<int>> grid) {
    final emptyCell = findEmptyCell(grid);
    if (emptyCell == null) return true;

    final int row = emptyCell['row'] ?? 0;
    final int col = emptyCell['col'] ?? 0;

    for (int num = 1; num <= 9; num++) {
      if (isValidMove(grid, row, col, num)) {
        grid[row][col] = num;

        if (solveSudoku(grid)) {
          return true;
        }
        grid[row][col] = 0;
      }
    }
    return false;
  }

  Map<String, int>? findEmptyCell(List<List<int>> grid) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (grid[i][j] == 0) {
          return {'row': i, 'col': j};
        }
      }
    }
    return null;
  }

  bool isValidMove(List<List<int>> grid, int row, int col, int num) {
    for (int i = 0; i < 9; i++) {
      if (grid[row][i] == num || grid[i][col] == num) {
        return false;
      }
    }

    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    for (int i = startRow; i < startRow + 3; i++) {
      for (int j = startCol; j < startCol + 3; j++) {
        if (grid[i][j] == num) {
          return false;
        }
      }
    }
    return true;
  }

  void resetValue() {
    final isDark = THeplerFunction.isDarkMode(context);
    setState(() {
      _timer?.cancel();
      _isRunning = false;
      _elapsedTime = 0;
      gridData = generateSudoku(difficultyLevelNumber);
      selectedRow = null;
      selectedCol = null;
      gameWon = false;
      _hasStarted = false; // Reset hasStarted to false
    });
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Your game is restart!',
          style: TextStyle(
              color: TColors.sudokuDarkBlue,
              fontWeight: FontWeight.w500,
              fontSize: 20), // Set text color to black
        ),
        backgroundColor: Colors.white, // Set background color to green
      ),
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Confirm Exit'),
    //       content: const Text('Are you sure you want to reset the game?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(false), // No
    //           child: const Text('No'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop(true); // Yes
    //             setState(() {
    //               _timer?.cancel();
    //               _isRunning = false;
    //               _elapsedTime = 0;
    //               gridData = generateSudoku(difficultyLevelNumber);
    //               selectedRow = null;
    //               selectedCol = null;
    //               gameWon = false;
    //             });
    //             _startTimer();
    //           },
    //           child: const Text('Yes'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void solveData() {
    if (_timer != null) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
      });
    }
    setState(() {
      solveSudoku(gridData);
      _isRunning = false;
      checkGameWon();
    });
  }

  void checkGameWon() {
    bool isComplete = true;
    // Check if any cell is empty
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (gridData[i][j] == 0) {
          isComplete = false;
          break;
        }
      }
    }
    // If complete, trigger confetti and balloon animations
    if (isComplete) {
      setState(() async {
        gameWon = true;
        // _confettiController.play();
        for (int i = 0; i < 5; i++) {
          Future.delayed(Duration(seconds: i), () {
            _confettiController.play();
          });
        }
        // Start balloon animations
        for (var controller in _balloonControllers) {
          controller.forward();
        }
        _stopTimer(); // Stop the timer
        // Create a sample result
        SudokuResult newResult = SudokuResult(
          difficultyLevel: difficultyLevelText,
          score: _elapsedTime,
          timeStamp: DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.now()),
        );
        // Save the result to SharedPreferences
        await newResult.addSudokuResult(newResult);
        // Wait for 2 seconds before navigating
        await Future.delayed(const Duration(seconds: 3), () {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/gameWin', arguments: {
            'difficultyLevel': difficultyLevelText,
            'score': _elapsedTime,
            'timeStamp': DateTime.now().toString(),
          });
        });
      });
    }
  }

// set list to shared preference local storage
  static Future<void> saveList(String key, List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, list);
  }

  // get list from shared preference local storage
  static Future<List<String>?> getList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  Row buildRow(List<String?> texts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: texts.map((text) {
        return NumberBox(
          text: text,
          onTap: () {
            if (selectedRow != null &&
                selectedCol != null &&
                gridData[selectedRow!][selectedCol!] == 0) {
              int numberToPlace = int.parse(text!);

              if (isValidMove(
                  gridData, selectedRow!, selectedCol!, numberToPlace)) {
                setState(() {
                  gridData[selectedRow!][selectedCol!] = numberToPlace;
                  undoStack.add({'row': selectedRow!, 'col': selectedCol!});
                  selectedRow = null;
                  selectedCol = null;
                  checkGameWon();
                  _hasStarted =
                      true; // Enable restart button after first cell click
                });
//FIXME
                if (gridData[0][0] != 0) {}
                // if() check empty grid data or not if not then call solveddata anomation
              } else {
                // Optionally, you can show a message or visual feedback for invalid moves
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Invalid Move!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20), // Set text color to black
                    ),
                    backgroundColor: Color.fromARGB(
                        255, 255, 0, 0), // Set background color to green
                  ),
                );
              }
            }
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);
    // ignore: deprecated_member_use

    return Scaffold(
      appBar: AppBar(
        title: Text(
          difficultyLevelText,
          style: GoogleFonts.dynaPuff(
            fontSize: 25,
            //fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        //centerTitle: true, // Center the title
        backgroundColor: isDark ? TColors.sudocuDark : TColors.sudocuLight,
        automaticallyImplyLeading: false, // back button hidden

        iconTheme: const IconThemeData(
            color: Colors.white), // Set back arrow color to white
        actions: [
          Text(
            _formatTime(_elapsedTime),
            style: GoogleFonts.dynaPuff(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          // RESOLVE GAME Button
          // IconButton(
          //   icon: const Icon(Icons.slow_motion_video),
          //   onPressed: solveData,
          // ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
          IconButton.filledTonal(
            tooltip: 'Undo your last input',
            iconSize: 25,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white, // Set your desired color here
            ),
            icon: const Icon(Icons.undo),
            color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
            // onPressed: resetValue,
            onPressed: _hasStarted
                ? undoLastMove
                : null, // Disable when _hasStarted is false
          ),
          IconButton.filledTonal(
            color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
            iconSize: 25,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white, // Set your desired color here
            ),
            tooltip: 'You can reset your game!',
            icon: const Icon(Icons.refresh),
            // onPressed: resetValue,
            onPressed: _hasStarted
                ? resetValue
                : null, // Disable when _hasStarted is false
          )
        ],
      ),
      body: Container(
        color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    //   const Text(
                    //     'Total Time: ',
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    //   Text(
                    //     _formatTime(_elapsedTime),
                    //     style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                    //   ),
                    // ]),
                    const SizedBox(height: 10),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          //   BoxShadow(
                          //  color: isDark ? const Color.fromARGB(255, 136, 134, 134) : TColors.sudokuDarkBlue.withOpacity(0.3),
                          //     spreadRadius: isDark ? 1 : 1,
                          //     blurRadius: isDark ? 10 : 12,
                          //     offset: const Offset(0, 3), // changes position of shadow
                          //   ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          children: gridData.map((row) {
                            int rowIndex = gridData.indexOf(row);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: row.asMap().entries.map((entry) {
                                int colIndex = entry.key;
                                int colValue = entry.value;

                                bool isSelected = (selectedRow == rowIndex &&
                                    selectedCol == colIndex);
                                bool isFixed = fixedCells[rowIndex][colIndex];

                                return InkWell(
                                  onTap: colValue > 0
                                      ? null
                                      : () {
                                          if (!isFixed) {
                                            // _stopTimer();
                                            setState(() {
                                              selectedRow = rowIndex;
                                              selectedCol = colIndex;
                                            });
                                          }
                                        },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: .8, left: .8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: .4, color: Colors.black),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        )),
                                    child: Container(
                                      width: 38.8,
                                      height: 38.8,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            width: .8,
                                            color: !isDark
                                                ? TColors.sudokuLightBlue
                                                : TColors.sudokuDarkBlue),
                                        color: isSelected
                                            ? (!isDark
                                                ? TColors.sudokuLightBlue
                                                : TColors.sudokuDarkBlue)
                                            : (colValue == 0
                                                ? (isDark
                                                    ? TColors.sudokuLightBlue
                                                    : TColors.sudokuDarkBlue)
                                                : (isFixed
                                                    ? const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    : const Color.fromARGB(
                                                        232, 123, 239, 168))),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        colValue > 0 ? '$colValue' : '',
                                        style: GoogleFonts.dynaPuff(
                                          fontSize: 18,
                                          color: isDark
                                              ? TColors.sudokuDarkBlue
                                              : TColors.sudocuLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildRow(['1', '2', '3']),
                            const SizedBox(height: 15),
                            buildRow(['4', '5', '6']),
                            const SizedBox(height: 15),
                            buildRow(['7', '8', '9']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Confetti animation widget
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
      ),
    );
  }
}

class NumberBox extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;

  const NumberBox({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = THeplerFunction.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.height *
            0.07, // A, // Adjust the percentage as needed
        height: MediaQuery.of(context).size.height * 0.07, // A
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(
                  255, 136, 134, 134), // Shadow color with opacity
              spreadRadius: 1, // Spread radius of shadow
              blurRadius: 10, // Blur effect to make the shadow softer
              offset:
                  Offset(0, 2), // Offset the shadow to the bottom (x: 0, y: 4)
            ),
          ],
        ),
        child: Text(
          text ?? '',
          style: GoogleFonts.dynaPuff(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDark ? TColors.sudocuDark : TColors.sudocuLight,
          ),
        ),
      ),
    );
  }
}
