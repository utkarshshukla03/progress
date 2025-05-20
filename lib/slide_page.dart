import 'package:flutter/material.dart';
import 'package:progress/page/notification_testing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'ai/alter.dart';
// import 'ai/chat.dart';
import 'notes/note_homepage.dart';
import 'page/home_page.dart';

class Slide extends StatefulWidget {
  const Slide({super.key});

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          children: [
            HomePage(),
            NotePage(),
            ChatScreen(),
          ],
        ),
        // dot indicator
        Container(
            alignment: const Alignment(0.9, 0.9),
            child: SmoothPageIndicator(
                effect: const SlideEffect(
                    activeDotColor: Color.fromARGB(255, 233, 30, 128)),
                controller: _controller,
                count: 4))
      ],
    ));
  }
}

class ChatBot {}
