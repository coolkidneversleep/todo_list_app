import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/api/todo_list_api.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('TodoListAPI tests', () {
    late TodoListAPI todoListAPI;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      todoListAPI = TodoListAPI();
      TodoListAPI.dio = mockDio;
    });

    test('Test getTodoList method', () async {
      // Mock response data
      final responseData = {
        "tasks": [
          {
            "id": "cbb0732a-c9ab-4855-b66f-786cd41a3cd1",
            "title": "Read a book",
            "description": "Spend an hour reading a book for pleasure",
            "createdAt": "2023-03-24T19:30:00Z",
            "status": "TODO"
          },
          {
            "id": "119a8c45-3f3d-41da-88bb-423c5367b81a",
            "title": "Exercise",
            "description": "Go for a run or do a workout at home",
            "createdAt": "2023-03-25T09:00:00Z",
            "status": "TODO"
          }
        ],
        "pageNumber": 0,
        "totalPages": 16
      };

      // Mock Dio's response
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: responseData,
                statusCode: 200,
                requestOptions: RequestOptions(),
              ));

      // Call the API method
      final result = await TodoListAPI.getTodoList(page: 0, perPage: 2, status: 'TODO');

      // Verify the result
      expect(result.tasks.length, equals(2));
      expect(result.pageNumber, equals(0));
      expect(result.totalPages, equals(16));
    });
  });
}