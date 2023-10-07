import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final url = 'https://jsonplaceholder.typicode.com/posts/1';

  final data = {
    'id': 1,
    'title': 'foo',
    'body': 'bar',
    'userId': 1,
  };

  try {
    final response = await dio.put(
      url,
      data: data,
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.data}');
    } else {
      print('Failed to update post');
    }
  } catch (e) {
    print('Error: $e');
  }
}
