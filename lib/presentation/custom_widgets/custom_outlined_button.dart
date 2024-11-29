import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final BorderSide borderSide;
  final Color? labelColor;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.borderRadius = 30.0, // Default value for border radius
    this.padding = const EdgeInsets.symmetric(vertical: 10), // Default padding
    this.borderSide = const BorderSide(color: Colors.black), // Default border style
    this.labelColor = Colors.black, // Default label text color
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon, // Pass the icon widget
      label: Text(
        label,
        style: TextStyle(color: labelColor),
      ), // Label text and style
      style: OutlinedButton.styleFrom(
        
        padding: padding,
        side: borderSide, // Pass the border style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Customize border radius
        ),
      ),
    );
  }
}
