// ignore: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final RxString selectedItem;
  final String hint;

  const Dropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItem,
    this.hint = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16,color: Colors.black),
        ),
        const SizedBox(height: 10),
        Obx(() {
          return DropdownButtonFormField<String>(
            value: selectedItem.value.isEmpty ? null : selectedItem.value,
            hint: Text(hint.isEmpty ? "Select $label" : hint, style: TextStyle(color: hint.isEmpty ? Colors.grey :  Colors.black),),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              selectedItem.value = value!;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.grey, // Customize the border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.black, // Customize the border color when focused
                  width: 1.0, // Border width when focused
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 10),
      ],
    );
  }
}

