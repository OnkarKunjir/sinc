import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PreviewBody extends StatelessWidget {
  final CameraController controller;
  PreviewBody(this.controller);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width,
        height: size.height,
        child: ClipRect(
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Container(
                width: size.width,
                height: size.height,
                child: CameraPreview(controller),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
