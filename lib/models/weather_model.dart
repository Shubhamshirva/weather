class Weather {
  final String city;
  final double temperature;
  final int humidity;
  final String description;
  final List<Map<String, dynamic>> forecast;

  Weather({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.description,
    required this.forecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      forecast: [], // Placeholder for 3-day forecast
    );
  }

  // ✅ Add this method to allow modifying specific fields
  Weather copyWith({
    String? city,
    double? temperature,
    int? humidity,
    String? description,
    List<Map<String, dynamic>>? forecast,
  }) {
    return Weather(
      city: city ?? this.city,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      description: description ?? this.description,
      forecast: forecast ?? this.forecast,
    );
  }
}
