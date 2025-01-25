import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/todo_data.dart';

class ToDoManangement with ChangeNotifier {
  static late SharedPreferences _sharedPreferences;
  List<TodoData> todos = [];

  Future<void> creatSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveDatatoShared() {
    creatSharedPreference();
    List<String> todoStrings =
        todos.map((todo) => "${todo.isDone ? 1 : 0}|${todo.title}").toList();
    //map içerisinde her bir tododata nesnesini dönüştürür
    _sharedPreferences.setStringList("todo_list", todoStrings);
  }

  void loadFormLocalStorage() {
    creatSharedPreference();

    List<String>? todoStrings =
        _sharedPreferences.getStringList("todo_list"); //kaydedilen listeyi al
    if (todoStrings != null) {
      todos = todoStrings.map((todoString) {
        // Saklama formatını çöz: "isDone|title"
        List<String> parts = todoString.split('|');
        return TodoData(
          isDone: parts[0] == "1", // "1" ise yapılmış, değilse yapılmamış
          title: parts[1],
        );
      }).toList();
      notifyListeners();
    }
  }

  void addData(TodoData todo) {
    todos.add(todo);
    notifyListeners();
    saveDatatoShared();
  }

  void deleteData(int index) {
    todos.removeAt(index);
    notifyListeners();
    saveDatatoShared();
  }

  void toggleCompletion(int index) {
    todos[index].isDone = !todos[index].isDone;
    notifyListeners();
    saveDatatoShared();
  }

  List<TodoData> getData() {
    return todos;
  }
}
