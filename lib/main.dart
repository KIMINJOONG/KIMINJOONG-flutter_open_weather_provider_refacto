import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_provider_refactor/pages/home_page.dart';
import 'package:open_weather_provider_refactor/providers/providers.dart';
import 'package:open_weather_provider_refactor/providers/weather/weather_provider.dart';
import 'package:open_weather_provider_refactor/repositories/weather_repository.dart';
import 'package:open_weather_provider_refactor/services/weather_api_services.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
            weatherApiServices: WeatherApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        ChangeNotifierProvider<WeatherProvider>(
          create: (context) => WeatherProvider(
            weatherRepository: context.read<WeatherRepository>(),
          ),
        ),
        ChangeNotifierProvider<TempSettingsProvider>(
          create: (context) => TempSettingsProvider(),
        ),
        ProxyProvider<WeatherProvider, ThemeProvider>(
          update: (
            BuildContext context,
            WeatherProvider weatherProvider,
            _,
          ) =>
              ThemeProvider(wp: weatherProvider),
        )
      ],
      builder: (context, _) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: context.watch<ThemeProvider>().state.appTheme == AppTheme.light
            ? ThemeData.light()
            : ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
