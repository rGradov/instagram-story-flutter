import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram_stories/story.model.dart';

class StoryScreen extends StatefulWidget {
  Map<String, dynamic> story;
  StoryScreen({key, @required this.story}) : super(key: key);
  // var link = this.story['pages'][1]['link'];
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  double present = 0.0;
  Timer _timer;
  var storyData;
  void _startTimer() {
    _timer = Timer.periodic(Duration(microseconds: 10), (timer) {
      setState(() {
        present += 0.00005;
        if (present > 1) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    _startTimer();
    storyData = widget.story['pages'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        ExactAssetImage("${widget.story['pages'][1]['link']}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 8,
                    right: 8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: present,
                            ),
                          ),
                          // Expanded(
                          //   child: LinearProgressIndicator(
                          //     value: present,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 30,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset('${widget.story['image']}'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '${widget.story['name']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          onPanDown: (DragDownDetails details) {
            double center = MediaQuery.of(context).size.width / 2;
            print(center);
            if (center > details.globalPosition.dx) {
            } else {
              print('right-click');
            }
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity > 0) {
              // User swiped Left
              print('left swipe');
            } else if (details.primaryVelocity < 0) {
              // User swiped Right
              print('right swipe');
            }
          }),
    );
  }
}
