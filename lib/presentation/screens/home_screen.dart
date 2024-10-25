import 'package:demo_app/presentation/controllers/login_controller.dart';
import 'package:demo_app/presentation/screens/game_2048.dart';
import 'package:demo_app/presentation/screens/sudoku_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.find();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor:
            const Color.fromARGB(255, 210, 235, 247), // Set the background color to blue
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
                            _showLogoutConfirmation(context); // Show logout confirmation dialog

            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 210, 235, 247),),
              child: Text('WELCOME'),
            ),
            ListTile(
              title: const Text('Sudoku Game'),
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SudokuScreen()),
            );
              },
            ),
            ListTile(
              title: const Text('Game 2048'),
              onTap: () {
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const game2048()),
            );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _selectedIndex == 0 ? const Text('Home Tab') : const Text('Settings Tab'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  
   // Show a confirmation dialog for logout
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
              loginController.logout();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}