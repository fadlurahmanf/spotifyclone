import 'package:flutter/material.dart';
import 'package:spotifyclone/entity/SongEntity.dart';

class OptionMenu extends StatefulWidget {
  SongEntity songEntity;
  OptionMenu({this.songEntity});
  @override
  _OptionMenuState createState() => _OptionMenuState(songEntity: songEntity);
}

class _OptionMenuState extends State<OptionMenu> {
  SongEntity songEntity;
  _OptionMenuState({this.songEntity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Colors.transparent, Colors.black]
          )
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${songEntity.bigPictureAlbum}")
                  )
                ),
              ),
              SizedBox(height: 30,),
              Text("${songEntity.title}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
              Text("${songEntity.artist}", style: TextStyle(color: Colors.grey),),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.favorite_border, size: 35, color: Colors.white,),
                    SizedBox(width: 30,),
                    Text("Liked", style: TextStyle(color: Colors.white, fontSize: 20),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.playlist_add, size: 35, color: Colors.white,),
                    SizedBox(width: 30,),
                    Text("Add to Playlist", style: TextStyle(color: Colors.white, fontSize: 20),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.favorite_border, size: 35, color: Colors.white,),
                    SizedBox(width: 30,),
                    Text("Liked", style: TextStyle(color: Colors.white, fontSize: 20),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.album, size: 35, color: Colors.grey[800],),
                    SizedBox(width: 30,),
                    Text("View Album", style: TextStyle(color: Colors.grey[800], fontSize: 20),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.music_note_outlined, size: 35, color: Colors.grey[800],),
                    SizedBox(width: 30,),
                    Text("View Artist", style: TextStyle(color: Colors.grey[800], fontSize: 20),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.share, size: 35, color: Colors.white,),
                    SizedBox(width: 30,),
                    Text("Share", style: TextStyle(color: Colors.white, fontSize: 20),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
