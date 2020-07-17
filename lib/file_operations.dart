import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileOperations {
  Directory documentDirectory;
  Directory tempDirectory;

  Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    tempDirectory = await getTemporaryDirectory();

    String documentDirPath = directory.path + '/documents';
    // create document directory if does not exist
    this.documentDirectory =
        await Directory(documentDirPath).create(recursive: false);
  }

  Future<List<String>> getDocPaths() async {
    List<FileSystemEntity> docs =
        this.documentDirectory.listSync(recursive: false);

    return List.generate(docs.length, (index) => docs[index].path);
  }

  void createDoc(String docName) {
    Directory(this.documentDirectory.path + '/$docName')
        .createSync(recursive: true);
  }

  void deleteDoc(String docName) {
    Directory(this.documentDirectory.path + '/$docName')
        .deleteSync(recursive: true);
  }

  Future<void> emptyCacheDir() async {
    this.tempDirectory.list(recursive: true).listen((event) async {
      await event.delete(recursive: true);
    });
  }
}
