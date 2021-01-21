import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageScreen extends StatelessWidget {
  final String routeName = "/image";

  void downloadImage(String imageURL) async {
    final response = await http.get(imageURL);
    final directory = await getApplicationDocumentsDirectory();

    File file = File(
      path.join(directory.path, imageURL),
    );

    file.writeAsBytesSync(response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    final String imageURL = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          /* decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.grey[300],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ), */
          color: Colors.black87,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: imageURL,
                  child: Image.network(imageURL),
                ),
              ),
              Positioned(
                top: 24,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 28,
                  ),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton.icon(
                    onPressed: () {},
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.cyan,
                    textColor: Colors.white,
                    icon: Icon(Icons.file_download),
                    label: Text("Download"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
