import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../file_operations.dart';

class ConfirmScreen extends StatefulWidget {
  final FileOperations fileOperations;
  ConfirmScreen({@required this.fileOperations});

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  List<String> images = [];

  _ConfirmScreenState() {
    _init();
  }

  Future<void> _init() async {
    Directory temp = await getTemporaryDirectory();
    List l = temp.listSync(recursive: true, followLinks: false);
    setState(() {
      this.images.addAll(List.generate(l.length, (index) => l[index].path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx < this.images.length) {
            return Image.file(File(this.images[idx]));
          }
          return null;
        },
      ),
    );
  }
}
