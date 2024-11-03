import 'package:flutter/material.dart';
import 'package:wheater_app/data/remote_data_source.dart';
import 'package:provider/provider.dart';
import 'package:wheater_app/provider/weather_provider.dart';
import 'package:wheater_app/screen/styles/theme.dart';
import 'package:wheater_app/screen/utils/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => WeatherProvider(
                RemoteDataSource('d7b352a283b9dbac505bb83cfe9f0f59'))),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
