import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todoModel.dart';

const todoListKey = 'todo_list';

class TodoRepository {
  todoRepository() async {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  void saveTodoList(List<Todo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString(todoListKey, jsonString);
  }

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  Future<void> clearTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(todoListKey);
  }
  
  

}
