import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wheater_app/model/weather_model.dart';

class RemoteDataSource {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  RemoteDataSource(this.apiKey);

  Future<String> getCurrentCity() async {
    try {
      // Cek apakah layanan lokasi diaktifkan
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi dinonaktifkan.');
      }

      // Cek dan minta izin lokasi jika diperlukan
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Izin lokasi ditolak secara permanen. Silakan aktifkan di pengaturan perangkat.');
      }

      // Dapatkan posisi
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      ));

      // Lakukan reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return place.locality ??
            place.subAdministrativeArea ??
            'Lokasi tidak diketahui';
      } else {
        return 'Lokasi tidak diketahui';
      }
    } catch (e) {
      log('Error dalam getCurrentCity: $e');
      return 'Error: $e';
    }
  }

  Future<WeatherModel> getWeather(String cityName) async {
    final url = Uri.parse('$_baseUrl?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
