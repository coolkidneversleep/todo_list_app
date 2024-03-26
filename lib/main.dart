import 'package:flutter/material.dart';
import 'package:todo_list_app/pages/todo_pagination_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List Application',
      home: TodoPaginationPage(),
    );
  }
}
