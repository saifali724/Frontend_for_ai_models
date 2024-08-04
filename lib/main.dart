import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splashscreen.dart';  // Import your SplashScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const platform = MethodChannel('com.example.camera');

  Future<void> _openCamera() async {
    try {
      await platform.invokeMethod('openCamera');
    } on PlatformException catch (e) {
      // Handle the exception
      print('Failed to open camera: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openCamera,
          child: Text('Open Camera'),
        ),
      ),
    );
  }
}
