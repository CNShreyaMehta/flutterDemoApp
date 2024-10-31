import 'dart:convert'; // For JSON encoding and decoding

import 'package:shared_preferences/shared_preferences.dart';

class SudokuResult {
  final String difficultyLevel;
  final int score;
  final String timeStamp;

  SudokuResult({
    required this.difficultyLevel,
    required this.score,
    required this.timeStamp,
  });

  // Convert SudokuResult object to a Map for JSON encoding
  Map<String, dynamic> toMap() {
    return {
      'difficulty_level': difficultyLevel,
      'score': score,
      'time_stamp': timeStamp,
    };
  }

  // Create a SudokuResult object from a Map (for decoding JSON)
  factory SudokuResult.fromMap(Map<String, dynamic> map) {
    return SudokuResult(
      difficultyLevel: map['difficulty_level'],
      score: map['score'],
      timeStamp: map['time_stamp'],
    );
  }

  // Add the SudokuResult object to SharedPreferences
  Future<void> addSudokuResult(SudokuResult result) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve the existing list
  List<String> existingResults = prefs.getStringList('sudoku_result') ?? [];

  // Convert the new result object to JSON and add it to the list
  existingResults.add(jsonEncode(result.toMap()));

  // Save the updated list to SharedPreferences
  await prefs.setStringList('sudoku_result', existingResults);
}

  // Get the list of SudokuResult objects
  Future<List<SudokuResult>> getSudokuResults() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the stored list of JSON strings
  List<String> savedResults = prefs.getStringList('sudoku_result') ?? [];

  // Decode each JSON string and convert it to a SudokuResult object
  List<SudokuResult> results = savedResults
      .map((result) => SudokuResult.fromMap(jsonDecode(result)))
      .toList();
  return results;
}

}