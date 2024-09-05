import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String? title; // Title is optional
 final Color? backgroundColor;
  final bool showBellIcon; // Optional bell icon flag
  const Header({
    super.key,
    this.title,
     this.backgroundColor = Colors.white, // Default background color
    this.showBellIcon = false, // Default is not to show the bell icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread items across the row
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(); // Navigate to the previous screen
                },
              ),
              if (title != null) // If title is provided, display it
                Text(
                  title!,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
          if (showBellIcon) // If the bell icon is required, display it
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle bell icon press (e.g., navigate to notifications screen)
              },
            ),
        ],
      ),
    );
  }
}
