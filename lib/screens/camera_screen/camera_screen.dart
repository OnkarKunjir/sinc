import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './preview_body.dart';
import '../../colors.dart';
import '../../file_operations.dart';
import '../confim_screen/confirm_screen.dart';

class CameraScreen extends StatefulWidget {
  final FileOperations fileOperations;
  CameraScreen({@required this.fileOperations});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  List<CameraDescription> cameras;
  dynamic _initializeControllerFuture;
  // String tempPath = '';
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

  Future<void> tempSave(context) async {
    String tempPath = widget.fileOperations.tempDirectory.path;
    await controller.takePicture('$tempPath/${DateTime.now()}.png');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmScreen(
          fileOperations: widget.fileOperations,
        ),
      ),
    );
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
      bottomNavigationBar: BottomAppBar(
        color: kPrimary,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Positioned(
              right: 40,
              top: 5,
              child: IconButton(
                  tooltip: 'finish',
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => null),
            )
          ],
        ),
      ),
    );
  }
}
