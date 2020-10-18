import 'dart:io';

import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    Future<void> selectFile() async {
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path);
      }
    }

    return Container(
      child: Center(
          child: GestureDetector(
              onTap: () async {
                await selectFile();
              },
              child: Text("Upload"))),
    );
  }
}
