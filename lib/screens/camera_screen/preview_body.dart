import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PreviewBody extends StatelessWidget {
  CameraController controller;
  PreviewBody(this.controller);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Center(
        child: Container(
      width: size,
      height: size,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Container(
              width: size,
              height: size / controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
          ),
        ),
      ),
    ));
  }
}
