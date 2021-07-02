import 'package:flutter/material.dart';

class PlaylistUI extends StatefulWidget {
  @override
  _PlaylistUIState createState() => _PlaylistUIState();
}

class _PlaylistUIState extends State<PlaylistUI> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("PLAYLIST COMING SOON", style: TextStyle(color: Colors.white),),
    );
  }
}
