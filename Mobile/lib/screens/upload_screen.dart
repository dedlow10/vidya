import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../widgets/video_widget.dart';

class UploadScreen extends StatefulWidget {
  UploadScreen() : super();

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final Trimmer _trimmer = Trimmer();
  bool videoOpenTry = false;
  double _startValue = 0.0;
  double _endValue = 0.0;

  File _video;
  String _newFilePath;

  bool _isPlaying;
  bool isVideoUploadSuccess = false;
  bool isVideoLoaded = false;

  Future getVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
      } else {
        print('No video selected.');
      }
    });
  }

  getTrimmer() {
    if (!isVideoLoaded) {
      _trimmer.loadVideo(videoFile: _video);

      isVideoLoaded = true;
    }

    return TrimEditor(
      trimmer: _trimmer,
      viewerHeight: 50.0,
      viewerWidth: MediaQuery.of(context).size.width,
      maxVideoLength: Duration(seconds: 30),
      onChangeStart: (value) {
        _startValue = value;
      },
      onChangeEnd: (value) {
        _endValue = value;
      },
      onChangePlaybackState: (value) {
        setState(() {
          _isPlaying = value;
        });
      },
    );
  }

  getSubmitButton() {
    return MaterialButton(
      height: 35.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: SecondaryColor,
      textColor: Colors.white,
      child: new Text(
        "Share Video",
        style: new TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _trimmer
            .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
            .then((value) {
          setState(() {
            _newFilePath = value;
          });
          isVideoUploadSuccess = true;
        });
      },
      splashColor: PrimaryColor,
    );
  }

  getUploadButton() {
    return MaterialButton(
      height: 50.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: SecondaryColor,
      textColor: Colors.white,
      child: new Text(
        "Upload Video",
        style: new TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      onPressed: () => {getVideo()},
      splashColor: PrimaryColor,
    );
  }

  getUploadSubmit() {
    if (_video != null) {
      return Container(
          child: Column(children: [
        Expanded(child: VideoViewer(trimmer: _trimmer)),
        Padding(padding: EdgeInsets.all(10.0), child: getTrimmer()),
        Padding(padding: EdgeInsets.all(10.0), child: getSubmitButton())
      ]));
    }

    return Container();
  }

  getShareAnotherButton() {
    if (_video != null) {
      return MaterialButton(
        height: 50.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: SecondaryColor,
        textColor: Colors.white,
        child: new Text(
          "Share Another",
          style: new TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          _video = null;
          isVideoUploadSuccess = false;
          isVideoLoaded = false;
          getVideo();
        },
        splashColor: PrimaryColor,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    if (isVideoUploadSuccess) {
      return Container(
          child: Center(
        child: getShareAnotherButton(),
      ));
    } else if (_video == null) {
      return Container(child: Center(child: getUploadButton()));
    } else {
      return Container(child: getUploadSubmit());
    }
  }
}
