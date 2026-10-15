// Model untuk Menyimpan Data Kota Kalteng
class KaltengCity {
  final String name;
  final double latitude;
  final double longitude;

// Fungsi untuk memasukkan data nama dan lokasi kota saat pertama kali dibuat
  KaltengCity({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

// Model untuk Data Cuaca Saat Ini (Current Weather)
class CurrentWeather {
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final String time;

// Fungsi untuk memasukkan data cuaca saat pertama kali dibuat
  CurrentWeather({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.time,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['temperature'] as num).toDouble(),
      windSpeed: (json['windspeed'] as num).toDouble(),
      weatherCode: json['weathercode'] as int,
      time: json['time'] as String,
    );
  }
}
