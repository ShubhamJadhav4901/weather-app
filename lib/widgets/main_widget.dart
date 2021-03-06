import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  MainWidget(
      {required this.location,
      required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.weather,
      required this.humidity,
      required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${location.toString()}",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "${temp.toInt().toString()}K",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                "High of ${tempMax.toInt().toString()}K, low of ${tempMin.toInt().toString()}K",
                style: TextStyle(
                    color: Color(0xff9e9e9e),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 75),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5, 5),
                        blurRadius: 8,
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 15, right: 25, left: 25),
                  child: TextField(
                    cursorColor: Colors.purple,
                    cursorHeight: 25,
                    cursorWidth: 4,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: "Enter PinCode",
                        hintStyle: TextStyle(fontSize: 17),
                        border: InputBorder.none),
                  ))
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              WeatherTile(
                  icon: Icons.thermostat_auto_outlined,
                  title: "Temperature",
                  subtitle: '${temp.toInt().toString()}K'),
              WeatherTile(
                  icon: Icons.filter_drama_outlined,
                  title: "Weather",
                  subtitle: '${weather.toString()}'),
              WeatherTile(
                  icon: Icons.wb_sunny,
                  title: "Humidity",
                  subtitle: '${humidity.toString()}%'),
              WeatherTile(
                  icon: Icons.waves_outlined,
                  title: "Wind Speed",
                  subtitle: '${windSpeed.toInt().toString()} mt/sc'),
            ],
          ),
        ))
      ],
    );
  }
}
