import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:inventory_management/model/employee.dart';

class EditEmployeeDialog extends StatefulWidget {
  EditEmployeeDialog(this.selectedEmployee);
  Employee selectedEmployee;
  @override
  State<StatefulWidget> createState() {
    return _EditEmployeeDialogState(selectedEmployee);
  }
}

class _EditEmployeeDialogState extends State<EditEmployeeDialog> {
  _EditEmployeeDialogState(this.selectedEmployee);
  Employee selectedEmployee;
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  Box<Employee> employeeBox = Hive.box<Employee>('employees');

  @override
  Widget build(BuildContext context) {
    _nameController.text = selectedEmployee.name;
    _positionController.text = selectedEmployee.position;

    return AlertDialog(
      title: const Text('Edit Employee'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
          ),
          TextField(
            controller: _positionController,
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
              selectedEmployee.name = name;
              selectedEmployee.position = position;
              selectedEmployee.save();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
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
