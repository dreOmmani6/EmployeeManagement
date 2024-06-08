import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:inventory_management/model/employee.dart';

class AddEmployeeDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddEmployeeDialogState();
  }
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  Box<Employee> employeeBox = Hive.box<Employee>('employees');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Employee'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _positionController,
            decoration: const InputDecoration(labelText: 'Position'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final name = _nameController.text;
            final position = _positionController.text;
            if (name.isNotEmpty && position.isNotEmpty) {
              employeeBox.add(Employee(name: name, position: position));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    super.dispose();
  }
}
