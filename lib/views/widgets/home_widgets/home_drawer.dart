import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        spacing: 10,
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Some item 1'),
          Text('Some item 2'),
        ],
      ),
    );
  }
}
