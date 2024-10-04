import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  final bool isLoading;
  final String? loadingMessage;

  const SpinnerWidget({super.key, required this.isLoading, this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.black.withOpacity(0.5), // Optional background overlay
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  if (loadingMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      loadingMessage!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ],
              ),
            ),
          )
        : const SizedBox.shrink(); // Return an empty widget when not loading
  }
}
