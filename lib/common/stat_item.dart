import 'package:flutter/material.dart';

class StatItem extends StatelessWidget {
  final String? value;
  final String label;
  final IconData? icon;

  const StatItem({super.key, this.value, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null)
          Text(
            value!,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        else if (icon != null)
          Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
        ),
      ],
    );
  }
}
