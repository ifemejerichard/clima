import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {

  final dynamic LocationWeatherData;

  const LocationScreen({super.key,  required this.LocationWeatherData});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel(); // declaring the weathermodel object.

  late var temperature;
  late var weatherIcon;
  late var cityName;
  late var weatherMessage;

  @override
  void initState() {
    super.initState();
    UpdateUI(widget.LocationWeatherData);
  }

  void UpdateUI (var weatherData) {
    setState(() {
      var temp = jsonDecode(weatherData)['main']['temp'];
      temperature = temp.toInt(); // this removes any decimal point value and converts it into a whole number
      var condition = jsonDecode(weatherData)['weather'][0]['id'];
      cityName= jsonDecode(weatherData)['name'];

      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      // this will get new weather info incase we change our location but we also have to wait for it to finish
                      var updatedWeatherData  = await weather.getLocationWeatherjson();
                      UpdateUI(updatedWeatherData);// this will update the ui to change the info
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var returnCityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Cityscreen();
                            // the nav.push has a return value from the cityscreen page and the await means we have to wait for the user
                            // to type the city the want and send it back to the nav before the returecityname is created and initialised,
                            // but before it does any on this it will first take you to the cityscreen page.
                      }));
                      print(returnCityName);
                      if (returnCityName != null){
                        var cityWeatherInfo = await weather.getCityWeather(returnCityName);
                        UpdateUI(cityWeatherInfo);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°' ?? '20', // the (??) just means if temperature has an error just use 20
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
