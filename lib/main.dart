import 'package:flutter/material.dart';
import 'package:my_spotify_app/views/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Spotify App',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}
