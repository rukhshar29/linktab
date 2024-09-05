import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
class VideoTabScreen extends StatefulWidget {
  final VoidCallback onShare;

  const VideoTabScreen({super.key, required this.onShare});

  @override
  VideoTabScreenState createState() => VideoTabScreenState();
}

class VideoTabScreenState extends State<VideoTabScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      }).catchError((error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load video: $error')),
          );
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: _controller.value.isInitialized
                ? Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
                : const CircularProgressIndicator(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              String link = 'https://linktab-3f36d.web.app';
              final directory = await getTemporaryDirectory();
              final file = File('${directory.path}/video.mp4');
              final bytes = await rootBundle.load('assets/video.mp4');
              await file.writeAsBytes(bytes.buffer.asUint8List());
              await Share.shareXFiles([XFile(file.path)], text: 'Check out this video: $link');
              if (mounted) {
                widget.onShare(); 
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.share, color: Colors.white),
                SizedBox(width: 10),
                Text('Share', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted) {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          }
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
