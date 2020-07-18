import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileOperations {
  Directory documentDirectory;
  Directory tempDirectory;
  Directory exportDir;

  Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    tempDirectory = await getTemporaryDirectory();

    String documentDirPath = directory.path + '/documents';
    String exportDirPath = directory.path + '/exports';
    // create document directory if does not exist
    this.documentDirectory =
        await Directory(documentDirPath).create(recursive: false);
    this.exportDir = await Directory(exportDirPath).create(recursive: false);
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
    File pdf = File(this.exportDir.path + '/$docName.pdf');
    if (pdf.existsSync()) {
      print('Found pdf');
      pdf.delete();
    }
  }

  Future<void> emptyCacheDir() async {
    this.tempDirectory.list(recursive: true).listen((event) async {
      await event.delete(recursive: true);
    });
  }

  List<String> listDir(String path) {
    List dirList =
        Directory(path).listSync(recursive: false, followLinks: false);
    return List.generate(dirList.length, (index) => dirList[index].path);
  }

  Future<void> confirmDoc(String docName) async {
    this.createDoc(docName);
    List path = listDir(this.tempDirectory.path);
    for (int i = 0; i < path.length; i++) {
      File f = await File(path[i])
          .copy('${this.documentDirectory.path}/$docName/$i.png');
    }
  }
}
