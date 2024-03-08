import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking{

  final String url;

  Networking({required this.url});

  Future getWeatherData() async {
    late http.Response sentResponse;

    sentResponse = await http.get(Uri.parse(url));
    //this is the API call made to the openweathermap.org to get the weather for the lon & lat in the url.

    if(sentResponse.statusCode == 200){ // 200 is the code for ok in http request, just like 404 is code for page not found.
      String responseData = sentResponse.body; // this will bring out the json code containing all the weather and location info
      //print(responseData);

      //var apiweather = jsonDecode(responseData)['weather'][0]['description']; // this is how you pick out the individual data you want from the json code you back after the API call
      //var apilocation = jsonDecode(responseData)['name'];

      //print(apiweather);
      //print(apilocation);

      return responseData;
    }
    else{
      return ('There was an error from the serverside');
    }
  }
}