import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  const CustomBottomSheet({
    super.key,
    required this.onGalleryTap,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose an option",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Icon button for "Take Photo from Gallery"
              Column(
                children: [
                  IconButton(
                    onPressed: onGalleryTap,
                    icon: const Icon(Icons.photo_library, size: 40, color: Colors.blueAccent),
                  ),
                  const Text("Gallery"),
                ],
              ),
              // Icon button for "Take Photo from Camera"
              Column(
                children: [
                  IconButton(
                    onPressed: onCameraTap,
                    icon: const Icon(Icons.camera_alt, size: 40, color: Colors.blueAccent),
                  ),
                  const Text("Camera"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
