import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>> gridData = [];
  int? selectedRow;
  int? selectedCol;

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
    if (emptyCell == null) return true; // Puzzle solved

    final int row = emptyCell['row'] ?? 0;
    final int col = emptyCell['col'] ?? 0;

    for (int num = 1; num <= 9; num++) {
      if (isValidMove(grid, row, col, num)) {
        grid[row][col] = num;

        if (solveSudoku(grid)) {
          return true;
        }

        grid[row][col] = 0; // Backtrack
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
    return null; // No empty cell found
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
      gridData = generateSudoku();
      selectedRow = null;
      selectedCol = null;
    });
  }

  void solveData() {
    setState(() {
      solveSudoku(gridData);
    });
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
                    children: row.asMap().entries.map((entry) {
                      int colIndex = entry.key;
                      int colValue = entry.value;

                      bool isSelected =
                          (selectedRow == rowIndex && selectedCol == colIndex);
                      bool isHighlighted = selectedRow != null &&
                          gridData[selectedRow!][colIndex] == 0;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedRow = rowIndex;
                            selectedCol = colIndex;

                            // Toggle the state of the clicked cell
                            if (gridData[selectedRow!][selectedCol!] == 0) 
                            {
                              gridData[selectedRow!][selectedCol!] = -1; // Highlight the clicked empty cell
                            } else if (gridData[selectedRow!][selectedCol!] == -1) {
                              gridData[selectedRow!][selectedCol!] = 0; // Reset highlighted cell back to original
                            }
                            // No need to reset other cells since we want to allow multiple selections
                          });
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
                                    : (colValue == -1
                                        ? Colors.red // Highlighted empty cell
                                        : const Color.fromARGB(
                                            232, 219, 205, 205))),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            colValue > 0 ? '$colValue' : '',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: solveData,
                  child: const Text("Solve"),
                ),
                OutlinedButton(
                  onPressed: resetValue,
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
