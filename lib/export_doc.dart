import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import './file_operations.dart';
import 'dart:io';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class ExportDoc {
  final FileOperations fileOperations;
  final String docName;
  ExportDoc({@required this.fileOperations, @required this.docName});

  Future<void> asPdf() async {
    File file = File('${this.fileOperations.exportDir.path}/$docName.pdf');
    if (!file.existsSync()) {
      final pdf = pw.Document();
      List imagePaths = this.fileOperations.listDir(
          '${this.fileOperations.documentDirectory.path}/${this.docName}/');

      for (String p in imagePaths) {
        dynamic image = PdfImage.file(
          pdf.document,
          bytes: File(p).readAsBytesSync(),
        );
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image, fit: pw.BoxFit.fill),
              );
            },
          ),
        );
      }
      file = await file.writeAsBytes(pdf.save());
    }
    final bytes = file.readAsBytesSync();
    await Share.file(
      'document',
      '$docName.pdf',
      bytes.buffer.asUint8List(),
      'application/pdf',
    );
    return;
  }
}
