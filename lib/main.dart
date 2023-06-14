import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // I clone the project in my VScode
    return MaterialApp(
      theme: ThemeData.dark(),
	  // I clone the project First in My VScode
      home: HomeScreen(),
    );
  }
  
  // the last I push the Data into GitHub
}
