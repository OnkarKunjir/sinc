import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PreviewBody extends StatelessWidget {
  CameraController _controller;
  PreviewBody(this._controller);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller),
      ),
    );
  }
}
