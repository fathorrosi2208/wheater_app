import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wheater_app/provider/weather_provider.dart';
import 'package:wheater_app/screen/home_screen/components/app_drawer.dart';
import 'package:wheater_app/screen/utils/constants/colors.dart';
import 'package:wheater_app/screen/utils/helpers/helper_function.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWeatherData();
    });
  }

  Future<void> _loadWeatherData() async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    try {
      await weatherProvider.fetchCurrentCity();
      if (mounted && weatherProvider.currentCity != null) {
        await weatherProvider.fetchWeather(weatherProvider.currentCity!);
      }
    } catch (e) {
      log('Error loading weather data: $e');
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: HelperFunction.isDarkMode(context)
                  ? AppColors.light
                  : AppColors.dark,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (weatherProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${weatherProvider.errorMessage}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: _loadWeatherData,
                      child: const Text('Retry'),
                    ),
                  ),
                ],
              ),
            );
          } else if (weatherProvider.weather != null) {
            return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherProvider.currentCity ?? 'Unknown City',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Lottie.asset(
                    getWeatherAnimation(weatherProvider.weather?.mainCondition),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${weatherProvider.weather!.temperature}°C',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    weatherProvider.weather!.mainCondition,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No data available',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: _loadWeatherData,
                      child: const Text('Load Weather'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
