import 'package:flutter/material.dart';
import '../widgets/experience_bar.dart';
import '../widgets/completed_exercises_list.dart';

class StatisticsScreen extends StatefulWidget {
  final double experience;
  final List<Map<String, dynamic>> completedExercises;

  StatisticsScreen({
    Key? key,
    required this.experience,
    required this.completedExercises,
  }) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _level = 0;
  double _experience = 0.0;
  double _experienceRequired = 100.0;

  @override
  void initState() {
    super.initState();
    _experience = widget.experience;
    _calculateLevel();
  }

  void _calculateLevel() {
    while (_experience >= _experienceRequired) {
      _experience -= _experienceRequired;
      _level++;
      _experienceRequired *= 1.1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
        backgroundColor: const Color(0xFFE0F7FA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nivel $_level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Text(
              'Experiencia:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
            ),
            SizedBox(height: 8),
            
            // Usa el widget de barra de experiencia
            ExperienceBar(experience: _experience, experienceRequired: _experienceRequired),
            
            SizedBox(height: 16),
            Text(
              'Historial de Ejercicios Completados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            
            // Usa el widget de lista de ejercicios completados
            Expanded(
              child: CompletedExercisesList(exercises: widget.completedExercises),
            ),
          ],
        ),
      ),
    );
  }
}
