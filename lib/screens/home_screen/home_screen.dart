import 'package:flutter/material.dart';
import 'package:sinc/file_operations.dart';
import '../camera_screen/camera_screen.dart';
import './search_box.dart';
import './doc_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _docNames = [];
  final List<String> _thumbnails = [];
  final fileOperations = FileOperations();

  Future<void> _getDocNames() async {
    await fileOperations.init();
    List<String> featchedNames = await this.fileOperations.getDocPaths();

    setState(() {
      this._docNames.addAll(List.generate(featchedNames.length,
          (index) => featchedNames[index].split('/').last));

      this._thumbnails.addAll(List.generate(
          featchedNames.length, (index) => featchedNames[index] + '/0.png'));
    });
  }

  dynamic deleteCallback(int index) {
    fileOperations.deleteDoc(this._docNames[index]);
    setState(() {
      this._docNames.removeAt(index);
      this._thumbnails.removeAt(index);
    });
  }

  // void _addNewDoc() {
  //   // function to add new document
  //   String fileName = 'New File${this._docNames.length}';
  //   this.fileOperations.createDoc(fileName);
  //   setState(() {
  //     _docNames.add(fileName);
  //     _thumbnails.add('new thumbnail');
  //   });
  // }

  void confirmCallback() {
    this._docNames.clear();
    this._thumbnails.clear();
    _getDocNames();
    print('Called');
  }

  void _launchCamera(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          fileOperations: this.fileOperations,
          confirmCallback: this.confirmCallback,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getDocNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SearchBox(),
          DocList(
            docNames: _docNames,
            thumbnails: _thumbnails,
            deleteCallback: deleteCallback,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera),
        label: Text('Scan'),
        onPressed: () => _launchCamera(context),
      ),
    );
  }
}
