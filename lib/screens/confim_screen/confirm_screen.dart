import 'package:flutter/material.dart';
import '../../file_operations.dart';
import '../../export_doc.dart';
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
  final TextEditingController _docNameController =
      TextEditingController(text: '${DateTime.now()}');

  @override
  void initState() {
    super.initState();
    images.addAll(widget.fileOperations.listDir(widget.docPath));
  }

  void _discard(context) {
    // empty the cache and go back to home screen.
    widget.fileOperations.emptyCacheDir();
    Navigator.of(context).pop();
  }

  Future<void> _saveDoc(context) async {
    if (this._docNameController.text.length == 0) {
      this._docNameController.text = '${DateTime.now()}';
    }

    List l = widget.fileOperations
        .listDir(widget.fileOperations.documentDirectory.path);
    final cd =
        await widget.fileOperations.confirmDoc(this._docNameController.text);
    widget.confirmCallback();
    return cd;
  }

  void _saveExport(context) async {
    await _saveDoc(context);
    final ExportDoc exportDoc = ExportDoc(
        fileOperations: widget.fileOperations,
        docName: this._docNameController.text);
    exportDoc.asPdf();
    this._discard(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _docNameController,
          autocorrect: false,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Document name',
          ),
        ),
        leading: IconButton(
          tooltip: 'Discard',
          icon: Icon(Icons.arrow_back),
          onPressed: () => _discard(context),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Save',
            icon: Icon(Icons.save_alt),
            onPressed: () async {
              await _saveDoc(context);
              _discard(context);
            },
          ),
          IconButton(
            tooltip: 'Save and export',
            icon: Icon(Icons.share),
            onPressed: () => _saveExport(context),
          ),
        ],
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
