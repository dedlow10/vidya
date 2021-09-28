import 'dart:convert';

import 'package:vidya_mobile/api/models/game.dart';
import 'package:vidya_mobile/api/models/game_theme.dart';
import '../models/video.dart';
import 'package:http/http.dart' as http;

var leagueOfLegends = Game(
    name: "League of Legends",
    gameTheme: GameTheme(
        backgroundColor: '',
        wallpaper: 'https://mfiles.alphacoders.com/919/thumb-1920-919113.jpg'));
var callOfDuty = Game(
    name: "Call of Duty",
    gameTheme: GameTheme(
        backgroundColor: '',
        wallpaper:
            'https://www.mordeo.org/files/uploads/2019/05/Call-of-Duty-Mobile-4K-Ultra-HD-Mobile-Wallpaper-950x1689.jpg'));

var videos = [
  Video(
      title:
          'Elite500 and Azzapp with Surgical Precision | League of Legends #Shorts',
      game: leagueOfLegends,
      videoLink:
          'https://vidya-vids.s3.amazonaws.com/Elite500+and+Azzapp+with+Surgical+Precision+_+League+of+Legends+%23Shorts.mp4',
      uploadByName: 'VidYaGamer',
      uploadByImage:
          'https://cdn.mos.cms.futurecdn.net/4rjkQphvJwEaKKsE7zES9Q-970-80.jpg.webp',
      uploadOn: DateTime.now()),
  Video(
      title:
          'Call of Duty Modern Warfare: Team Deathmatch Gameplay (No Commentary)',
      game: callOfDuty,
      videoLink:
          'https://vidya-vids.s3.amazonaws.com/9convert.com+-+Call+of+Duty+Modern+Warfare+Team+Deathmatch+Gameplay+No+Commentary.mp4',
      uploadByName: 'Mr. Dooty',
      uploadByImage: 'https://image.flaticon.com/icons/png/512/147/147144.png',
      uploadOn: DateTime.now()),
];

getVideosByUser(user) {
  return videos;
}

Future<List<Video>> getVideos() async {
  var response = await http.get(
    Uri.parse(
        "https://m53zpgra47.execute-api.us-east-1.amazonaws.com/dev/feed"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  List<Video> videos = [];
  var decodedJson = jsonDecode(response.body);
  decodedJson.forEach((element) => {
        videos.add(Video(
            title: element["title"],
            game: leagueOfLegends,
            videoLink: 'https://vidya-vids210750-dev.s3.amazonaws.com/public/' +
                element["blob_reference"] +
                ".mp4",
            uploadByName: 'VidYaGamer',
            uploadByImage:
                'https://cdn.mos.cms.futurecdn.net/4rjkQphvJwEaKKsE7zES9Q-970-80.jpg.webp',
            uploadOn: DateTime.parse(element["created_date"])))
      });
  //print(decodedJson);
  return videos;
}

Future<void> saveVideo(title, blobReference, game) async {
  return http.post(
    Uri.parse(
        "https://m53zpgra47.execute-api.us-east-1.amazonaws.com/dev/video"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'blobReference': blobReference,
      'game': game
    }),
  );
}
