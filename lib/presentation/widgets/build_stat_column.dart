// stat_column_widget.dart
import 'package:flutter/material.dart';

class StatColumnWidget extends StatelessWidget {
  final String label;
  final String value;

  const StatColumnWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF36827F),
          ),
        ),
      ],
    );
  }
}
