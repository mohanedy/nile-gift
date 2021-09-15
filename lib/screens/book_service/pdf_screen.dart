import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String pdfPath;

  PDFScreen(this.pdfPath);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.pdfPath);
  }

  @override
  Widget build(BuildContext context) {
    final file = File(widget.pdfPath);

    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
          basename(
            file.path,
          ),
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: SfPdfViewer.file(File(
        widget.pdfPath,
      )),
    );
  }
}
