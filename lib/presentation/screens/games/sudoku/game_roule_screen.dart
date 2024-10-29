import 'package:demo_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class GameRoule extends StatefulWidget {
  const GameRoule({super.key});

  @override
  State<GameRoule> createState() => _GameRouleState();
}

class _GameRouleState extends State<GameRoule> {
   final PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                _buildPage(
                  image: 'assets/images/step1.png',
                  title: 'Welcome to the App!',
                  description:
                      'Get started by learning the basics of how to use this app.',
                ),
                _buildPage(
                  image: 'assets/images/step2.png',
                  title: 'Understand the Rules',
                  description:
                      'Follow these guidelines to get the best experience while using the app.',
                ),
                _buildPage(
                  image: 'assets/images/step3.png',
                  title: 'Explore Features',
                  description:
                      'Discover the features that make our app unique and easy to use.',
                ),
                _buildPage(
                  image: 'assets/images/step4.png',
                  title: 'Track Your Progress',
                  description:
                      'Keep an eye on your performance and progress over time.',
                ),
                _buildPage(
                  image: 'assets/images/step5.png',
                  title: 'Get Started!',
                  description: 'You’re all set! Dive in and start using the app.',
                ),
              ],
            ),
          ),
          _buildIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _currentIndex == 4
                  ? _navigateToHomeScreen
                  : () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
              child: Text(_currentIndex == 4 ? 'Get Started' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
   Widget _buildPage({required String image, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentIndex == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
}