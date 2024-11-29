import 'package:demo_app/presentation/controllers/home_controller.dart';
import 'package:demo_app/presentation/screens/profile_screen.dart';
import 'package:demo_app/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

final List<Widget> _Categoryscreens = [
  const CategoriesScreen(),
  const ProfileScreen(),
  const SettingsScreen(),
];
// Controller using GetX

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
    final HomeController loadingController = Get.put(HomeController());
  
  late AnimationController _animationController;
  late Animation<double> _counterAnimation;
  late Animation<double> _counter2Animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _counterAnimation = Tween<double>(
      begin: 0.0,
      end: loadingController.counter.value,
    ).animate(_animationController);

    _counter2Animation = Tween<double>(
      begin: 0.0,
      end: loadingController.counter2.value,
    ).animate(_animationController);

    _animationController.forward();
  }

  void updateAnimationValues() {
    _counterAnimation = Tween<double>(
      begin: _counterAnimation.value,
      end: loadingController.counter.value,
    ).animate(_animationController);

    _counter2Animation = Tween<double>(
      begin: _counter2Animation.value,
      end: loadingController.counter2.value,
    ).animate(_animationController);

    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: Center(
          child: Column(
            children: [
               Obx(() => Text(
              'Value: ${loadingController.counter.value.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 40),
            )),
        const SizedBox(height: 20),
        Container(
          width: 350,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color.fromARGB(255, 40, 82, 123),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter3(
                    counterValue2: _counterAnimation.value,
                    counter2Value2: _counter2Animation.value,
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                loadingController.decrement();
                updateAnimationValues();
              },
              child: const Text('-'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                loadingController.increment();
                updateAnimationValues();
              },
              child: const Text('+'),
            ),
          ],
        ),
            ],
          ),
        ));
  }
}

class WavePainter2 extends CustomPainter {
    final HomeController loadingControllerVal = Get.put(HomeController());
 final double counterValue;
  final double counter2Value;

  WavePainter2({required this.counterValue, required this.counter2Value});

  @override
  void paint(Canvas canvas, Size size ) {
    final gradients = [
      [const Color(0xFFf8cf62), const Color(0xFF214b75)],
      [const Color(0xFFecbf4a), const Color(0xFF285382)],
      [const Color(0xFFdf7a37), const Color(0xFF4b73a0)],
      [const Color(0xFFf48e4f), const Color(0xFF3f6995)],
      [
        const Color(0xFFFF5722),
        const Color(0xFF2b5482)
      ], // Red gradient
      [
        const Color(0xFF318485),
        const Color(0xFF2b5482)
      ], // Pink gradient
      [
        const Color(0xFF48a59c),
        const Color(0xFF2b5482)
      ], // Blue gradient
      [
        const Color(0xFF96bb41),
        const Color(0xFF173f6c)
      ], // Green gradient
    ];

    final gradientStops = [
      [loadingControllerVal.counter.value, loadingControllerVal.counter.value], // Orange gradient stops
      [loadingControllerVal.counter2.value > 0.0 ? loadingControllerVal.counter2.value : 0.0, loadingControllerVal.counter.value], // Orange gradient stops
      [loadingControllerVal.counter2.value > 0.0 ? loadingControllerVal.counter2.value : 0.0, loadingControllerVal.counter.value], // Orange gradient stops
      [loadingControllerVal.counter2.value > 0.0 ? loadingControllerVal.counter2.value : 0.0, loadingControllerVal.counter.value], // Orange gradient stops
      [loadingControllerVal.counter2.value > 0.0 ? loadingControllerVal.counter2.value : 0.0, loadingControllerVal.counter.value], // Orange gradient stops
      [loadingControllerVal.counter2.value > 0.0 ? loadingControllerVal.counter2.value : 0.0, loadingControllerVal.counter.value], // Orange gradient stops
      [loadingControllerVal.counter2.value > 0.0 ? loadingControllerVal.counter2.value : 0.0, loadingControllerVal.counter.value], // Orange gradient stops
      [loadingControllerVal.counter2.value > 0.0 ? loadingControllerVal.counter2.value : 0.0, loadingControllerVal.counter.value], // Orange gradient stops
      // [0.0, 0.4], // Orange gradient stops
      // [0.0, 0.4], // Orange gradient stops
    ];

    final waveHeight = size.height / 0.8; // Adjust for wave amplitude

    for (int i = 0; i < gradients.length; i++) {
      final gradient = gradients[i];
      final stops = gradientStops[i];

      final paint = Paint()
        ..shader = LinearGradient(
          colors: gradient,
          stops: stops,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      final path = Path();

      // Ensure each wave starts from the top
      final topOffset = i * 5; // Slight vertical adjustment per wave

      path.moveTo(0, topOffset.toDouble());
          path.quadraticBezierTo(
        size.width * 0.75,
        -waveHeight / 2 + topOffset,
        size.width,
        topOffset.toDouble(),
      );
      path.quadraticBezierTo(
        size.width * 0.25,
        waveHeight / 2 + topOffset,
        size.width * 0.5,
        topOffset.toDouble(),
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        -waveHeight / 2 + topOffset,
        size.width,
        topOffset.toDouble(),
      );
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class WavePainter3 extends CustomPainter {
    final HomeController loadingControllerVal = Get.put(HomeController());
 final double counterValue2;
  final double counter2Value2;

  WavePainter3({required this.counterValue2, required this.counter2Value2});

  @override
 void paint(Canvas canvas, Size size) {
    final gradients = [
      [const Color(0xFFf8cf62), const Color(0xFF214b75)],
      [const Color(0xFFecbf4a), const Color(0xFF285382)],
      [const Color(0xFFdf7a37), const Color(0xFF4b73a0)],
      [const Color(0xFFf48e4f), const Color(0xFF3f6995)],
      [const Color(0xFFFF5722), const Color(0xFF2b5482)],
      [const Color(0xFF318485), const Color(0xFF2b5482)],
      [const Color(0xFF48a59c), const Color(0xFF2b5482)],
      [const Color(0xFF96bb41), const Color(0xFF173f6c)],
    ];

    final gradientStops = [
      [counterValue2, counterValue2],
      [counter2Value2 > 0.0 ? counter2Value2 : 0.0, counterValue2],
      [counter2Value2 > 0.0 ? counter2Value2 : 0.0, counterValue2],
    ];

    final waveHeight = size.height / 0.8;

    for (int i = 0; i < gradients.length; i++) {
      final gradient = gradients[i];
      final stops = gradientStops[i % gradientStops.length];

      final paint = Paint()
        ..shader = LinearGradient(
          colors: gradient,
          stops: stops,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      final path = Path();
      final topOffset = i * 5;

      path.moveTo(0, topOffset.toDouble());
      path.quadraticBezierTo(
        size.width * 0.75,
        -waveHeight / 2 + topOffset,
        size.width,
        topOffset.toDouble(),
      );
      path.quadraticBezierTo(
        size.width * 0.25,
        waveHeight / 2 + topOffset,
        size.width * 0.5,
        topOffset.toDouble(),
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        -waveHeight / 2 + topOffset,
        size.width,
        topOffset.toDouble(),
      );
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Color.fromARGB(255, 252, 193, 19), // Orange
      Color.fromARGB(255, 235, 85, 39), // Red
      Color.fromARGB(255, 237, 52, 114), // Pink
      Color.fromARGB(255, 44, 148, 233), // Blue
      Color.fromARGB(255, 76, 221, 81), // Green
    ];

    final paint = Paint();
    final waveHeight = size.height * 0.4; // Adjust wave height proportionally
    for (int i = 0; i < colors.length; i++) {
      paint.color = colors[i];
      final path = Path();

      // Ensure each wave starts from the top
      final topOffset = i * 8; // Slight vertical adjustment per wave

      path.moveTo(0, topOffset.toDouble());
      path.quadraticBezierTo(
        size.width * 0.25,
        waveHeight / 2 + topOffset,
        size.width * 0.5,
        topOffset.toDouble(),
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        -waveHeight / 2 + topOffset,
        size.width,
        topOffset.toDouble(),
      );
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
