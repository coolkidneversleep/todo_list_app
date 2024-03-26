import 'package:dio/dio.dart';
import 'package:todo_list_app/models/todo_list_pagination_model.dart';

class TodoListAPI {
  static var dio = Dio();

  static Future<TodoListPaginationModel> getTodoList(
      {int? page, int? perPage, required String status}) async {
    final response = await dio.get(
        "https://todo-list-api-mfchjooefq-as.a.run.app/todo-list",
        queryParameters: {
          "sortBy": "createdAt",
          "isAsc": true,
          "status": status,
          "limit": perPage,
          "offset": page,
        });
    return TodoListPaginationModel.fromMap(response.data);
  }
}
