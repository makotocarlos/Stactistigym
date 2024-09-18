import 'package:flutter/material.dart';

class CompletedExercisesList extends StatelessWidget {
  final List<Map<String, dynamic>> exercises;

  CompletedExercisesList({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.all(16.0),
            title: Text(
              exercise['name'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            subtitle: Text(
              'Tipo: ${exercise['type']}\n'
              'Rutina: ${exercise['routine']}\n'
              'Repeticiones: ${exercise['reps']}\n'
              'Días: ${exercise['days'].join(', ')}\n'
              'Puntos de experiencia: ${exercise['xp']}',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        );
      },
    );
  }
}
