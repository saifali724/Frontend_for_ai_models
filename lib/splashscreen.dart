import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'assests/homescreen.dart';
import 'homescreen.dart'; // Ensure this path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const platform = MethodChannel('com.example.camera');
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.easeInOut)),
    );

    _textSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward().whenComplete(() {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      });
    });
  }

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
      body: FadeTransition(
        opacity: _textOpacityAnimation,
        child: SlideTransition(
          position: _textSlideAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(), // Add spacer to distribute space evenly
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Image.asset(
                    'lib/assests/logo-05 1.png', // Ensure this path is correct in pubspec.yaml
                    width: 250, // Adjust the width as needed
                    height: 250, // Adjust the height as needed
                  ),
                ),
                SizedBox(height: 20), // Add some space between the image and the text
                Text(
                  'ORCA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.bold, // Adjust the font size as needed
                  ),
                ),
                Text(
                  'LENS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.bold, // Adjust the font size as needed
                  ),
                ),
                Spacer(), // Add spacer to distribute space evenly
                Text(
                  'Powered By:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Adjust the font size as needed
                  ),
                ),
                Text(
                  'Orca Clan Tech',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Adjust the font size as needed
                  ),
                ),
                SizedBox(height: 20), // Add some space at the bottom
                // ElevatedButton(
                //   onPressed: _openCamera,
                //   child: Text('Open Camera'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
