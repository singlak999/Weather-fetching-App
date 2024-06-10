import '../services/location.dart';
import '../services/networking.dart';
class WeatherModel {
  Future<dynamic> weathercity(String city) async {
    var url='https://api.openweathermap.org/data/2.5/weather?q=$city&appid=e1bc73925ed6dd716191c10142271fb9&units=metric';
    NetworkHelper networkHelper=await NetworkHelper(url);
    var weatherdata=networkHelper.getData();
    return weatherdata;
  }
  late double lat;
  late double lon;
  Future<dynamic> getLocationWeather() async {
    Location l = Location();
    await l.getCurrentLocation();
    lat = l.latitude;
    lon = l.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=e1bc73925ed6dd716191c10142271fb9&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}