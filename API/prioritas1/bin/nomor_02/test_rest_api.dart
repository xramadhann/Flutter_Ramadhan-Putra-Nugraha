import 'package:dio/dio.dart';

import 'contact.dart';

void main() async {
  final dio = Dio();
  final response = await dio.get(
    "https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts/2",
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = response.data;
    final contact = Contact.fromJson(data);
    print("ID: ${contact.id}");
    print("Name: ${contact.name}");
    print("Phone: ${contact.phone}");
  } else {
    print("Failed to load data.");
  }
}
