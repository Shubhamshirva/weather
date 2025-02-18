import 'package:dio/dio.dart';

class WeatherAPI {
  final String apiKey = '31674973448abffc6a9e1e38274ce19e';  // Replace with actual API key
  final String baseUrl = 
  // 'http://api.weatherapi.com/v1';
  'https://api.openweathermap.org/data/2.5';

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final response = await _dio.get(
        '$baseUrl/weather',
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric', // Default: Celsius
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchForecast(String city) async {
    try {
      final response = await _dio.get(
        '$baseUrl/forecast',
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric',
          'cnt': 3, // Fetch 3-day forecast
        },
      );
      return List<Map<String, dynamic>>.from(response.data['list']);
    } catch (e) {
      throw Exception('Failed to load forecast data');
    }
  }
}
