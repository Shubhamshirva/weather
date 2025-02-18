import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final String city;
  FetchWeather(this.city);

  @override
  List<Object> get props => [city];
}

class ToggleTemperatureUnit extends WeatherEvent {}
