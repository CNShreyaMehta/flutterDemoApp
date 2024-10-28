import 'package:demo_app/presentation/screens/games/2048/game_2048.dart';
import 'package:demo_app/presentation/screens/games/sudoku/difficulty_level_screen.dart';
import 'package:flutter/material.dart';

class GamesHomeScreen extends StatelessWidget {
  const GamesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Games'),
          centerTitle: true,
        ),
        body: Center(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const game2048()),
            );
              },
            child: Container(
              width: MediaQuery.of(context).size.width *0.3,
                    height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 246, 150),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  '2048',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              
              )),
          ),
            InkWell(
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DifficultyLevelScreen()),//SudokuScreen
            );
              },
              child: Container(
              width: MediaQuery.of(context).size.width *0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 144, 234, 175),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Sudoku',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              
              )),
            )
        ])
       
      ),
        );
  }
}
