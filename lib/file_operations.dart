import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileOperations {
  Directory documentDirectory;

  Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String documentDirPath = directory.path + '/documents';
    // create document directory if does not exist
    this.documentDirectory =
        await Directory(documentDirPath).create(recursive: false);

    // remove this after implementing
    // await Directory(this.documentDirectory.path + '/Test document')
    //     .create(recursive: false);
  }

  Future<List<String>> getDocPaths() async {
    List<FileSystemEntity> docs =
        this.documentDirectory.listSync(recursive: false);

    return List.generate(docs.length, (index) => docs[index].path);
  }

  Future<void> listDir() {
    this
        .documentDirectory
        .list(recursive: true, followLinks: false)
        .listen((event) {
      print(event.path);
    });
  }

  void createDoc(String docName) {
    Directory(this.documentDirectory.path + '/$docName')
        .createSync(recursive: true);
  }

  void deleteDoc(String docName) {
    Directory(this.documentDirectory.path + '/$docName')
        .deleteSync(recursive: true);
    listDir();
  }
}
