# Cuaca Kalimantan Tengah

## Ijin jelasin fungsi/untuk apa app ini

Aplikasi Flutter untuk melihat cuaca saat ini di beberapa kabupaten dan kota di Kalimantan Tengah. Pengguna dapat memilih lokasi, lalu aplikasi mengambil data cuaca terkini dari Open-Meteo.

## Fitur Utama

- Memilih lokasi dari daftar kabupaten/kota di Kalimantan Tengah.
- Menampilkan suhu, kecepatan angin, dan kode cuaca saat ini.
- Memuat data otomatis untuk Palangkaraya saat aplikasi dibuka.
- Menampilkan indikator saat data sedang dimuat dan pesan ketika permintaan gagal.
- Mendukung lokasi Palangkaraya, Sampit, Pangkalan Bun, Muara Teweh, Kuala Kapuas, Buntok, dan Puruk Cahu.

## Arsitektur

Aplikasi Flutter
      │ permintaan HTTP
      ▼
Open-Meteo Forecast API
      │ respons JSON
      ▼
CurrentWeather.fromJson()
      │
      ▼
Tampilan cuaca di aplikasi


Aplikasi menggunakan koordinat tiap kota untuk meminta data `current_weather` dari API Open-Meteo. `KaltengCity` menyimpan nama serta koordinat lokasi, sedangkan `CurrentWeather` mengubah respons JSON menjadi data cuaca yang ditampilkan.

## Struktur Folder

weather_kalteng/
├── android/                
├── ios/                   
├── lib/
│   ├── main.dart            # Aplikasi, daftar kota, permintaan API, dan UI
│   └── weather_model.dart   # Model kota dan data cuaca 
├── pubspec.yaml             # Dependensi dan konfigurasi Flutter
└── README.md                # Dokumentasi proyek

## Menjalankan Aplikasi

Pastikan Flutter SDK sudah terpasang. Dari folder proyek, jalankan:

```bash
flutter pub get
flutter run
```

Perangkat harus terhubung ke internet agar aplikasi dapat mengambil data dari Open-Meteo.
