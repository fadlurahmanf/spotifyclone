import 'dart:ffi';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyclone/SongDetailUI.dart';
import 'package:spotifyclone/bloc/FetchState.dart';
import 'package:spotifyclone/bloc/PlayBloc.dart';
import 'package:spotifyclone/entity/SongEntity.dart';
import 'package:spotifyclone/home/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  double longDuration = 0;

  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  Widget build(BuildContext context) {
    StatusPlayBloc statusPlayBloc = BlocProvider.of<StatusPlayBloc>(context);
    PlayBloc playBloc = BlocProvider.of<PlayBloc>(context);
    AssetsAudioPlayer.withId("ID_ONLY_ONE").isPlaying.listen((event) {
      if(event){
        statusPlayBloc.add("play");
      }else{
        statusPlayBloc.add("pause");
      }
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: _body[_currentIndex],
            ),
            Container(
              child: BlocBuilder<PlayBloc, PlaySongState>(
                  builder:(context, state){
                    if(state is PlaySongLoaded){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SongDetail(songEntity: state.songEntity,)));
                          },
                        child: Container(
                          color: Color.fromRGBO(190, 215, 209, Random().nextDouble()),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("${state.songEntity.bigPictureAlbum}"),
                                  )
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${state.songEntity.title}", style: TextStyle(color: Colors.white),),
                                    Text("${state.songEntity.artist}"),
                                  ],
                                ),
                              ),
                              BlocBuilder<StatusPlayBloc, String>(
                                builder:(context, status)=> IconButton(icon: status=="play" ? Icon(Icons.pause) : Icon(Icons.play_arrow), onPressed: ()async{
                                  print(status);
                                  if(status=="play"){
                                    print("INI LAGI PLAY");
                                    statusPlayBloc.add("pause");
                                    await AssetsAudioPlayer.withId("ID_ONLY_ONE").pause();
                                  }else{
                                    print("INI SELAIN PLAY");
                                    statusPlayBloc.add("play");
                                    await AssetsAudioPlayer.withId("ID_ONLY_ONE").play();
                                  }
                                }, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      );
                    }else{
                      return Container();
                    }
                  }
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          showSelectedLabels: false,
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

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // final double trackHeight = sliderTheme.trackHeight;
    final double trackHeight = 1;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
