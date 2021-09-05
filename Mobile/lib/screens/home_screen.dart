import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../theme.dart';
import '../widgets/video_widget.dart';
import '../api/services/video_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

getTopSection(video) {
  return Row(
    children: [
      Expanded(child: getUserProfileSection(video)),
      Expanded(child: getGameTitleSection(video))
    ],
  );
}

getGameTitleSection(video) {
  return Align(
      alignment: FractionalOffset.bottomRight,
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(video.game.name, style: TextStyle(color: LinkColor))));
}

getUserProfileSection(video) {
  return Align(
      alignment: FractionalOffset.bottomLeft,
      child: Row(children: [
        Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  constraints: BoxConstraints(minHeight: 35),
                  child: Image.network(video.uploadByImage, width: 50))
            ])),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(children: [
                Text(video.uploadByName, style: TextStyle(color: LinkColor)),
              ]),
              Row(children: [
                Text(timeago.format(video.uploadOn),
                    style: TextStyle(color: Colors.white)),
              ])
            ]))
      ]));
}

getBottomSection(video) {
  return Align(
      alignment: FractionalOffset.topCenter,
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(video.title, style: TextStyle(color: Colors.white))));
}

toPage(videos) {
  final List<Widget> _pages = [];

  for (var video in videos) {
    _pages.add(Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                AppBackgroundColor.withOpacity(0.8), BlendMode.multiply),
            image: NetworkImage(video.game.gameTheme.wallpaper),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Expanded(child: getTopSection(video)),
          Container(child: VideoWidget(video.videoLink)),
          Expanded(child: getBottomSection(video)),
        ])));
  }
  return _pages;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = toPage(getVideosByUser(null));
    return PageView(
      scrollDirection: Axis.vertical,
      children: _pages,
      onPageChanged: (int page) {
        // this page variable is the new page and will change before the pageController fully reaches the full, rounded int value
        if (page == (_pages.length - 1)) {
          _pages.addAll(toPage(getVideosByUser(null)));
        }
      },
      controller: PageController(
        initialPage: 0,
      ),
    );
  }
}
