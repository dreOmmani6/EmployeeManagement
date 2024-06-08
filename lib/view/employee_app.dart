import 'package:flutter/material.dart';
import 'package:inventory_management/view/employee_list_screen.dart';

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EmployeeListScreen(),
    );
  }
}
