import 'package:flutter/material.dart';
import 'half_clipper.dart';
import 'tab_item.dart';

class TabBar extends StatefulWidget {
  const TabBar({Key? key}) : super(key: key);

  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _positionTween;
  late Animation<double> _positionAnimation;
  late AnimationController _fadeOutController;
  late Animation<double> _fadeFabOutAnimation;
  late Animation<double> _fadeFabInAnimation;
  double fabIconAlpha = 1;
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;
  int currentSelected = 1;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: ANIM_DURATION));
    _fadeOutController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: (ANIM_DURATION ~/ 5)));
    _positionTween = Tween<double>(begin: 0, end: 0);
    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
    _fadeFabOutAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabOutAnimation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });
    _fadeFabInAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.8, 1, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabInAnimation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
      Container(
          height: 65,
          margin: const EdgeInsets.only(top: 45),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ]),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TabItem(
                    selected: currentSelected == 0,
                    iconData: Icons.home,
                    title: "HOME",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.home;
                        currentSelected = 0;
                      });
                      _initAnimationAndStart(_positionAnimation.value, -1);
                    }),
                TabItem(
                    selected: currentSelected == 1,
                    iconData: Icons.search,
                    title: "SEARCH",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.search;
                        currentSelected = 1;
                      });
                      _initAnimationAndStart(_positionAnimation.value, 0);
                    }),
                TabItem(
                    selected: currentSelected == 2,
                    iconData: Icons.person,
                    title: "USER",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.person;
                        currentSelected = 2;
                      });
                      _initAnimationAndStart(_positionAnimation.value, 1);
                    })
              ])),
      IgnorePointer(
          child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Align(
                  heightFactor: 1,
                  alignment: Alignment(_positionAnimation.value, 0),
                  child: FractionallySizedBox(
                      widthFactor: 1 / 3,
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        SizedBox(
                            height: 90,
                            width: 90,
                            child: ClipRect(
                                clipper: HalfClipper(),
                                child: Container(
                                    child: Center(
                                        child: Container(
                                            width: 70,
                                            height: 70,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 8)
                                                ])))))),
                        SizedBox(
                            height: 70,
                            width: 90,
                            child: CustomPaint(
                              painter: HalfPainter(),
                            )),
                        SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 5,
                                        style: BorderStyle.none)),
                                child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Opacity(
                                        opacity: fabIconAlpha,
                                        child: Icon(
                                          activeIcon,
                                          color: Colors.white,
                                        )))))
                      ])))))
    ]);
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;
    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }
}
