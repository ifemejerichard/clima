import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {

  Location userLocation = Location();// location object of type Location

  Future getCityWeather (var cityName) async{

    Networking networking = Networking(url: 'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${userLocation.apikey}&units=metric');

    var cityWeatherData = await networking.getWeatherData();

    return cityWeatherData;
  }

  Future getLocationWeatherjson () async{
    await userLocation.getLocation();

    // created the Networking object
    Networking networking = Networking(url: 'https://api.openweathermap.org/data/2.5/weather?'
        'lat=${userLocation.latitude}&lon=${userLocation.longitude}&appid=${userLocation.apikey}&units=metric');
    // the (unit=metric) at the end auto converts the temp from farenheits to celcius so we don't have to do it ourself

    var networkResult = await networking.getWeatherData();
    return networkResult;
    // this will push the entire weather and location json file into networkResult
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

  String getMessage(int temperature) {
    if (temperature > 25) {
      return 'It\'s 🍦 time';
    } else if (temperature > 20) {
      return 'Time for shorts and 👕';
    } else if (temperature < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}