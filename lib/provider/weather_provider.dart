import 'package:flutter/material.dart';
import 'package:wheater_app/model/weather_model.dart';
import 'package:wheater_app/data/remote_data_source.dart';

class WeatherProvider with ChangeNotifier {
  final RemoteDataSource remoteDataSource;

  WeatherProvider(this.remoteDataSource);

  WeatherModel? _weather;
  String? _currentCity;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  String? get currentCity => _currentCity;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCurrentCity() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _currentCity = await remoteDataSource.getCurrentCity();
    } catch (e) {
      _errorMessage = 'Error fetching current city: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeather(String cityName) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _weather = await remoteDataSource.getWeather(cityName);
    } catch (e) {
      _errorMessage = 'Error fetching weather: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
