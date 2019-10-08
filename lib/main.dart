import 'package:flutter/material.dart';
import 'package:the_movie_db/data/datasources/local/database_helper.dart';

import 'view/home.dart';

void main() async {
  DatabaseHelper.db.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        theme: ThemeData(primaryColor: Colors.pink, accentColor: Colors.lightBlue),
        darkTheme: ThemeData.dark(),
        home: Home());
  }
}
