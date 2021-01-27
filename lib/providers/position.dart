import 'package:flutter/cupertino.dart';

class Pos with ChangeNotifier {
  double position = 0.0;
  bool visible = true;
  bool sliderVisible = true;
  bool playVideo = true;

  void changePosition(pos) {
    position = pos;
    notifyListeners();
  }

  void changeBool(visi, slid) {
    visible = visi;
    sliderVisible = slid;

    notifyListeners();
  }

  void play(play) {
    playVideo = play;
  }
}
