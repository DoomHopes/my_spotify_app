import 'package:flutter/material.dart';
import 'package:my_spotify_app/views/widgets/home_widgets/home_drawer.dart';
import 'package:my_spotify_app/views/widgets/player_widgets/player_view.dart';
import 'package:my_spotify_app/views/widgets/song_widgets/song_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('My Spotify App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: SongWidget(
                    index: index,
                  ),
                );
              },
              itemCount: 100,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: double.infinity,
              color: Theme.of(context).colorScheme.inversePrimary,
              child: PlayerView(),
            ),
          ),
        ],
      ),
    );
  }
}
