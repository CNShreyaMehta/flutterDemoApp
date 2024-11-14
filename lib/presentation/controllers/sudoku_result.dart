import 'dart:async';
import 'dart:convert'; // For JSON encoding and decoding

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SudokuResult extends GetxController {
  static SudokuResult get instance => Get.find();
   RxInt elapsedTime = 0.obs; // Time in seconds
  RxBool isRunning = false.obs;
  RxBool paused = false.obs;
  dynamic firstGameLevel = ''.obs;
  dynamic gameLevel = ''.obs;
  Timer? _timer;
  dynamic  difficultyLevel;
   dynamic score;
   dynamic timeStamp;
   RxBool isMuted = false.obs;
  static const String showcaseviewKey = 'isCompleteShowCaseWidget';
    late AudioPlayer _audioPlayer;

  SudokuResult({
     this.difficultyLevel,
     this.score,
     this.timeStamp,
     this.firstGameLevel,
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

// Method to check if onboarding is complete
  Future<bool> isCompleteShowCaseWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(showcaseviewKey) ?? false;
  }

  // Method to set onboarding as complete
  Future<void> completeShowCaseWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(showcaseviewKey, true);
    print('Showcase Widget complete');
  }



  void startTimer(String gameLevel) {
    // Set the initial elapsed time based on difficulty level
   if (!paused.value) {
      switch (gameLevel) {
      case 'Easy':
        elapsedTime.value = 360; // six minutes
        break;
      case 'Medium':
        elapsedTime.value = 480; // eight minutes
        break;
      case 'Hard':
        elapsedTime.value = 600; // ten minutes
        break;
      default:
        elapsedTime.value = 360;
    }
   }

    // Start the timer
    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (paused.value) {
        // Decrement the elapsed time
      elapsedTime.value--;
      // Check if time has run out
      if (elapsedTime.value == 0) {
        // Navigate based on difficulty level
        String gameStatus = 'loss';
        String route = '/gameWin';

        Get.toNamed(route, arguments: {
          'difficultyLevel': gameLevel,
          'gameStatus': gameStatus,
          'score': elapsedTime.value,
          'timeStamp': DateTime.now().toString(),
        });

        stopTimer(); // Stop the timer when time reaches zero
      }
      }
    });
  }

  void pauseTimer() {
    print("PAUSED >> $paused");
  paused.value = !paused.value; // Toggles between pause and play
}

  void stopTimer() {
    isRunning.value = false;
    paused.value = false;
    _timer?.cancel();
    print('Timer stopped when screen is closed >>> ');
  }
  
      Future<void> playMusic() async {
    try {
      _audioPlayer.setReleaseMode(ReleaseMode.stop);
      await _audioPlayer.setSource(AssetSource('audio/game_home_audio.mp3'));
      await _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future <void> mute () async {
    print("isMuted >> $isMuted");
    isMuted.value = !isMuted.value;
    if (isMuted.value) {
      await _audioPlayer.stop();
    }else {
      await _audioPlayer.play(AssetSource('audio/game_home_audio.mp3'));
    }
  }

@override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Clean up the timer when the controller is disposed
    super.onClose();
    //_audioPlayer.dispose();
  }
}
