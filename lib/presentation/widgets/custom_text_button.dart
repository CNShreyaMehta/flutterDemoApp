import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle; // Optional text style
  final Color? foregroundColor; // Optional text color

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle, // Optionally pass textStyle
    this.foregroundColor, // Optionally pass text color
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor ?? Colors.black, // Default to black
        textStyle: textStyle ?? const TextStyle( // Default text style if not provided
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(text),
    );
  }
}
