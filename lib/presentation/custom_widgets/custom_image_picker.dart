import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(File) onImageSelected; // Callback to handle image selection

  const CustomImagePicker({super.key, required this.onImageSelected});

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onImageSelected(File(pickedImage.path)); // Pass the selected image to the parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the selected image if available
        if (_selectedImage != null)
          Image.file(
            _selectedImage!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )
        else
          Container(
            width: 200,
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.image, size: 50, color: Colors.grey),
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text("Gallery"),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Camera"),
            ),
          ],
        ),
      ],
    );
  }
}
