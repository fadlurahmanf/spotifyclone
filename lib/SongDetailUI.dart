import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyclone/bloc/PlayBloc.dart';
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
  SongEntity songEntity;
  _SongDetailState({this.songEntity});

  @override
  void dispose() {
    AssetsAudioPlayer.withId("ID_ONE_ONLY").dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusPlayBloc statusPlayBloc = BlocProvider.of<StatusPlayBloc>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("${songEntity.title}", style: TextStyle(color: Colors.white, fontSize: 25),),
                    Text("${songEntity.artist}", style: TextStyle(color: Colors.grey,fontSize: 17),),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 250,
                    width: 250,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(icon: Icon(IconData(62840, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage)), onPressed: ()async{
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
                              }, color: Colors.white,);
                            }else{
                              return IconButton(icon: Icon(IconData(62823, fontPackage: CupertinoIcons.iconFontPackage, fontFamily: CupertinoIcons.iconFont)), onPressed: ()async{
                                statusPlayBloc.add("play");
                                await AssetsAudioPlayer.withId("ID_ONLY_ONE").play();
                              }, color: Colors.white,);
                            }
                          }
                        ),
                        IconButton(icon: Icon(IconData(63103, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage)), onPressed: ()async{

                        }, color: Colors.white,)
                      ],
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
