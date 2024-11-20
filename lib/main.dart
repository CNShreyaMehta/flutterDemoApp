import 'package:demo_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
// Set status bar color here
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Set your desired color here
      statusBarBrightness: Brightness.light, // For iOS (light text on status bar)
      statusBarIconBrightness: Brightness.light, // For Android (light icons on status bar)
    ));
    WidgetsFlutterBinding.ensureInitialized();
   GoogleFonts.config.allowRuntimeFetching = false;  // Disables runtime fetching, embedding the font directly
  runApp(MyApp());
}