import 'package:clima_weatherapp/screens/city_screen.dart';
import 'package:flutter/cupertino.dart';
// import 'package:clima_weatherapp/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_weatherapp/utilities/constants.dart';
import 'package:clima_weatherapp/services/weather.dart';
import 'package:flutter/widgets.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = new WeatherModel();
  int temperature;
  String cityName;
  String weatherIcon;
  String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.round();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Added LayoutBuilder for scrolling the screen on small displays
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Scaffold(
              // resizeToAvoidBottomInset: false,
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/location_background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
                constraints: BoxConstraints.expand(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: TextButton(
                              onPressed: () async {
                                var weatherData =
                                    await weather.getLocationWeather();
                                updateUI(weatherData);
                              },
                              child: Icon(
                                Icons.near_me,
                                size: 50.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3.0),
                            child: TextButton(
                              onPressed: () async {
                                var typedCityName =
                                    await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                  return CityScreen();
                                }));
                                if (typedCityName != null) {
                                  var weatherData = await weather
                                      .getCityLocation(typedCityName);
                                  updateUI(weatherData);
                                }
                              },
                              child: Icon(
                                Icons.location_city,
                                size: 50.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '$temperature°',
                                style: kTempTextStyle,
                              ),
                              Text(
                                weatherIcon,
                                style: kConditionTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Text(
                            '$weatherMessage in $cityName!',
                            textAlign: TextAlign.right,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
