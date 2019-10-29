import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

import '../models/Todo.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/todo.txt');
}

Future<List<Todo>> readTodo() async {
  final file = await _localFile;
  final isExist = await file.exists();
  if (isExist) {
    final text = await file.readAsString();
    List<dynamic> list = jsonDecode(text);
    return list.map((e) {
      return Todo(title: e['title'], finish: e['finish'] == 1 ? FinishStatus.doing : FinishStatus.done);
    }).toList();
  }

  return [];
}

Future<File> writeTodo(List<Todo> todos) async {
  final file = await _localFile;
  final data = jsonEncode(todos.map((e) => e.toJson()).toList());
  print(data);
  return file.writeAsString('$data');
}