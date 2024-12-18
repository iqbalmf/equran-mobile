import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/presentation/bookmarkpage/bookmark_page.dart';
import 'package:my_equran/presentation/surahpage/bloc/listsurahbloc.dart';
import 'package:my_equran/presentation/surahpage/surahpage.dart';
import 'injection.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SurahBloc>(create: (context) => di.locator<SurahBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Quran App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    BookmarkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white30,
        elevation: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Bookmark',
          ),
        ],
      ),
    );
  }
}
