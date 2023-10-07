import 'package:dio/dio.dart';

import 'package:dicebear_api_01/models/home_model.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel {
  Future<HomeModel> fetchData() async {
    try {
      final response = await Dio().get(
          'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Socks');

      if (response.statusCode == 200) {
        final responseData = response.data.toString();
        return HomeModel(apiResponse: responseData);
      } else {
        const Text('Gagal melakukan panggilan API');
        return HomeModel(apiResponse: '');
      }
    } catch (e) {
      Text('Terjadi kesalahan: $e');
      return HomeModel(apiResponse: '');
    }
  }
}
