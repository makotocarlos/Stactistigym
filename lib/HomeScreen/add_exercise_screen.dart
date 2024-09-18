import 'package:flutter/material.dart';
import '../widgets/multi_select_chip.dart'; // Importar desde widgets

class AddExerciseScreen extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;

  AddExerciseScreen({Key? key, required this.exercises}) : super(key: key);

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _exerciseController = TextEditingController();
  final _xpController = TextEditingController();
  final _repsController = TextEditingController();
  String? _selectedType;
  String? _selectedRoutine;
  List<String> _selectedDays = [];

  @override
  void dispose() {
    _exerciseController.dispose();
    _xpController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Ejercicio'),
        backgroundColor: const Color(0xFFE0F7FA), // Color claro para la barra superior
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildTextField(
                        controller: _exerciseController,
                        label: 'Nombre del ejercicio',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor ingrese un nombre'
                            : null,
                      ),
                      SizedBox(height: 10),
                      _buildDropdownField(
                        value: _selectedType,
                        hint: 'Seleccionar Tipo',
                        items: ['Cardio', 'Fuerza', 'Flexibilidad'],
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Por favor seleccione un tipo'
                            : null,
                      ),
                      SizedBox(height: 10),
                      _buildTextField(
                        controller: _repsController,
                        label: 'Repeticiones',
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor ingrese el número de repeticiones'
                            : null,
                      ),
                      SizedBox(height: 10),
                      _buildDropdownField(
                        value: _selectedRoutine,
                        hint: 'Seleccionar Rutina',
                        items: ['Rutina 1', 'Rutina 2', 'Rutina 3'],
                        onChanged: (value) {
                          setState(() {
                            _selectedRoutine = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Por favor seleccione una rutina'
                            : null,
                      ),
                      SizedBox(height: 10),
                      MultiSelectChip(
                        items: ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'],
                        initialSelectedValues: _selectedDays,
                        onSelectionChanged: (selectedValues) {
                          setState(() {
                            _selectedDays = selectedValues;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      _buildTextField(
                        controller: _xpController,
                        label: 'Puntos de experiencia',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese puntos de experiencia';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Por favor ingrese un número entero';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final exercise = {
                              'name': _exerciseController.text,
                              'type': _selectedType,
                              'routine': _selectedRoutine,
                              'reps': _repsController.text,
                              'days': _selectedDays,
                              'xp': int.parse(_xpController.text),
                              'completed': false,
                            };
                            widget.exercises.add(exercise);
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent[700], // Color de fondo
                          foregroundColor: Colors.white, // Color del texto
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Agregar Ejercicio'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.sports_gymnastics, // Ícono de gimnasio
                size: 80,
                color: Colors.blueGrey[900],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
