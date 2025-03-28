import 'package:flutter/material.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10,
          children: [
            SizedBox(
              width: 30,
              child: Text((index + 1).toString()),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Song name'),
                Text('singer'),
              ],
            ),
          ],
        ),
        Text('albumn name'),
        Text('03:00'),
      ],
    );
  }
}
