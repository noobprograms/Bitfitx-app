import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  VideoCard(
      {this.currentUser,
      this.videoUrl,
      this.vid,
      this.description,
      this.likes,
      this.comments,
      this.time,
      this.uid,
      this.interact,
      super.key});
  final videoUrl;
  final currentUser;
  final description;
  final likes;
  final comments;
  final time;
  final uid;
  final vid;
  final interact;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      errorBuilder: (context, error) => Center(child: Text(error)),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(controller: _chewieController),
      ),
    );
  }
}
