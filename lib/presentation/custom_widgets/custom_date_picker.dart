import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        TextField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          onTap: () async {
            // Show date picker and await for user's selection
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              // Format the date as you like, here using "MM/dd/yyyy" format
              String formattedDate =
                  DateFormat('MM/dd/yyyy').format(pickedDate);

              // Update the controller's text with the selected date
              controller.text = formattedDate;
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
