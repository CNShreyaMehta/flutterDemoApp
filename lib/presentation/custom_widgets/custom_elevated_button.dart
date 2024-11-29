import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon; // Optional icon
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor; // Optional background color
  final Color textColor;
  final Color iconColor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon, // Icon is optional
    this.borderRadius = 30.0, // Default value for border radius
    this.padding = const EdgeInsets.symmetric(vertical: 14), // Default padding
    this.backgroundColor, // Optional background color
    required this.textColor,
    required this.iconColor,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: widget.padding, 
        backgroundColor: widget.backgroundColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(borderRadius),
        //   side:   const BorderSide(color: Colors.black, width: 5.0),
        // ), // Use backgroundColor if provided
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.text,style: TextStyle(color: widget.textColor),),
          if (widget.icon != null) ...[
            const SizedBox(
                width: 10), // Add space between text and icon if icon exists
            Icon(widget.icon, color: widget.iconColor,),
          ],
        ],
      ),
    );
  }
}
