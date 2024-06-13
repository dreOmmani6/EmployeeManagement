import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management/model/employee.dart';
import 'package:inventory_management/view/employee_add_dialog.dart';
import 'package:inventory_management/view/employee_edit.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  //final List<Employee> _employees = [];
  final Box<Employee> _employeeBox = Hive.box<Employee>('employees');
  int? _selectedIndex;

  void _addEmployee(String name, String position) {
    setState(() {
      _employeeBox.add(Employee(name: name, position: position));
    });
  }

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEmployeeDialog();
      },
    );
  }

  void _editEmployeeDialog(Employee selectedEmployee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditEmployeeDialog(selectedEmployee);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Employee>('employees').listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: _employeeBox.length,
            itemBuilder: (context, index) {
              final employee = _employeeBox.getAt(index);
              bool isSelected = _selectedIndex == index;
              return ListTile(
                title: Text(employee!.name),
                subtitle: Text(employee.position),
                tileColor: isSelected ? Colors.blue.withOpacity(0.5) : null,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedIndex = null;
                      isSelected = false;
                    } else {
                      _selectedIndex = index;
                      isSelected = true;
                    }
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectedIndex == null
              ? _showAddEmployeeDialog()
              : (_editEmployeeDialog(_employeeBox.getAt(_selectedIndex!)!));
        },
        child: _selectedIndex == null
            ? const Icon(Icons.add)
            : const Icon(Icons.edit),
      ),
    );
  }
}
