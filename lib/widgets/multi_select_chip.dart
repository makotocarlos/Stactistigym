import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> items;
  final List<String> initialSelectedValues;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip({
    Key? key,
    required this.items,
    required this.initialSelectedValues,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.initialSelectedValues;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.items.map((item) {
        return ChoiceChip(
          label: Text(item),
          selected: _selectedValues.contains(item),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedValues.add(item);
              } else {
                _selectedValues.remove(item);
              }
              widget.onSelectionChanged(_selectedValues);
            });
          },
          backgroundColor: Colors.lightBlueAccent[100], // Color claro de fondo
          selectedColor: Colors.lightBlueAccent[700], // Color al seleccionar
          labelStyle: TextStyle(color: Colors.black),
        );
      }).toList(),
    );
  }
}
