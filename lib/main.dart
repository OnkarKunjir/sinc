import 'package:flutter/material.dart';
import './screens/home_screen/home_screen.dart';
import './theme.dart';

void main() {
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
