import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherTemperature {
  static Future<String> getTemperature(String cityName) async {
    final String apiKey = '25aeb6203ec6623cc5bc34377174b621';

    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['main']['temp'].toString();
    } else {
      throw Exception('Failed to load temperature');
    }
  }
}
