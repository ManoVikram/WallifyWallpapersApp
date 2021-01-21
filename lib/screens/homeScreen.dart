import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference wallpapers =
      FirebaseFirestore.instance.collection("wallpapers");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallify"),
      ),
      body: StreamBuilder(
        stream: wallpapers.snapshots(),
        builder: (contxt, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Stream ERROR"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(8.0),
            crossAxisCount: 4,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            itemBuilder: (contxt, index) => Material(
              elevation: 7.0,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Hero(
                    tag: snapshot.data.docs[index]["url"],
                    child: FadeInImage(
                      placeholder: AssetImage("assets/placeholder.jpg"),
                      image: NetworkImage(snapshot.data.docs[index]["url"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            itemCount: snapshot.data.docs.length,
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 4),
          );

          // return Image.network(snapshot.data.docs[0]["url"]);
        },
      ),
    );
  }
}
