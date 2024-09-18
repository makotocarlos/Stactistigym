import 'package:flutter/material.dart';

class ExperienceBar extends StatelessWidget {
  final double experience;

  ExperienceBar({required this.experience});

  @override
  Widget build(BuildContext context) {
    double progress = (experience % 100) / 100; // Progreso de la barra
    return Column(
      children: [
        SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width * progress,
              decoration: BoxDecoration(
                color: Colors.greenAccent[400],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          '${experience.toInt()} XP - ${100 - (experience % 100).toInt()} XP para subir de nivel',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }
}
