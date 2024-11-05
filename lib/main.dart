import 'package:demo_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
   GoogleFonts.config.allowRuntimeFetching = false;  // Disables runtime fetching, embedding the font directly
  runApp(MyApp());
}