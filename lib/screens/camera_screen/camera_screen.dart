import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './preview_body.dart';
import './bottom_bar.dart';
import '../../file_operations.dart';

class CameraScreen extends StatefulWidget {
  final FileOperations fileOperations;
  final confirmCallback;
  CameraScreen({
    @required this.fileOperations,
    @required this.confirmCallback,
  }) {
    fileOperations.emptyCacheDir();
  }

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  int count = 0;
  bool waiting = false;

  List<CameraDescription> cameras;
  dynamic _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    availableCameras().then((cams) {
      this.cameras = cams;
      controller = CameraController(this.cameras[0], ResolutionPreset.max);
      _initializeControllerFuture = controller.initialize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void tempSave(context) {
    if (!waiting) {
      waiting = true;
      String tempPath = widget.fileOperations.tempDirectory.path;
      controller.takePicture('$tempPath/${DateTime.now()}.png').then(
        (value) {
          waiting = false;
          setState(
            () {
              this.count++;
            },
          );
        },
      );

      // waiting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PreviewBody(controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Take a photo',
        child: Icon(Icons.camera),
        onPressed: () => tempSave(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(
        fileOperations: widget.fileOperations,
        count: count,
        confirmCallback: widget.confirmCallback,
      ),
    );
  }
}
