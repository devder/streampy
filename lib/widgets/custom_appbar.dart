import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

import '../assets.dart';

class CustomAppbar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppbar({Key key, this.scrollOffset = 0.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      color: // changes the color of the appbar as the user scrolls
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: Responsive(
        mobile: _CustomAppbaarMobile(),
        desktop: _CustomAppbarDesktop(),
      ),
    );
  }
}

class _CustomAppbaarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(children: [
      Image.asset(Assets.netflixLogo0),
      const SizedBox(width: 12.0),
      Expanded(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _AppbarButton(
            title: 'TV Shows',
          ),
          _AppbarButton(
            title: 'Movies',
          ),
          _AppbarButton(
            title: 'My List',
          ),
        ]),
      )
    ]));
  }
}

class _CustomAppbarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(width: 12.0),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AppbarButton(
                    title: 'Home',
                  ),
                  _AppbarButton(
                    title: 'TV Shows',
                  ),
                  _AppbarButton(
                    title: 'Movies',
                  ),
                  _AppbarButton(
                    title: 'Latest',
                  ),
                  _AppbarButton(
                    title: 'My List',
                  ),
                ]),
          ),
          const Spacer(),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.search),
                    iconSize: 28,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  _AppbarButton(
                    title: 'KIDS',
                  ),
                  _AppbarButton(
                    title: 'DVD',
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.card_giftcard),
                    iconSize: 28,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.notifications),
                    iconSize: 28,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ]),
          )
        ],
      ),
    );
  }
}

class _AppbarButton extends StatelessWidget {
  final String title;
  const _AppbarButton({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }
}
