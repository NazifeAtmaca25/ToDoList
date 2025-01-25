import 'package:flutter/cupertino.dart';

class TodoData with ChangeNotifier {
  String title;
  bool isDone;

  TodoData({required this.title, required this.isDone});
}
