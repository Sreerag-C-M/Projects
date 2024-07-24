import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/Home/Components/Quicks/quick1.dart';
import 'package:miniflutter/Home/Components/Quicks/quick2.dart';
import 'package:miniflutter/Home/Components/Quicks/quick3.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

import '../../screens/home.dart';

class Quickpg extends StatelessWidget {
  const Quickpg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      Quick1(),
      Quick2(),
      Quick3(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeWidget(
        pages: pages,
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key? key,
    required this.pages,
    this.testingController,
  }) : super(key: key);

  // This is a parameter to support testing in this repo
  final Controller? testingController;
  final List<Widget> pages;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Controller controller;

  @override
  initState() {
    controller = widget.testingController ?? Controller()
      ..addListener((event) {
        _handleCallbackEvent(event);
      });

    // controller.jumpToPosition(4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context , MaterialPageRoute(builder: (context)=>Hom()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Quicks",
          style: TextStyle(color: Colors.white, fontFamily: "Astonpoliz"),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: TikTokStyleFullPageScroller(
        contentSize: widget.pages.length,
        swipePositionThreshold: 0.2,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 2000,
        // ^ the velocity threshold for smaller scrolls
        animationDuration: const Duration(milliseconds: 400),
        // ^ how long the animation will take
        controller: controller,
        // ^ registering our own function to listen to page changes
        builder: (BuildContext context, int index) {
          return widget.pages[index];
        },
      ),
    );
  }

  void _handleCallbackEvent(ScrollEvent event) {
    print(
        "Scroll callback received with data: {direction: ${event.direction}, success: ${event.success} and page: ${event.pageNo ?? 'not given'}}");
    if (event.percentWhenReleased != null) {
      print("Percent when released: ${event.percentWhenReleased}");
    }
  }
}
