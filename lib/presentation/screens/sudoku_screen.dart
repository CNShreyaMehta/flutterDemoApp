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
  List<List<int>> gridDataSolved = [];

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

  void solData() {
    setState(() {
      solveSudoku(gridData);
      gridDataSolved = gridData;
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
            Container(
              color: Colors.blue,
              height: 100,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: solData,
                    child: const Text("Solve"),
                  ),
                  ElevatedButton(
                    onPressed: reSetValue,
                    child: const Text("Reset"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: gridData.map((row) {
                    int rowIndex = gridData.indexOf(row);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((cell) {
                        int colIndex = row.indexOf(cell);
                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            cell != 0 ? '$cell' : '',
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
