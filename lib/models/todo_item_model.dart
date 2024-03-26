// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:todo_list_app/constants/todo_status.dart';

class TodoItemModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final TodoStatus status;

  const TodoItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      createdAt,
      status,
    ];
  }

  TodoItemModel copyWith({
    String? id,
    String? title,
    String? description,
    String? createdAt,
    TodoStatus? status,
  }) {
    return TodoItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'status': status.name,
    };
  }

  factory TodoItemModel.fromMap(Map<String, dynamic> json) {
    return TodoItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
      status: TodoStatus.values.byName(json['status'] ?? TodoStatus.TODO),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItemModel.fromJson(String source) =>
      TodoItemModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
