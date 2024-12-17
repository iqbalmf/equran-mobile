import 'package:flutter/material.dart';
import 'package:my_equran/presentation/pages/detail_surah_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'home page',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailSurahPage(data: 'data dari homepage!')));
                },
                child: Text("Go to detail page"))
          ],
        ),
      ),
    );
  }
}
