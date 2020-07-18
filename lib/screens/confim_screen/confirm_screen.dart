import 'package:flutter/material.dart';
import '../../file_operations.dart';
import 'dart:io';

class ConfirmScreen extends StatefulWidget {
  final FileOperations fileOperations;
  final String docPath;
  final confirmCallback;
  ConfirmScreen({
    @required this.fileOperations,
    @required this.docPath,
    @required this.confirmCallback,
  });
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    images.addAll(widget.fileOperations.listDir(widget.docPath));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            List p = widget.fileOperations
                .listDir(widget.fileOperations.documentDirectory.path);

            int l = p.length;
            widget.fileOperations.confirmDoc('new doc$l');
            widget.confirmCallback();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          if (index < this.images.length) {
            return Container(
              width: size.width,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Image.file(
                File(this.images[index]),
                fit: BoxFit.fitWidth,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
