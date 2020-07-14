import 'package:flutter/material.dart';
import './search_box.dart';
import './doc_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _docNames = [];
  _HomeScreenState() {
    _getDocNames();
  }

  Future<void> _getDocNames() async {
    // TODO : Featch the file names from the storage
    const List<String> featchedNames = [];

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _docNames.addAll(featchedNames);
      });
    });
  }

  void _addNewDoc() {
    // TODO : Add new document to storage.
    // function to add new document
    setState(() {
      _docNames.add('New File');
    });
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera),
        label: Text('Scan'),
        onPressed: _addNewDoc,
      ),
    );
  }
}
