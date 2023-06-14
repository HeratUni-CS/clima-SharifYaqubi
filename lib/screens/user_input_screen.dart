import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
// I create the All the Ui
class UserInputScreen extends StatefulWidget {
  UserInputScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}
 // Create the Input Text to send the Data
class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int tem;
  String icon;
  String cityName;
  String message;

  @override
  void initState() {
    super.initState();

    update(widget.locationWeather);
  }

  void update(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        tem = 0;
        icon = 'Error';
        message = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      tem = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      icon = weather.getWeatherIcon(condition);
      message = weather.getMessage(temperature);
      cityName = weatherData['name'];
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
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      update(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        update(weatherData);
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
                      '$tem°',
                      style: TextStyle(
                      fontFamily: 'Spartan MB',
                      fontSize: 100.0,
                     );
                    ),
                    Text(
                      weatherIcon,
                      style: TextStyle(
                      fontSize: 100.0,
                      );
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                  fontFamily: 'Spartan MB',
                  fontSize: 60.0,
                 );
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
