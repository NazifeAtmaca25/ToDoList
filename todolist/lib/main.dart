import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:todolist/home.dart';
import 'package:todolist/todo_management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ToDoManangement toDoManangement = ToDoManangement();
  await toDoManangement.creatSharedPreference();

  runApp(ChangeNotifierProvider<ToDoManangement>(
      create: (BuildContext context) {
        return ToDoManangement();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ToDoManangement>(context, listen: false).loadFormLocalStorage();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To do List",
      home: Home(),
    );
  }
}
