import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = 'player-screen';
  final String videoId;
  PlayerScreen({this.videoId});
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [];

  @override
  void initState() {
    super.initState();
    _ids.add(widget.videoId);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
   
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          margin: const EdgeInsets.all(18),
          child: YoutubePlayerBuilder(
            onExitFullScreen: () {
              // Navigator.of(context)
              //     .pushReplacement(MaterialPageRoute(builder: (context) {
              //   return HomeScreen();
              // }));
              // // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              controlsTimeOut: Duration(seconds: 10),
              progressIndicatorColor: Colors.amber,
              actionsPadding: const EdgeInsets.all(20),
              progressColors: ProgressBarColors(
                backgroundColor: Colors.amber,
                playedColor: Colors.red,
                // bufferedColor: Colors.white,
                handleColor: Colors.red,
              ),
              bufferIndicator: CircularProgressIndicator(
                strokeWidth: 1,
              ),
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                SafeArea(
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Text(
                        _controller.metadata.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                _controller
                    .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                _showSnackBar('Next Video Started!');
              },
            ),
            builder: (context, player) {
              Size size = MediaQuery.of(context).size;
              return Scaffold(
                body: SafeArea(
                  child: Center(
                    child: Container(
                      height: size.height * 0.3,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Rotate your device to landscape mode to view trailer.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontFamily: GoogleFonts.comfortaa().fontFamily),
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                fontFamily: GoogleFonts.comfortaa().fontFamily),
                          ),
                          Text(
                            'Click Back Button\nto Expolore.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontFamily: GoogleFonts.comfortaa().fontFamily),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Back'))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget _text(String title, String value) {
  //   return RichText(
  //     text: TextSpan(
  //       text: '$title : ',
  //       style: const TextStyle(
  //         color: Colors.blueAccent,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       children: [
  //         TextSpan(
  //           text: value,
  //           style: const TextStyle(
  //             color: Colors.blueAccent,
  //             fontWeight: FontWeight.w300,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
