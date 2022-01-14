import 'package:flutter/material.dart';
import 'widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<WeatherInfo> fetchWeather() async {
  final zipCode = "422011";
  final apiKey = "909fefde78c04116925186bff9fe38a5";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?zip=${zipCode},in&appid=${apiKey}";

  final response = await http.get(Uri.parse(requestUrl));
  print("Hello");

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading request url info.");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo(
      {required this.location,
      required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.weather,
      required this.humidity,
      required this.windSpeed});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMax: json['main']['temp_max'],
        tempMin: json['main']['temp_min'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']);
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Weather App',
    theme: ThemeData(
      fontFamily: "archivoblack",
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: FutureBuilder<WeatherInfo>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData && snapshot.data != null) {
                  return MainWidget(
                    location: snapshot.data!.location,
                    temp: snapshot.data!.temp,
                    tempMax: snapshot.data!.tempMax,
                    tempMin: snapshot.data!.tempMin,
                    weather: snapshot.data!.weather,
                    humidity: snapshot.data!.humidity,
                    windSpeed: snapshot.data!.windSpeed,
                  );
                } else {
                  return const Center(
                    child: Text("No Data Available"),
                  );
                }
              }
            },
          ),
        ));
  }
}
