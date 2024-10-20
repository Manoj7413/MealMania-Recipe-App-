import 'package:flutter/material.dart';
import 'package:recipies/Profile%20Page.dart';
import 'package:recipies/myhome.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Catagory.dart'; // Ensure you only have this for icons



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
void main() {
  runApp(MyApp());
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:Myhome(),
    );
  }
}