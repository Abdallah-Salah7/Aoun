import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnboardingVideo extends StatefulWidget {
  final String videoPath;

  const OnboardingVideo({
    super.key,
    required this.videoPath,
  });

  @override
  State<OnboardingVideo> createState() => _OnboardingVideoState();
}

class _OnboardingVideoState extends State<OnboardingVideo> {
  late VideoPlayerController controller;

  @override
    void initState() {
      super.initState();

      controller = VideoPlayerController.asset(widget.videoPath)
        ..initialize().then((_) {
          controller
            ..setLooping(false)
            ..play();

          controller.addListener(() {
            if (controller.value.position >= controller.value.duration &&
                !controller.value.isPlaying) {
              controller.pause(); // يقف على آخر فريم
            }
          });

          if (mounted) setState(() {});
        });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox();
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }
}