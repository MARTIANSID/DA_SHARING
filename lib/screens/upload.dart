import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';
import '../providers/position.dart';

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
  bool visibile;
  bool isLoading = false;
  bool sliderVisibility;
  bool playVideo;
  double position;
  double duration;

  bool picking = false;

  @override
  void initState() {
    controller = VlcPlayerController.network(
      '',
      onInit: () {
        controller.setTime(position.toInt() * 1000);
      },
    );

    playVideo = Provider.of<Pos>(context, listen: false).playVideo;
    sliderVisibility = Provider.of<Pos>(context, listen: false).sliderVisible;
    visibile = Provider.of<Pos>(context, listen: false).visible;


    controller.addListener(() {
      setState(() {
        position = Provider.of<Pos>(context, listen: false).position;
        print(position.toString() + "dlshflsfldisijflidsjfisd");

        controller.getPosition().then((value) {
          Provider.of<Pos>(context).changePosition(value.inSeconds.toDouble());
        });

        print('sex : $position');
      });
    });
    
    controller.getDuration().then((value) => duration = value.inSeconds.toDouble());

    print("hweofhoehf");

    super.initState();
  }

  Future<void> filePick() async {
    setState(() {
      isLoading = true;
    });

    // FilePickerResult result = await FilePicker.platform.pickFiles(
    //     // type: FileType.media,
    //     // allowMultiple: false,
    //     // allowedExtensions: ['.mp4'],
    //     withData: false,
    //     // allowCompression: true,
    //     withReadStream: true,
    //     onFileLoading: (status) {
    //       if (status.toString() == "FilePickerStatus.picking") {
    //         setState(() {
    //           picking = true;
    //         });
    //       } else {
    //         setState(() {
    //           picking = false;
    //         });
    //       }
    //     });
    // testUrl = await FilePicker.platform.getDirectoryPath();

    // // print('testUrl: $testUrl');
    // setState(() {
    //   isLoading = false;
    // });
    // setState(
    //   () {
    //     testUrl = result.files.single.path.toString();
    //     controller.setStreamUrl(
    //       testUrl,
    //       isLocalMedia: true,
    //     );
    //     // print('path: ${result.files.single.path}');
    //     print('fired : $testUrl');
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    position = Provider.of<Pos>(context, listen: false).position;
    playVideo = Provider.of<Pos>(context, listen: false).playVideo;
    sliderVisibility = Provider.of<Pos>(context, listen: false).sliderVisible;
    visibile = Provider.of<Pos>(context, listen: false).visible;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.cyan)),
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? size.height
                        : size.height,
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? size.width
                        : size.width,
                    child: !picking
                        ? VlcPlayer(
                            // autoplay: false,
                            // isLocalMedia: tue,
                            // isLocalMedia: true,
                            controller: controller,
                            aspectRatio: 16 / 9,
                            // url: testUrl,
                            placeholder: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Center(child: Text("Fetching your Movie")),
                  ),

                  Positioned(
                    left: 40,
                    top: 100,
                    // left: 220,
                    // top: 500,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: visibile ? 1.0 : 0.0,

                      // child:

                      //  IconButton(
                      //   icon: Icon(
                      //     Icons.pause,
                      //     size: 40,
                      //     color: Colors.cyan,
                      //   ),
                      //   onPressed: () {},
                      // ),
                    ),
                  ),
                  //  Container(
                  //   height: 100,
                  //   width: 200,
                  //   decoration:
                  //       BoxDecoration(border: Border.all(color: Colors.cyan)),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       print('rishabh');
                  //     },
                  //   ),
                  // ),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber)),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Provider.of<Pos>(context, listen: false)
                                      .changeBool(!visibile, !sliderVisibility);
                                });
                                print('pressed');
                              },
                              child: Text('Tap here '),
                            ),
                          ),
                          AnimatedOpacity(
                            curve: Curves.ease,
                            duration: Duration(milliseconds: 800),
                            opacity: sliderVisibility ? 1.0 : 0.0,
                            child: Column(
                              children: [
                                Slider(
                                  inactiveColor: Colors.grey.shade400,
                                  activeColor: Colors.amber.shade700,
                                  onChanged: (value) {
                                    // controller.setTime(value.toInt());
                                    controller.setTime((1000 * value).toInt());
                                    Provider.of<Pos>(context, listen: false)
                                        .changePosition(value);
                                  },
                                  value: position,
                                  min: 0.0,
                                  max: duration 
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // IconButton(
                                    //   icon: Icon(
                                    //     Icons.pause,
                                    //     color: Colors.white,
                                    //   ),
                                    //   onPressed: () {
                                    //     controller.play();
                                    //   },
                                    // ),
                                    AnimatedOpacity(
                                      opacity: sliderVisibility ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 800),
                                      child: IconButton(
                                        icon: Icon(
                                          playVideo
                                              ? Icons.play_arrow
                                              : Icons.pause,
                                          color: Colors.cyan,
                                        ),
                                        iconSize: 30,
                                        onPressed: () {
                                          playVideo
                                              ? controller.play()
                                              : controller.pause();

                                          setState(() {
                                            Provider.of<Pos>(context,
                                                    listen: false)
                                                .play(!playVideo);
                                          });
                                        },
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity: sliderVisibility ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 800),
                                      child: IconButton(
                                        icon: Icon(
                                          playVideo ? Icons.shop : Icons.shop,
                                          color: Colors.cyan,
                                        ),
                                        iconSize: 30,
                                        onPressed: () {
                                          print(MediaQuery.of(context)
                                              .orientation);
                                          print("helloloo");

                                          MediaQuery.of(context).orientation ==
                                                  Orientation.landscape
                                              ? SystemChrome
                                                  .setPreferredOrientations([
                                                  DeviceOrientation.portraitUp
                                                ])
                                              : SystemChrome
                                                  .setPreferredOrientations([
                                                  DeviceOrientation
                                                      .landscapeRight
                                                ]);
                                        },
                                      ),
                                    ),
                                    isLoading
                                        ? CircularProgressIndicator()
                                        : RaisedButton(
                                            onPressed: () {
                                              // filePick();
                                            },
                                            child: Text('Movie'),
                                          )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // RaisedButton(
              //   onPressed: () {
              //     setState(() {
              //       visibile = false;
              //     });
              //     controller.play();
              //   },
              //   child: Text('PLay'),
              // ),
              // Slider(
              //   activeColor: Colors.amber,
              //   onChanged: (value) {
              //     setState(() {
              //       // controller.setTime(value.toInt());
              //       controller.setTime((1000 * value).toInt());
              //       position = value;
              //     });
              //   },
              //   value: position,
              //   min: 0.0,
              //   max: controller.duration.inSeconds.toDouble(),
              // ),
              // isLoading
              //     ? CircularProgressIndicator()
              //     : RaisedButton(
              //         onPressed: () {
              //           filePick();
              //         },
              //         child: Text('Movie'),
              //       )
            ],
          ),
        ),
      ),
    );
  }
}
