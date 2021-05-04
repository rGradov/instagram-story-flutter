import 'dart:convert';

import 'package:flutter/services.dart';

// class Stories {
//   List<Story> stories;
//   Stories({this.stories});
//   factory Stories.fromJson(Map<String, dynamic> json) {
//     return Stories(stories: Story.fromJson(json) as List<Story>);
//   }
// }

// class Story {
//   final String name;
//   final String image;
//   final List<Pages> pages;

//   Story({this.name, this.image, this.pages});
//   factory Story.fromJson(Map<String, dynamic> json) {
//     return Story(
//       name: json['name'] as String,
//       image: json['image'] as String,
//       pages: Pages.fromJson(json['pages']) as List<Pages>,
//     );
//   }
// }

// class Pages {
//   final String link;
//   Pages({this.link});
//   factory Pages.fromJson(Map<String, dynamic> json) {
//     return Pages(
//       link: json["link"] as String,
//     );
//   }
// }

Future<dynamic> loadStories() async {
  var body = await rootBundle.loadString('assets/data.json');
  var data = json.decode(body);
  print(data);
  return data["stories"];
}
