import 'package:flutter/material.dart';
import 'add_exercise_screen.dart';
import 'statistics_screen.dart';
import 'exercise_list_screen.dart';
import '../widgets/experience_bar_home.dart'; // Importar barra de experiencia
import '../widgets/option_button.dart'; // Importar botón de opción

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _exercises = [];
  final List<Map<String, dynamic>> _completedExercises = [];
  double _experience = 0.0;
  int _level = 0;

  void _deleteExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
    });
  }

  void _addExperience(double xp) {
    setState(() {
      _experience += xp;
      _calculateLevel();
    });
  }

  void _calculateLevel() {
    double experience = _experience;
    int level = 0;
    double experienceRequired = 100.0; 

    while (experience >= experienceRequired) {
      experience -= experienceRequired;
      level++;
      experienceRequired *= 1.1;
    }

    setState(() {
      _level = level;
    });
  }

  void _addToCompletedExercises(Map<String, dynamic> exercise) {
    setState(() {
      _completedExercises.add(exercise);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🏋️‍♂️ Fitness Quest'),
        backgroundColor: const Color(0xFFE0F7FA),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue[50]!, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OptionButton(
                    label: '🏋️‍♂️ Agregar Ejercicio',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExerciseScreen(exercises: _exercises),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  OptionButton(
                    label: '📋 Lista de Ejercicios',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseListScreen(
                            exercises: _exercises,
                            onDelete: _deleteExercise,
                            onExperienceChange: _addExperience,
                            onComplete: _addToCompletedExercises,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  OptionButton(
                    label: '📊 Estadísticas',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatisticsScreen(
                            experience: _experience,
                            completedExercises: _completedExercises,
                          ),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_kabaddi,
                          size: 80,
                          color: Colors.black87,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Nivel $_level',
                          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        ExperienceBar(experience: _experience),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
