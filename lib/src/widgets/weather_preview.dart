import 'dart:async';

import 'package:app/src/api/aviation_weather.dart';
import 'package:app/src/api/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPreview extends StatefulWidget {
  WeatherPreview({super.key, required this.constraints});

  BoxConstraints constraints;

  @override
  State<WeatherPreview> createState() => _WeatherPreviewState();
}

class _WeatherPreviewState extends State<WeatherPreview> {
  BoxConstraints get constraints => widget.constraints;

  Position? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  Map<String, dynamic>? _currentGeocodeData;
  Map<String, dynamic>? _currentWeatherData;

  @override
  void initState() {
    super.initState();
    _positionStream =
        Geolocator.getPositionStream().listen((Position? position) async {
      setState(() {
        _currentPosition = position;
      });
      _getCurrentGeocodeData();
      _getCurrentWeatherData();
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: constraints.maxWidth * 0.9,
            height: constraints.maxHeight * 0.2,
            child: _currentWeatherData == null
                ? Center(child: const CircularProgressIndicator())
                : WeatherInfo(
                    currentGeocodeData: _currentGeocodeData,
                    currentWeatherData: _currentWeatherData),
          ),
        ));
  }

  Future<void> _getCurrentGeocodeData() async {
    try {
      final data = await Geocoding().fetchReverseGeocodeData(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          dotenv.env["GEOCODING_API_KEY"] ?? "");
      setState(() {
        _currentGeocodeData = data;
      });
    } on Exception catch (e) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              ));
    }
  }

  Future<void> _getCurrentWeatherData() async {
    try {
      const airportCode = "CYKF"; // TODO get airport code by calculation
      final data = await AviationWeather()
          .getMetar(airportCode, dotenv.env["WEATHER_API_KEY"] ?? "");
      setState(() {
        _currentWeatherData = data;
      });
    } on Exception catch (e) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              ));
    }
  }
}

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    super.key,
    required Map<String, dynamic>? currentGeocodeData,
    required Map<String, dynamic>? currentWeatherData,
  })  : _currentGeocodeData = currentGeocodeData,
        _currentWeatherData = currentWeatherData;

  final Map<String, dynamic>? _currentGeocodeData;
  final Map<String, dynamic>? _currentWeatherData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${_currentGeocodeData!["address"]!["city"]}",
              // "London",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
                "Temperature: ${_currentWeatherData?["temperature"]!["repr"] ?? "null"}")
          ],
        )
      ],
    );
  }
}
