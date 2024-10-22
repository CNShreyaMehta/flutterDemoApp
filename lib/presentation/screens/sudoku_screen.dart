import 'dart:math';

import 'package:flutter/material.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>> _puzzle = [];
  List<List<int>> _solution = [];
  int _selectedRow = -1;
  int _selectedCol = -1;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
  }

  void _generatePuzzle() {
    // Generate a new Sudoku puzzle using an existing library or algorithm
    // For simplicity, we'll just generate a random puzzle here
    var rng = Random();
    _solution =
        List.generate(3, (_) => List.generate(3, (_) => rng.nextInt(3) + 1));
    _puzzle = List.generate(3, (_) => List.generate(3, (_) => 0));
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (rng.nextDouble() < 0.5) {
          _puzzle[i][j] = _solution[i][j];
        }
      }
    }
  }

  void _checkComplete() {
    print("_checkComplete");
    // Check if the puzzle is complete
    _isComplete = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_puzzle[i][j] == 0) {
          _isComplete = false;
          return;
        }
        if (_puzzle[i][j] != _solution[i][j]) {
          _isComplete = false;
        }
      }
    }
  }

  void _selectCell(int row, int col) {
    setState(() {
      _selectedRow = row;
      _selectedCol = col;
    });
  }

  void _enterNumber(int number) {
    if (_selectedRow != -1 && _selectedCol != -1) {
      setState(() {
        _puzzle[_selectedRow][_selectedCol] = number;
        _checkComplete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () {
                    _selectCell(row, col);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      color: _selectedRow == row && _selectedCol == col
                          ? Colors.yellow
                          : Colors.white,
                    ),
                    child: Text(
                      _puzzle[row][col] == 0
                          ? ''
                          : _puzzle[row][col].toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _puzzle[row][col] == _solution[row][col]
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 13),
          _isComplete
              ? const Text(
                  'Congratulations! You solved the puzzle!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 13),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildNumberButton(1),
                  _buildNumberButton(2),
                  _buildNumberButton(3),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildNumberButton(4),
                  _buildNumberButton(5),
                  _buildNumberButton(6),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildNumberButton(7),
                  _buildNumberButton(8),
                  _buildNumberButton(9),
                ],
              ),
            ],
          ),
          const SizedBox(height: 13),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              //backgroundColor: Colors.blue,
              shape: const StadiumBorder(),
              foregroundColor: Colors.blue,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              side: const BorderSide(color: Colors.blue, width: 2),
            ),
            child: const Text('New Game'),
            onPressed: () {
              setState(() {
                _generatePuzzle();
                _selectedRow = -1;
                _selectedCol = -1;
                _isComplete = false;
              });
            },
          ),
          const SizedBox(height: 13),
        ],
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(13),
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        side: const BorderSide(color: Colors.blue, width: 2),
      ),
      child: Text(number.toString()),
      onPressed: () {
        _enterNumber(number);
      },
    );
  }
}
