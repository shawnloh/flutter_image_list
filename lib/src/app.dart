import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert' show json;
import 'widgets/image_list.dart';

import 'models/image_model.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 1;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;

    var response =
        await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageData = json.decode(response.body);
    var imageModel = ImageModel.fromJson(imageData);
    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: fetchImage,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Lets see some images!'),
      ),
      body: ImageList(images),
    ));
  }
}
