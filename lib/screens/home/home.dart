import 'package:flutter/material.dart';
import 'package:instagram_stories/screens/story/story.dart';

import '../../story.model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<dynamic> storiesList;
  @override
  void initState() {
    super.initState();
    storiesList = loadStories();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: FutureBuilder<dynamic>(
                future: storiesList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemExtent: 80,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Container(
                                      width: 60,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            )),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.blueGrey,
                                          radius: 40,
                                          child: Center(
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                child: Image.asset(
                                                    '${snapshot.data[index]["image"]}')),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 4,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      '${snapshot.data[index]["name"]}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                print(snapshot.data[index]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoryScreen(
                                          story: snapshot.data[index])),
                                );
                              },
                            ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('error');
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
