import 'package:flutter/material.dart';

class MeailItemTrain extends StatelessWidget {
  const MeailItemTrain({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Colors.white),
        const SizedBox(width: 6),
        Text(title, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
