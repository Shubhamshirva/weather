import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';
import '../blocs/weather_event.dart';
import '../blocs/weather_state.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Column(
        children: [
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Enter City',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  context.read<WeatherBloc>().add(FetchWeather(_cityController.text));
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text('${state.weather.city}'),
                      Text(state.isCelsius
                          ? '${state.weather.temperature}°C'
                          : '${(state.weather.temperature * 9 / 5) + 32}°F'),
                      ElevatedButton(
                        onPressed: () => context.read<WeatherBloc>().add(ToggleTemperatureUnit()),
                        child: Text('Toggle Unit'),
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Enter a city to get weather info'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
