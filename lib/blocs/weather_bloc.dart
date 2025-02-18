import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/weather_api.dart';
import '../models/weather_model.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherAPI weatherAPI;
  bool isCelsius = true;

  WeatherBloc(this.weatherAPI) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<ToggleTemperatureUnit>(_onToggleTemperatureUnit);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
  emit(WeatherLoading());
  try {
    final weatherData = await weatherAPI.fetchWeather(event.city);
    final forecastData = await weatherAPI.fetchForecast(event.city);

    final weather = Weather.fromJson(weatherData).copyWith(
      forecast: forecastData,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_city', event.city);

    emit(WeatherLoaded(weather, isCelsius: isCelsius));
  } catch (e) {
    emit(WeatherError('Could not fetch weather data'));
  }
}


  void _onToggleTemperatureUnit(ToggleTemperatureUnit event, Emitter<WeatherState> emit) {
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      isCelsius = !isCelsius;
      emit(WeatherLoaded(currentState.weather, isCelsius: isCelsius));
    }
  }
}
