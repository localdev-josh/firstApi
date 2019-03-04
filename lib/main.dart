import 'package:futurelistviewbuilder/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       primaryColor: Color.fromRGBO(239, 108, 0, 1.0),
       accentColor: Color.fromRGBO(3,169,244,1.0),
        textTheme: TextTheme(title: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.white))
      ),
      home:HomePage()
    );
  }
}

