// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:todo_list_app/models/todo_item_model.dart';

class TodoListPaginationModel extends Equatable {
  final List<TodoItemModel> tasks;
  final int pageNumber;
  final int totalPages;

  const TodoListPaginationModel({
    required this.tasks,
    required this.pageNumber,
    required this.totalPages,
  });

  TodoListPaginationModel copyWith({
    List<TodoItemModel>? tasks,
    int? pageNumber,
    int? totalPages,
  }) {
    return TodoListPaginationModel(
      tasks: tasks ?? this.tasks,
      pageNumber: pageNumber ?? this.pageNumber,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tasks': tasks,
      'pageNumber': pageNumber,
      'totalPages': totalPages,
    };
  }

  factory TodoListPaginationModel.fromMap(Map<String, dynamic> map) {
    return TodoListPaginationModel(
      tasks: (map['tasks'] as List<dynamic>)
          .map((e) => TodoItemModel.fromMap(e))
          .toList(),
      pageNumber: map['pageNumber'] ?? 0,
      totalPages: map['totalPages'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoListPaginationModel.fromJson(String source) =>
      TodoListPaginationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoListPaginationModel(tasks:$tasks, pageNumber: $pageNumber, totalPages: $totalPages)';
  }

  @override
  List<Object> get props => [tasks, pageNumber, totalPages];
}
