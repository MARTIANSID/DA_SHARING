import 'dart:io';

import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:videoPlayer/constants/themes.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future<void> selectFile() async {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        allowedExtensions: ['doc', 'pdf'],
        type: FileType.custom,
      );

      if (result != null) {
        File file = File(result.files.single.path);
      }
    }

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(color: ThemeConstants.BGCOLOR_DARK),
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Icon(Icons.add),
        ),
        onPressed: () {
          selectFile();
        },
      ),
    );
  }
}
