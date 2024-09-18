import 'package:flutter/material.dart';

class ExerciseListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  final Function(int) onDelete;
  final Function(double) onExperienceChange;
  final Function(Map<String, dynamic>) onComplete;

  ExerciseListScreen({
    Key? key,
    required this.exercises,
    required this.onDelete,
    required this.onExperienceChange,
    required this.onComplete,
  }) : super(key: key);

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Ejercicios'),
        backgroundColor: const Color(0xFFE0F7FA), // Color claro para la barra superior
      ),
      body: widget.exercises.isEmpty
          ? Center(
              child: Text('No hay ejercicios añadidos.', style: TextStyle(fontSize: 18, color: Colors.black54)),
            )
          : ListView.builder(
              itemCount: widget.exercises.length,
              itemBuilder: (context, index) {
                final exercise = widget.exercises[index];
                return Dismissible(
                  key: Key(exercise['name']),
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.redAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.delete, color: Colors.white, size: 28),
                        ),
                        Text('Eliminar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.lightBlueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Editar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.edit, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Eliminar
                      bool? confirm = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirmación'),
                            content: Text('¿Está seguro de que desea eliminar este ejercicio?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('Eliminar'),
                              ),
                            ],
                          );
                        },
                      );
                      return confirm;
                    } else if (direction == DismissDirection.endToStart) {
                      
                  
                    }
                    return false;
                  },
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      widget.onDelete(index); // Llama a la función de eliminación
                    } else if (direction == DismissDirection.endToStart) {
                      
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white, // Color de fondo de la tarjeta
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
                      trailing: Checkbox(
                        value: exercise['completed'],
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              if (value) {
                                widget.onExperienceChange((exercise['xp'] as int).toDouble());
                                widget.onComplete(exercise); // Añade el ejercicio al historial
                                widget.onDelete(index); // Elimina el ejercicio
                              }
                              exercise['completed'] = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
