import 'package:flutter/material.dart';
import '../../file_operations.dart';
import '../../export_doc.dart';
import 'dart:io';

class ViewDocScreen extends StatefulWidget {
  final String title;
  final FileOperations fileOperations;
  ViewDocScreen({@required this.fileOperations, @required this.title});
  @override
  _ViewDocScreenState createState() => _ViewDocScreenState();
}

class _ViewDocScreenState extends State<ViewDocScreen> {
  final List images = [];

  Widget _imgContainer(int index) {
    return Container(
      margin: index == 0
          ? EdgeInsets.only(bottom: 5)
          : EdgeInsets.symmetric(vertical: 5),
      child: Image.file(
        File(this.images[index]),
        fit: BoxFit.cover,
      ),
    );
  }

  void _export() {
    final ExportDoc exportDoc =
        ExportDoc(fileOperations: widget.fileOperations, docName: widget.title);
    exportDoc.asPdf();
  }

  @override
  void initState() {
    super.initState();
    images.addAll(
      widget.fileOperations.listDir(
          widget.fileOperations.documentDirectory.path + '/${widget.title}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            tooltip: 'Share',
            icon: Icon(Icons.share),
            onPressed: () => _export(),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          if (index == 0) {
            return Hero(
              tag: widget.title,
              child: this._imgContainer(index),
            );
          } else if (index < this.images.length) {
            return _imgContainer(index);
          }
          return null;
        },
      ),
    );
  }
}
