import 'package:flutter/material.dart';
import 'package:spotifyclone/home/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _body[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Color.fromARGB(255, 20, 20, 20)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Playlist",
              backgroundColor: Color.fromARGB(255, 20, 20, 20)
            )
          ],
        ),
      ),
    );
  }

  final List<Widget> _body = [
    Home(),
    Container(child: Text("BODY 2", style: TextStyle(color: Colors.white),),)
  ];

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
