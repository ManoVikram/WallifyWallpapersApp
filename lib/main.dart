import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wallpapers App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Wallpapers(),
    );
  }
}

class Wallpapers extends StatefulWidget {
  @override
  _WallpapersState createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

void main() => runApp(MyApp());
