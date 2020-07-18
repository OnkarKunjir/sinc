import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import './file_operations.dart';
import 'dart:io';

class ExportDoc {
  final FileOperations fileOperations;
  final String docName;
  ExportDoc({@required this.fileOperations, @required this.docName});

  Future<void> asPdf() async {
    final pdf = pw.Document();
    List imagePaths = this.fileOperations.listDir(
        '${this.fileOperations.documentDirectory.path}/${this.docName}/');

    for (String p in imagePaths) {
      final image = PdfImage.file(
        pdf.document,
        bytes: File(p).readAsBytesSync(),
      );
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            ); // Center
          },
        ),
      );

      final file = File('${this.fileOperations.exportDir.path}/$docName.pdf');
      await file.writeAsBytes(pdf.save());
      final l = this.fileOperations.listDir(this.fileOperations.exportDir.path);
      for (var i in l) {
        print('Export dir content $i');
      }
      return;
    }
  }
}
