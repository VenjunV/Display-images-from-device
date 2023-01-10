import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);



  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<dynamic> image = <dynamic>[];
  Future? _futureGetPath;

  @override
  void initState() {
    _getPermission();
    super.initState();
    _futureGetPath = getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMAGES"),
        leading: const Icon(Icons.photo),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _futureGetPath,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var dir = Directory(snapshot.data);
                  if (true) _fetchFiles(dir);
                  return Text(snapshot.data);
                } else {
                  return const Text("Loading");
                }
              },
            ),
          ),
          Expanded(
            flex: 50,
            child: GridView.extent(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              maxCrossAxisExtent: 100,
              children: _getListImg(image),
            ),
          )
        ],
      ),
    );
  }

  void _getPermission() async {
    await Permission.storage.request().isGranted;
    setState(() {});
  }


  Future<String> getImage() {
    return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  }

  _fetchFiles(Directory dir) {
    List<dynamic> listImage = [];
    dir.list().forEach((element) {
      RegExp regExp = RegExp(
          "(gif|jpe?g|tiff?|png|webp|bmp)", caseSensitive: false);
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        image = listImage;
      });
    });
  }

  List<Widget> _getListImg(List<dynamic> img) {
    List<Widget> images = [];
    for (var imagePath in img) {
      images.add(
        Container(
          padding: const EdgeInsets.all(1),
          child: Image.file(imagePath, fit: BoxFit.fitWidth),
        ),
      );
    }
    return images;
  }
}
