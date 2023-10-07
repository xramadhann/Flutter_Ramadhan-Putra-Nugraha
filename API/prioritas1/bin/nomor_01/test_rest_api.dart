import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();

  final data = {
    "name": "morpheus",
    "job": "leader",
  };

  try {
    final response = await dio.post(
      "https://reqres.in/api/users",
      data: data,
    );

    if (response.statusCode == 201) {
      print(response.data);
    } else {
      print("Gagal mengirim data. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Terjadi kesalahan: $e");
  }
}
