import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart'; // Import confetti package
import 'package:flutter/material.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen>
    with TickerProviderStateMixin {
  List<List<int>> gridData = [];
  List<List<bool>> fixedCells = [];
  int? selectedRow;
  int? selectedCol;
  bool gameWon = false; // Track if the game has been won
  late ConfettiController _confettiController; // Confetti controller
  final List<AnimationController> _balloonControllers =
      []; // Controllers for multiple balloons
  final List<Animation<double>> _balloonAnimations =
      []; // Animations for multiple balloons
  Timer? _timer;
  int _elapsedTime = 0; // Time in seconds
  bool _isRunning = false;
  late String difficultyLevel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the arguments passed from the previous screen
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is String) {
      difficultyLevel = args; // Cast to String
    }
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
    )) ?? false; // Return false if dialog is dismissed
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

    gridData = generateSudoku();
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

  List<List<int>> generateSudoku() {
    List<List<int>> grid = List.generate(9, (_) => List.generate(9, (_) => 0));
    solveSudoku(grid);

    const int difficulty = 78;
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
    setState(() {
      _timer!.cancel();
      _isRunning = false;
      _elapsedTime = 0;
      gridData = generateSudoku();
      selectedRow = null;
      selectedCol = null;
      gameWon = false;
    });
    setState(() {
      _startTimer();
    });
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
      setState(() {
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
      });
    }
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
                  selectedRow = null;
                  selectedCol = null;
                  checkGameWon();
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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () { return _onWillPop(); },
      child: Scaffold(
        appBar: AppBar(
          title:  Text(difficultyLevel),
          centerTitle: true, // Center the title
      
          backgroundColor: const Color.fromARGB(
              255, 210, 235, 247), // Set the background color to blue
          actions: [
            IconButton(
              icon: const Icon(Icons.slow_motion_video),
              onPressed: solveData,
            ),
            IconButton(
              icon: const Icon(Icons.restore),
              onPressed: resetValue,
            )
          ],
        ),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        'Total Time: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        _formatTime(_elapsedTime),
                        style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                      ),
                    ]),
                    Center(
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
                                          _stopTimer();
                                          setState(() {
                                            selectedRow = rowIndex;
                                            selectedCol = colIndex;
                                          });
                                        }
                                      },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: isSelected
                                        ? Colors.blue
                                        : (colValue == 0
                                            ? Colors.white
                                            : (isFixed
                                                ? const Color.fromARGB(
                                                    255, 197, 196, 196)
                                                : const Color.fromARGB(
                                                    232, 123, 239, 168))),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    colValue > 0 ? '$colValue' : '',
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                    //FIXME box with be round with shadow and color
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
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
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       OutlinedButton(
                    //         style: OutlinedButton.styleFrom(
                    //           foregroundColor: Colors.black,
                    //           side: const BorderSide(color: Colors.black),
                    //           padding: const EdgeInsets.symmetric(
                    //               vertical: 10, horizontal: 30),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           textStyle: const TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //             fontFamily: 'Poppins',
                    //           ),
                    //           backgroundColor: Colors.white,
                    //         ),
                    //         onPressed: solveData,
                    //         child: const Text("Solve"),
                    //       ),
                    //       const SizedBox(width: 20),
                    //       OutlinedButton(
                    //         style: OutlinedButton.styleFrom(
                    //           foregroundColor: Colors.black,
                    //           side: const BorderSide(color: Colors.black),
                    //           padding: const EdgeInsets.symmetric(
                    //               vertical: 10, horizontal: 30),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           textStyle: const TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //             fontFamily: 'Poppins',
                    //           ),
                    //           backgroundColor: Colors.white,
                    //         ),
                    //         onPressed: resetValue,
                    //         child: const Text("Reset"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.18, // Adjust the percentage as needed
        height: MediaQuery.of(context).size.height * 0.08, // A
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color with opacity
              spreadRadius: 3, // Spread radius of shadow
              blurRadius: 4, // Blur effect to make the shadow softer
              offset: const Offset(
                  0, 4), // Offset the shadow to the bottom (x: 0, y: 4)
            ),
          ],
        ),
        child: Text(
          text ?? '',
          style: const TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}