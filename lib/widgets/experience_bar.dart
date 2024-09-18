import 'package:flutter/material.dart';


class ExperienceBar extends StatelessWidget {
  final double experience;
  final double experienceRequired;

  ExperienceBar({required this.experience, required this.experienceRequired});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Container(
          width: (experience / experienceRequired) * MediaQuery.of(context).size.width,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '${experience.toStringAsFixed(0)}/${experienceRequired.toStringAsFixed(0)} XP',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
