// info_row_widget.dart
import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  final IconData icon;
  final String? info;

  const InfoRowWidget({
    super.key,
    required this.icon,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    if (info == null || info!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              info!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
