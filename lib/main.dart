import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './screens/home_screen/home_screen.dart';
import './theme.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // final firstCamera = cameras.first;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sinc',
      theme: sincTheme(ThemeData.light()),
      home: HomeScreen(),
    );
  }
}
