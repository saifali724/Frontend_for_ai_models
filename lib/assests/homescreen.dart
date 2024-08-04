import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Import the image_picker package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // Show a snackbar with the image path
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selected: ${image.path}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home', style: TextStyle(color: Colors.white, fontSize: 25)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          // Apply gradient background
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // Start color: white
                Color(0xFFDCDCDC), // End color: light grey
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Hello User',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: ResponsiveGrid(
                    pickImage: _pickImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Terms & Conditions'),
                          content: SingleChildScrollView(
                            child: Text(
                              'By using our app, you agree to the following terms:\n\n'
                                  'App Functionality: Our app provides image-to-text conversion, camera-to-text capture, and language translation through images and camera.\n\n'
                                  'Accuracy: While we strive for accuracy, we cannot guarantee perfect results. Translation results may vary based on image quality, text clarity, and language complexity.\n\n'
                                  'User Content: You retain ownership of your content. However, by using our app, you grant us a license to process and analyze your images for the purpose of providing our services.\n\n'
                                  'Privacy: We respect your privacy. Please refer to our Privacy Policy for details on how we collect, use, and protect your data.\n\n'
                                  'Intellectual Property: All rights, title, and interest in the app and its content belong to us.\n\n'
                                  'Disclaimer of Warranties: The app is provided "as is" without warranties of any kind.\n\n'
                                  'Limitation of Liability: Our liability for any damages arising from the use of the app is limited.\n\n'
                                  'Modifications: We reserve the right to modify these terms and conditions at any time.',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Center(
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 56), // Space for the BottomAppBar height
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          BottomAppBar(
            child: SizedBox(height: 56, width: 1000),
          ),
          Positioned(
            top: -30,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('lib/assests/logo-05 1.png'),
              radius: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final Future<void> Function(BuildContext, ImageSource) pickImage;

  ResponsiveGrid({required this.pickImage});

  @override
  Widget build(BuildContext context) {
    double gridSpacing = 10;
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int crossAxisCount = (width < 600) ? 2 : 4;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            mainAxisSpacing: gridSpacing,
            crossAxisSpacing: gridSpacing,
            children: [
              HomeButton(
                icon: Icons.image,
                label: 'Image to Text',
                onTap: () => pickImage(context, ImageSource.gallery),
              ),
              HomeButton(
                icon: Icons.camera,
                label: 'Camera to Text',
                onTap: () => pickImage(context, ImageSource.camera),  // Open camera to take a photo
              ),
              HomeButton(
                icon: Icons.translate,
                label: 'Translation by Image',
                onTap: () => pickImage(context, ImageSource.gallery),  // Open gallery to choose an image
              ),
              HomeButton(
                icon: Icons.camera_alt,
                label: 'Translation by Camera',
                onTap: () => pickImage(context, ImageSource.camera),  // Open camera to take a photo
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  HomeButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Change the cursor shape here
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFF208FBC),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
