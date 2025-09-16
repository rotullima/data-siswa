import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://jnpmktcjbuehpwttfqmx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpucG1rdGNqYnVlaHB3dHRmcW14Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NzY5MDIsImV4cCI6MjA3MzU1MjkwMn0.pSu55icJUtlDow_rBj3bA9bkl0qNR9jsG3e4o6YXUFQ',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Connectivity _connectivity;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();

    // listener perubahan koneksi
    _connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        _isOffline = result == ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Siswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 172, 214, 248),
          secondary: const Color.fromARGB(255, 243, 176, 199),
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins'),
        ),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          const HomeScreen(),

          // overlay kalau offline
          if (_isOffline)
            Container(
              color: Colors.red,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: const SafeArea(
                child: Center(
                  child: Text(
                    "⚠️ Tidak ada koneksi internet",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// error handling
Future<void> getSiswa(BuildContext context) async {
  try {
    final response =
        await Supabase.instance.client.from('siswa').select();

    debugPrint("Data siswa: $response");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data berhasil diambil")),
    );
  } catch (e) {
    debugPrint("Database error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Database error: $e")),
    );
  }
}
