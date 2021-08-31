import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/models.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({Key key, this.featuredContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110,
          child: SizedBox(
            width: 250,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
        ),
        //setting left and right to 0 expands the widget to the entire screen
        Positioned(
            left: 0,
            right: 0,
            bottom: 40.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  VerticalIconButton(
                      icon: Icons.add, title: 'List', onTap: () {}),
                  _PlayButton(),
                  VerticalIconButton(
                      icon: Icons.info_outline, title: 'Info', onTap: () {}),
                ]))
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({Key key, this.featuredContent})
      : super(key: key);

  @override
  __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
}

class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _videoPlayerController;
  bool isMuted = true;

  @override
  void initState() {
    super.initState();
    //load the video and start playing it.
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..play()
          ..setVolume(0);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          //for the video
          AspectRatio(
            aspectRatio: _videoPlayerController.value.initialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.initialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(widget.featuredContent.imageUrl,
                    fit: BoxFit.cover),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.initialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 250,
                    child: Image.asset(widget.featuredContent.titleImageUrl)),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(2.0, 4.0))
                      ]),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  _PlayButton(),
                  const SizedBox(width: 16.0),
                  TextButton.icon(
                    // style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all<Color>(Colors.white),),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        primary: Colors.black,
                        padding: Responsive.isDesktop(context)
                            ? const EdgeInsets.fromLTRB(25, 10, 30, 10)
                            : const EdgeInsets.fromLTRB(15, 5, 20, 5),
                        textStyle: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600)),
                    icon: const Icon(
                      Icons.info_outline,
                      size: 30.0,
                    ),
                    label: const Text(
                      'More Info',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16.0),
                  if (_videoPlayerController.value.initialized)
                    IconButton(
                      onPressed: () => setState(() {
                        isMuted
                            ? _videoPlayerController.setVolume(100)
                            : _videoPlayerController.setVolume(0);
                        isMuted = _videoPlayerController.value.volume == 0;
                      }),
                      icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                      iconSize: 30.0,
                      color: Colors.white,
                    )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          primary: Colors.black,
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(25, 10, 30, 10)
              : const EdgeInsets.fromLTRB(15, 5, 20, 5),
          textStyle:
              const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
      label: const Text(
        'Play',
      ),
      icon: const Icon(Icons.play_arrow, size: 30.0),
    );
  }
}
