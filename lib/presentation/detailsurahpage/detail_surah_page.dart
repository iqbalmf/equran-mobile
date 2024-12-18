import 'package:flutter/material.dart';

class DetailSurahPage extends StatelessWidget {
  DetailSurahPage({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(data)
      ),
      body: Center(
        child: Text('Data yang diterima: $data',
          style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
