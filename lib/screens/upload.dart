import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VLCPlayerr extends StatefulWidget {
  VLCPlayerr({Key key}) : super(key: key);

  @override
  _VLCPlayerState createState() => _VLCPlayerState();
}

class _VLCPlayerState extends State<VLCPlayerr> {
  String testUrl =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4';
  String localUrl =
      '/data/user/0/com.example.videoPlayer/cache/file_picker/VID-20201113-WA0011.mp4';

  VlcPlayerController controller;

  final int height = 640;
  final int width = 360;
  bool visibile = true;
  double position = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    controller = VlcPlayerController(onInit: () {
      controller.play();
    });
    controller.addListener(() {
      setState(() {
        position = controller.position.inSeconds.toDouble();
        print('sex : $position');
      });
    });

    super.initState();
  }

  Future<void> filePick() async {
    setState(() {
      isLoading = true;
    });

    FilePickerResult result = await FilePicker.platform.pickFiles(
        // type: FileType.media,
        // allowMultiple: false,
        // allowedExtensions: ['.mp4'],
        withData: false,
        allowCompression: true,
        
        onFileLoading: (status) {
          print('status : $status');
        });
    setState(() {
      isLoading = false;
    });
    setState(() {
      testUrl = result.files.single.path.toString();
      controller.setStreamUrl(
        testUrl,
        isLocalMedia: true,
      );
      print('path: ${result.files.single.path}');
      print('fired : $testUrl');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height.toDouble(),
                    width: height.toDouble(),
                    child: VlcPlayer(
                      isLocalMedia: true,
                      controller: controller,
                      aspectRatio: 16 / 9,
                      url: testUrl,
                      placeholder: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 220,
                      top: 500,
                      child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: visibile ? 1.0 : 0.0,
                        child: IconButton(
                            icon: Icon(
                              Icons.place,
                              size: 40,
                              color: Colors.red,
                            ),
                            onPressed: () {}),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Slider(
                      onChanged: (value) {
                        setState(() {
                          position = value;
                        });
                      },
                      value: 10,
                      min: 0.0,
                      max: 30,
                    ),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    visibile = false;
                  });
                  controller.play();
                },
                child: Text('PLay'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    visibile = true;
                  });
                  controller.pause();
                  print('position:  ${controller.position.inSeconds}');
                },
                child: Text('Pause'),
              ),
              Slider(
                onChanged: (value) {
                  setState(() {
                    position = value;
                  });
                },
                value: 10,
                min: 0.0,
                max: 30,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      onPressed: () {
                        filePick();
                      },
                      child: Text('Movie'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
