import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: MyAppScaffold());
  }
}

class MyAppScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppScaffoldState();
}

class MyAppScaffoldState extends State<MyAppScaffold> {
  Uint8List image;

  VlcPlayerController _videoViewController;
  VlcPlayerController _videoViewController2;

  @override
  void initState() {
    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });
    _videoViewController.addListener(() {
      setState(() {});
    });

    _videoViewController2 = new VlcPlayerController(onInit: () {
      _videoViewController2.play();
    });
    _videoViewController2.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Plugin example app'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: _createCameraImage,
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('baby').snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: 360,
                    child: new VlcPlayer(
                      aspectRatio: 16 / 9,
                      url:
                          snapshot.data.documents[4]['link'],
                      controller: _videoViewController,
                      placeholder: Container(
                        height: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[CircularProgressIndicator()],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 360,
                    child: new VlcPlayer(
                      aspectRatio: 16 / 9,
                      url:
                          snapshot.data.documents[4]['link'],
                      controller: _videoViewController2,
                      placeholder: Container(
                        height: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[CircularProgressIndicator()],
                        ),
                      ),
                    ),
                  ),
                  
                  FlatButton(
                      child: Text("+speed"),
                      onPressed: () =>
                          _videoViewController.setPlaybackSpeed(2.0)),
                  FlatButton(
                      child: Text("Normal"),
                      onPressed: () =>
                          _videoViewController.setPlaybackSpeed(1)),
                  FlatButton(
                      child: Text("-speed"),
                      onPressed: () =>
                          _videoViewController.setPlaybackSpeed(0.5)),
                  Text("position=" +
                      _videoViewController.position.inSeconds.toString() +
                      ", duration=" +
                      _videoViewController.duration.inSeconds.toString() +
                      ", speed=" +
                      _videoViewController.playbackSpeed.toString()),
                  Text("ratio=" + _videoViewController.aspectRatio.toString()),
                  Text("size=" +
                      _videoViewController.size.width.toString() +
                      "x" +
                      _videoViewController.size.height.toString()),
                  Text("state=" + _videoViewController.playingState.toString()),
                  image == null
                      ? Container()
                      : Container(child: Image.memory(image)),
                ],
              ),
            );
          }),
    );
  }

  void _createCameraImage() async {
    Uint8List file = await _videoViewController.takeSnapshot();
    setState(() {
      image = file;
    });
  }
}
