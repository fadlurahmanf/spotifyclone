import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyclone/bloc/FetchState.dart';
import 'package:spotifyclone/bloc/PlayBloc.dart';
import 'package:spotifyclone/bloc/SongBloc.dart';
import 'package:spotifyclone/entity/SongEntity.dart';
import 'package:spotifyclone/home/homepage.dart';

class SongDetail extends StatefulWidget {
  SongEntity songEntity;
  SongDetail({this.songEntity});
  @override
  _SongDetailState createState() => _SongDetailState(songEntity: songEntity);
}

class _SongDetailState extends State<SongDetail> {
  double position = 0;
  double longDuration = 0;
  int indexSong = 0;
  SongEntity songEntity;
  _SongDetailState({this.songEntity});

  @override
  void dispose() {
    AssetsAudioPlayer.withId("ID_ONE_ONLY").dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    indexSong = songEntity.indexSong;
    StatusPlayBloc statusPlayBloc = BlocProvider.of<StatusPlayBloc>(context);
    SongBloc songBloc = BlocProvider.of<SongBloc>(context);
    PlayBloc playBloc = BlocProvider.of<PlayBloc>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    }, color: Colors.white,),
                    Column(
                      children: [
                        Text("${songEntity.title}", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("${songEntity.artist}", style: TextStyle(color: Colors.grey,fontSize: 17),),
                      ],
                    ),
                    IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){}),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${songEntity.bigPictureAlbum}")
                      )
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: StreamBuilder(
                        stream: AssetsAudioPlayer.withId("ID_ONLY_ONE").currentPosition,
                        builder: (context, snapshot){
                          AssetsAudioPlayer.withId("ID_ONLY_ONE").isPlaying.listen((event) {
                            if(event){
                              position = AssetsAudioPlayer.withId("ID_ONLY_ONE").currentPosition.valueWrapper.value.inMilliseconds.toDouble();
                              longDuration = AssetsAudioPlayer.withId("ID_ONLY_ONE").current.valueWrapper.value.audio.duration.inMilliseconds.toDouble();
                            }else{
                              position = 0;
                            }
                          });
                          return SliderTheme(
                            data: SliderThemeData(
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                              trackShape: CustomTrackShape()
                            ),
                            child: Slider(
                              value: position,
                              min: 0.0,
                              max: longDuration,
                              onChanged: (double positionAdapter){
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40,),
                    BlocBuilder<SongBloc, FetchState>(
                      builder:(context, state){
                        if(state is FetchSongLoaded){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(iconSize: 37,icon: Icon(IconData(62840, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage)), onPressed: ()async{
                                await AssetsAudioPlayer.withId("ID_ONLY_ONE").open(
                                    Audio.network("${songEntity.previewSongFromURL}")
                                );
                              }, color: Colors.white,),
                              BlocBuilder<StatusPlayBloc, String>(
                                  builder:(context, status){
                                    if(status=="play"){
                                      return IconButton(icon: Icon(Icons.pause), onPressed: ()async{
                                        statusPlayBloc.add("pause");
                                        await AssetsAudioPlayer.withId("ID_ONLY_ONE").pause();
                                      }, color: Colors.white, iconSize: 37,);
                                    }else{
                                      return IconButton(iconSize: 37,icon: Icon(IconData(62823, fontPackage: CupertinoIcons.iconFontPackage, fontFamily: CupertinoIcons.iconFont)), onPressed: ()async{
                                        statusPlayBloc.add("play");
                                        await AssetsAudioPlayer.withId("ID_ONLY_ONE").play();
                                      }, color: Colors.white,);
                                    }
                                  }
                              ),
                              IconButton(iconSize: 37,icon: Icon(IconData(63103, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage)), onPressed: ()async{
                                indexSong = indexSong+1;
                                songEntity.title = state.searchResponse.listSong[indexSong].title;
                                songEntity.bigPictureAlbum = state.searchResponse.listSong[indexSong].album.bigPictureAlbum;
                                songEntity.artist = state.searchResponse.listSong[indexSong].artist.nameArtist;
                                songEntity.indexSong = indexSong;
                                songEntity.previewSongFromURL = state.searchResponse.listSong[indexSong].songPreviewUrl;
                                songEntity.idSong = state.searchResponse.listSong[indexSong].id;
                                playBloc.add(songEntity);
                                setState(() {

                                });
                                await AssetsAudioPlayer.withId("ID_ONLY_ONE").open(
                                  Audio.network("${songEntity.previewSongFromURL}")
                                );
                              }, color: Colors.white,)
                            ],
                          );
                        }else{
                          return CircularProgressIndicator();
                        }
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
