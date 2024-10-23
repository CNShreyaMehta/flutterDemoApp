import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SudokuScreen(),
    );
  }
}

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>> gridData = [];
  List<List<int>> gridDataSolved = [];
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    gridData = generateSudoku();
  }

  List<List<int>> generateSudoku() {
    List<List<int>> grid = List.generate(9, (_) => List.generate(9, (_) => 0));
    solveSudoku(grid);

    const int difficulty = 40;
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
    return grid;
  }

  bool solveSudoku(List<List<int>> grid) {
    final emptyCell = findEmptyCell(grid);

    if (emptyCell == null) {
      return true; // Puzzle solved
    }

    final int row = emptyCell['row'] ?? 0; // Use ?? to handle null values
    final int col = emptyCell['col'] ?? 0; // Use ?? to handle null values

    for (int num = 1; num <= 9; num++) {
      if (isValidMove(grid, row, col, num)) {
        grid[row][col] = num;

        if (solveSudoku(grid)) {
          return true;
        }

        grid[row][col] = 0; // Backtrack
      }
    }

    return false; // No solution found
  }

  Map<String, int>? findEmptyCell(List<List<int>> grid) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (grid[i][j] == 0) {
          return {'row': i, 'col': j};
        }
      }
    }
    return null; // No empty cell found
  }

  bool isValidMove(List<List<int>> grid, int row, int col, int num) {
    // Check if num is already in the row
    for (int i = 0; i < 9; i++) {
      if (grid[row][i] == num) {
        return false;
      }
    }

    // Check if num is already in the column
    for (int i = 0; i < 9; i++) {
      if (grid[i][col] == num) {
        return false;
      }
    }

    // Check if num is already in the 3x3 block
    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    // Row
    for (int i = startRow; i < startRow + 3; i++) {
      // Coloum
      for (int j = startCol; j < startCol + 3; j++) {
        if (grid[i][j] == num) {
          return false;
        }
      }
    }

    return true;
  }

  bool isSeparator(int rowIndex, int colIndex) {
    return (colIndex == 2 || colIndex == 5) && rowIndex != 2 && rowIndex != 5;
  }

  void reSetValue() {
    setState(() {
      gridData = generateSudoku();
    });
  }

  void solveData() {
    setState(() {
      solveSudoku(gridData);
      gridDataSolved = gridData;
    });
  }

  Row buildRow(List<String?> texts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: texts.map((text) => NumberBox(text: text)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: gridData.map((row) {
                  int rowIndex = gridData.indexOf(row);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((col) {
                      print('$col');
                      int colIndex = row.indexOf(col);
                      return col == 0
                          ? InkWell(
                              onTap: () {
                                print('${rowIndex}, ${colIndex}');
                                setState(() {
                                  isClicked = !isClicked;  
                                });
                                print(isClicked);
                              },
                              hoverColor: Colors.blue,
                              splashColor: Colors.yellow,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: isClicked ? Colors.yellow : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  col != 0 ? '$col' : '',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          : Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                col != 0 ? '$col' : '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              //color: Colors.blue,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRow(['1', '2', '3']),
                    const SizedBox(height: 10),
                    buildRow(['4', '5', '6']),
                    const SizedBox(height: 10),
                    buildRow(['7', '8', '9']),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              //color: Colors.blue,
              //height: 100,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: solveData,
                    child: const Text("Solve"),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: reSetValue,
                    child: const Text("Reset"),
                  ),
                ],
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

  const NumberBox({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('tapped');
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: text != null
            ? Text(
                text!,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              )
            : null,
      ),
    );
  }
}
