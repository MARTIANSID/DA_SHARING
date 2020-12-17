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
  String localUrl = '/data/user/0/com.example.videoPlayer/cache/file_picker/VID-20201027-WA0061.mp4';

  VlcPlayerController controller;

  final int height = 640;
  final int width = 360;
  bool visibile = true;
  double position = 0.0;

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
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    setState(() {
      testUrl = result.files.single.path;
      print(result.files.single.path);
      print('fired');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(children: [
                SizedBox(
                  height: height.toDouble(),
                  width: height.toDouble(),
                  child: VlcPlayer(
                    isLocalMedia: true,
                    controller: controller,
                    aspectRatio: 16 / 9,
                    url: localUrl,
                    placeholder: Center(),
                  ),
                ),
                Positioned(
                    left: 220,
                    top: 500,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 2),
                      opacity: visibile ? 1.0 : 0.0,
                      child: IconButton(
                          icon: Icon(
                            Icons.place,
                            size: 40,
                            color: Colors.red,
                          ),
                          onPressed: () {}),
                    ))
              ]),
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
              RaisedButton(
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
