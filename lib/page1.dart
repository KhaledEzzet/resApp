import 'dart:io';
import 'package:flutter/material.dart';
import 'package:khmsta/page2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  File _image;
  final picker = ImagePicker();
  var _imageurl;
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_image != null) Image.file(_image) else Text('No Image Here'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async {
                  final pickedFile =
                      await picker.getVideo(source: ImageSource.gallery);
                  setState(() {
                    if (pickedFile != null) {
                      _image = File(pickedFile.path);
                    } else {
                      print('No image selected.');
                    }
                  });
                },
                child: Text('Pick Image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async {
                  var snapshotImage = await storage
                      .ref()
                      .child('images/usernaem')
                      .putFile(_image);
                  _imageurl = await snapshotImage.ref.getDownloadURL();

                  await FirebaseFirestore.instance
                      .collection('ImageUrl')
                      .add({'ImageUrl': _imageurl});
                },
                child: Text('Upload Image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Page2'),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Page2()));
                },
              ),
            ),
            if (_imageurl != null)
              Image.network(_imageurl)
            else
              Text('No Image From FirebaseStorge'),

            // VideoPlayerController.network();
          ],
        ),
      ),
    );
  }
}
