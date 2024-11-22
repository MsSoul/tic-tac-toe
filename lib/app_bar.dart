import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;

  const CustomAppBar({super.key, required this.title, this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Custom Header
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.orange[100], // Updated background to orange
            border: const Border(bottom: BorderSide(color: Colors.orange, width: 2)), // Orange border
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Left Logo
              Image.asset(
                'assets/cete-logo.png', // Update with the correct path
                height: 60,
              ),
              const SizedBox(width: 16),
              // Header Title
              Expanded(
                child: Text(
                  'COLLEGE OF ENGINEERING AND TECHNOLOGY EDUCATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800], // Orange text
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Right Logo
              Image.asset(
                'assets/htc.png', // Update with the correct path
                height: 60,
              ),
            ],
          ),
        ),
        // Text Below the Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange, // Default orange text
                ),
          ),
        ),
      ],
    );
  }

  /// Reusable Orange Button
  static Widget orangeButton({
    required String text,
    required VoidCallback onPressed,
    double width = 300.0,
    double height = 50.0,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange, // Orange background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Rounded corners
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white, // White text
          ),
        ),
      ),
    );
  }
}
