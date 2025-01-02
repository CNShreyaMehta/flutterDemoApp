import 'package:demo_app/firebase_options.dart';
import 'package:demo_app/my_app.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
   GoogleFonts.config.allowRuntimeFetching = false;  // Disables runtime fetching, embedding the font directly
  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch(e) {
    print("Failed to initialize Firebase: $e");
  }
  runApp(MyApp());
}