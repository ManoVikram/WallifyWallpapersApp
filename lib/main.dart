import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';

import './ad_manager.dart';
import './screens/homeScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wallpapers App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.indigo,
        accentColor: Colors.orangeAccent,
      ),
      home: Wallpapers(),
    );
  }
}

class Wallpapers extends StatefulWidget {
  @override
  _WallpapersState createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (contxt, futureSnapshot) {
        if (futureSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("ERROR: Try again later."),
            ),
          );
        }

        if (futureSnapshot.connectionState == ConnectionState.done) {
          return HomeScreen();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  runApp(MyApp());
}
