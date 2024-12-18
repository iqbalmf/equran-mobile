import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark Page'),
      ),
      body: Center(
        child: Text(
          'Saved Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
