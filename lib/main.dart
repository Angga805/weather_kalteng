import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weather_model.dart'; // Pastikan file ini sudah dibuat sesuai Modul Langkah 2

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuaca Kalteng',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const WeatherKaltengScreen(),
    );
  }
}

class WeatherKaltengScreen extends StatefulWidget {
  const WeatherKaltengScreen({Key? key}) : super(key: key);

  @override
  State<WeatherKaltengScreen> createState() => _WeatherKaltengScreenState();
}

class _WeatherKaltengScreenState extends State<WeatherKaltengScreen> {
  // 1. PENYELESAIAN TUGAS MANDIRI: Penambahan Kota Buntok dan Puruk Cahu beserta koordinatnya
  final List<KaltengCity> kaltengCities = [
    KaltengCity(name: 'Palangkaraya', latitude: -2.2106, longitude: 113.9139),
    KaltengCity(name: 'Sampit (Kotim)', latitude: -2.5333, longitude: 112.9500),
    KaltengCity(name: 'Pangkalan Bun (Kobar)', latitude: -2.6833, longitude: 111.6167),
    KaltengCity(name: 'Muara Teweh (Barito Utara)', latitude: -0.9500, longitude: 114.9000),
    KaltengCity(name: 'Kuala Kapuas (Kapuas)', latitude: -3.0092, longitude: 114.3813),
    // Data tambahan kota Kalteng
    KaltengCity(name: 'Buntok (Barito Selatan)', latitude: -1.7190, longitude: 114.8448),
    KaltengCity(name: 'Puruk Cahu (Murung Raya)', latitude: -0.6354, longitude: 114.5820),
  ];

  late KaltengCity selectedCity;
  CurrentWeather? currentWeather;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    selectedCity = kaltengCities[0];
    fetchWeatherData(selectedCity);
  }

  Future<void> fetchWeatherData(KaltengCity city) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=${city.latitude}&longitude=${city.longitude}&current_weather=true',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          currentWeather = CurrentWeather.fromJson(data['current_weather']);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Gagal mengambil data dari server API.';
          isLoading = false;
        });
      }
    } catch (e) {
      // PENYELESAIAN TUGAS MANDIRI: Menangani pesan error saat luring (dimatikan internetnya)
      setState(() {
        errorMessage = 'Handling Error';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuaca Kalimantan Tengah'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pilih Kabupaten / Kota:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<KaltengCity>(
              value: selectedCity,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: kaltengCities.map((city) {
                return DropdownMenuItem<KaltengCity>(
                  value: city,
                  child: Text(city.name),
                );
              }).toList(),
              onChanged: (newCity) {
                if (newCity != null) {
                  setState(() {
                    selectedCity = newCity;
                  });
                  fetchWeatherData(newCity);
                }
              },
            ),
            const SizedBox(height: 32),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (errorMessage != null)
              Text(
                errorMessage!, 
                style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )
            else if (currentWeather != null)
              Card(
                elevation: 4,
                color: Colors.teal.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        selectedCity.name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${currentWeather!.temperature} °C',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kecepatan Angin: ${currentWeather!.windSpeed} km/h',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      // 2. PENYELESAIAN TUGAS MANDIRI: Menampilkan data weatherCode pada UI
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Kode Cuaca (Weather Code): ${currentWeather!.weatherCode}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}