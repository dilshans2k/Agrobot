import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CamerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Please click of upload your plant photo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Please click of upload your plant photo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// List of cameras available to use on device
  List<CameraDescription> _cameras;

  /// The controller for the selected camera
  CameraController _cameraController;

  /// Indicator of whether an async operation is in progress or not
  bool _isLoading = false;

  /// The file for storing the picture taken
  File _cameraPhoto;

  /// The file for storing the camera video
  File _cameraVideo;

  /// Indicator of whether we are capturing a video or not
  String _capturingVideoPath;

  FlickManager flickManager;

  @override
  void initState() {
    _isLoading = true;
    _initCamera();
    super.initState();
  }

  /// Initialise the camera
  _initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() async {
    await _cameraController?.dispose();
    await flickManager?.dispose();
    super.dispose();
  }

  _takePicture() async {
    if (_cameraController.value.isInitialized && _cameraPhoto == null) {
      // Construct the path where the image should be saved using the path
      // package.
      final path = join(
        // Store the picture in the temp directory.
        (await getTemporaryDirectory()).path,
        '${DateTime.now().toIso8601String()}.png',
      );
      await _cameraController.takePicture();
      setState(() {
        _cameraPhoto = File(path);
      });
    }
  }

  _captureVideo(bool start) async {
    if (_cameraController.value.isInitialized && _cameraPhoto == null) {
      if (start) {
        final path = join(
          // Store the picture in the temp directory.
          (await getTemporaryDirectory()).path,
          '${DateTime.now().toIso8601String()}.mp4',
        );
        await _cameraController.startVideoRecording();
        setState(() {
          _capturingVideoPath = path;
        });
      } else {
        if (_cameraController.value.isRecordingVideo) {
          await _cameraController.stopVideoRecording();
          setState(() {
            _cameraVideo = File(_capturingVideoPath);
            flickManager = FlickManager(
              videoPlayerController: VideoPlayerController.file(_cameraVideo),
            );
            _capturingVideoPath = null;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              setState(() {
                _cameraPhoto = null;
                _cameraVideo = null;
              });
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: Text('Tap on the down button'),
            )
          : _cameraVideo != null
              ? Container(
                  child: FlickVideoPlayer(flickManager: flickManager),
                )
              : _cameraPhoto != null
                  ? Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Image.file(
                        _cameraPhoto,
                        fit: BoxFit.fill,
                      ),
                    )
                  : CameraPreview(_cameraController),
      floatingActionButton: _cameraPhoto == null && _cameraVideo == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _takePicture,
                  tooltip: 'Capture',
                  child: Icon(Icons.camera_alt),
                ),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await _captureVideo(_capturingVideoPath == null);
                  },
                  tooltip: 'Take Video',
                  child: Icon(
                    Icons.videocam,
                    color:
                        _capturingVideoPath != null ? Colors.red : Colors.white,
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
