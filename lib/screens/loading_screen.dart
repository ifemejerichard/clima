import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // this initstate method is one of the multiple methods inside a stataful widget just like the build method,
  // and it is the first method that is called in a stateful widget and with it you tell the stateful widget what to do immediately it is called
  // and unlike build which can be called multiple times when ever we save our code, initstate can only be called once and that is as soon as the stateful widget is called
  // stateful widget methods are inistate, build, didupdatewidget, setstate, dispose
  void initState(){
    super.initState();
    geoLocation();
  }

  void geoLocation () async {

    WeatherModel weatherModel = WeatherModel();

    var weatherModelResult = await weatherModel.getLocationWeatherjson();

    //this if conditions checks if weatherModel.getLocationWeatherjson() returned and error,
    // if no then it goes to the next screen and if yes the it prints 'there was as error from server side on the screen'
    if(weatherModelResult != 'There was an error from the serverside') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(LocationWeatherData: weatherModelResult);
      }));
    }
    else{
        setState(() {
          status = weatherModelResult;
        });
    }
  }
  dynamic status = 'Getting Location & Weather Data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: SpinKitCircle(
                color: Colors.white,
                size: 100),
            ),
            Text('$status', style: TextStyle(fontSize: 17, color: Colors.white)),
          ],
        ),
      )
    );
  }
}
