import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'vlcc.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: MyAppScaffold());
  }
}

class MyAppScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppScaffoldState();
}

class MyAppScaffoldState extends State<MyAppScaffold> {
  Uint8List image;

  VlcPlayerController _videoViewController;

  @override
  void initState() {
    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });
    _videoViewController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _videoViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new VlcPlayer(
                  aspectRatio: 16 / 9,
                  url:
                      'http://download1322.mediafire.com/p6803peashxg/7vzv2n0gzbsyan0/Impractical.Jokers.S08E01.720p.WebRip.allone.mp4',
                  controller: _videoViewController,
                  placeholder: Container(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(children: <Widget>[
                    SizedBox(
                      width: 300,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      onPressed: _videoViewController.pause,
                      child: Icon(
                        Icons.pause,
                        size: 50.0,
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      onPressed: () =>
                          _videoViewController.setPlaybackSpeed(0.5),
                      child: Icon(
                        Icons.replay_10,
                        size: 50.0,
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      onPressed: _videoViewController.play,
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 50.0,
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      onPressed: () =>
                          _videoViewController.setPlaybackSpeed(2.0),
                      child: Icon(
                        Icons.forward_10,
                        size: 50.0,
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      onPressed: () =>
                          _videoViewController.setPlaybackSpeed(1.0),
                      child: Icon(
                        Icons.stop,
                        size: 50.0,
                      ),
                    ),
                  ]),
                  SizedBox(
                    width: 100.0,
                  ),
                  Text(
                      "" +
                          _videoViewController.position.inSeconds.toString() +
                          "/" +
                          _videoViewController.duration.inSeconds.toString() +
                          ", speed=" +
                          _videoViewController.playbackSpeed.toString(),
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          backgroundColor: Colors.black)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                    child: Icon(
                      Icons.keyboard_backspace,
                      size: 35.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

