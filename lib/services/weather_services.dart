import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/weather_model.dart';

class WeatherServices {
  final Dio dio;

  WeatherServices(this.dio);

  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '13ca901de508411ba9b24641242101';

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errMassage = e.response?.data['error']['massage'] ??
          'oops.. there was an error, try later';
      throw Exception(errMassage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops.. there was an error, try later');
    }
  }
}

// Future<WeatherModel> getForeCast({required String cityName}) async {
//   Response response = await dio.get(
//       '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
//   WeatherModel weatherModel = WeatherModel.fromJson(response.data);
//   return weatherModel;
// }
