import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  Map<String, dynamic> story;
  List<dynamic> data;
  int idx;
  StoryScreen({key, @required this.idx, @required this.data}) : super(key: key);
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  double present = 0.0;
  Timer _timer;
  var storyData;
  int index = 0;
  // int idx;
  void _startTimer() {
    _timer = Timer.periodic(Duration(microseconds: 10), (timer) {
      setState(() {
        present += 0.00005;
        if (present > 1) {
          if (index >= widget.data[widget.idx]['pages'].length - 1) {
            _timer.cancel();
            swipeRightMethod();
          } else {
            index += 1;
            _timer.cancel();
            present = 0.0;
            _startTimer();
          }
        }
      });
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          setState(() {
            _timer.cancel();
          });
          Navigator.pop(context);
          return true;
        },
        child: GestureDetector(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage(
                          "${widget.data[widget.idx]['pages'][index]['link']}"),
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
                        LinearProgressIndicator(
                          value: present,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      radius: 30,
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          child: Image.asset(
                                              '${widget.data[widget.idx]['image']}'),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        '${widget.data[widget.idx]['name']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    icon:
                                        Icon(Icons.clear, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        _timer.cancel();
                                      });
                                      Navigator.pop(context);
                                    }),
                              ],
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
                setState(() {
                  if (index > 0) {
                    present = 0.0;
                    index -= 1;
                  } else {}
                });
              } else {
                setState(() {
                  if (index >= widget.data[widget.idx].length - 1) {
                    print(index);
                  } else {
                    present = 0.0;
                    index += 1;
                  }
                });
                print('right-click');
              }
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity > 0) {
                // User swiped Left
                setState(() {
                  if (widget.idx > 0) {
                    print(widget.data[widget.idx]);
                    widget.idx -= 1;
                    index = 0;
                    _timer.cancel();
                    _startTimer();
                  } else {
                    _timer.cancel();
                    Navigator.pop(context);
                  }
                });
                MaterialPageRoute(
                    builder: (context) => StoryScreen(
                          idx: widget.idx,
                          data: widget.data,
                        ));
                print('left swipe');
              } else if (details.primaryVelocity < 0) {
                swipeRightMethod();
                MaterialPageRoute(
                    builder: (context) => StoryScreen(
                          idx: widget.idx,
                          data: widget.data,
                        ));
                // User swiped Right
                print('right swipe');
              }
            }),
      ),
    );
  }

  void swipeRightMethod() {
    return setState(() {
      if (widget.idx < widget.data.length - 1) {
        print(widget.data[widget.idx]);
        widget.idx += 1;
        index = 0;

        _timer.cancel();
        present = 0.0;
        _startTimer();
      } else {
        _timer.cancel();
        present = 0.0;

        Navigator.pop(context);
      }
    });
  }
}
