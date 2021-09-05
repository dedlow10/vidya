import 'package:vidya_mobile/api/models/game.dart';

class Video {
  String title;
  Game game;
  String videoLink;
  String uploadByName;
  DateTime uploadOn;
  String uploadByImage;
  Video(
      {this.title,
      this.game,
      this.videoLink,
      this.uploadByName,
      this.uploadOn,
      this.uploadByImage});
}
