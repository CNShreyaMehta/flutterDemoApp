import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon; // Optional icon
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor; // Optional background color

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon, // Icon is optional
    this.borderRadius = 30.0, // Default value for border radius
    this.padding = const EdgeInsets.symmetric(vertical: 14), // Default padding
    this.backgroundColor, // Optional background color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding, backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ), // Use backgroundColor if provided
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          if (icon != null) ...[
            const SizedBox(width: 10), // Add space between text and icon if icon exists
            Icon(icon),
          ],
        ],
      ),
    );
  }
}