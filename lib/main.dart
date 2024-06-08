import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management/model/employee.dart';
import 'package:inventory_management/view/employee_app.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox<Employee>('employees');
  runApp(EmployeeApp());
}
