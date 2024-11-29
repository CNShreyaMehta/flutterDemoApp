import 'dart:io';

import 'package:demo_app/presentation/custom_widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(File) onImageSelected; // Callback to handle image selection
final Color? backgroundColor; // Optional background color
  final Color textColor;
  final Color iconColor;
  const CustomImagePicker({super.key, 
  required this.onImageSelected , 
  this.backgroundColor, 
  required this.textColor, 
  required this.iconColor});


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
      widget.onImageSelected(
          File(pickedImage.path)); // Pass the selected image to the parent
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return CustomBottomSheet(
          onGalleryTap: () {
            Navigator.of(context).pop(); // Close the bottom sheet
            Get.snackbar("Gallery", "Take photo from gallery tapped");
          },
          onCameraTap: () {
            Navigator.of(context).pop(); // Close the bottom sheet
            Get.snackbar("Camera", "Take photo from camera tapped");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the selected image if available
        if (_selectedImage != null)
          Image.file(
            _selectedImage!,
            width: 110,
            height: 110,
            fit: BoxFit.cover,
          )
        else
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            width: 110,
            height: 110,
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              icon:  Icon(Icons.photo, size: 20, color: widget.iconColor),
              label: const Text("Gallery", style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
               style: ElevatedButton.styleFrom(
                backgroundColor: widget.backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              onPressed: () =>
                  _showBottomSheet(context), //_pickImage(ImageSource.camera),
              icon: Icon(Icons.camera_alt, size: 20, color: widget.iconColor),
              label: const Text("Camera", style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }
}
