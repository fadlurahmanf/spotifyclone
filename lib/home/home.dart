import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyclone/bloc/FetchState.dart';
import 'package:spotifyclone/bloc/PlayBloc.dart';
import 'package:spotifyclone/bloc/SongBloc.dart';
import 'package:spotifyclone/entity/SongEntity.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final assetsAudioPlayer = AssetsAudioPlayer();

  var durationMusic = AssetsAudioPlayer.withId("ID_ONLY_ONE").currentPosition.valueWrapper;

  TextEditingController _searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SongBloc songBloc = BlocProvider.of<SongBloc>(context);
    PlayBloc playBloc = BlocProvider.of<PlayBloc>(context);
    StatusPlayBloc statusPlayBloc = BlocProvider.of<StatusPlayBloc>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _searchText,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (text){
                      songBloc.add(text.toLowerCase().toString());
                    },
                    decoration: InputDecoration(
                      hintText: "Search Song by fadlurahmanf",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: InputBorder.none
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.search), onPressed: (){
                  songBloc.add(_searchText.text.toLowerCase().toString());
                }, color: Colors.white,)
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white)
            ),
          ),

          SizedBox(height: 30,),

          Expanded(
            child: BlocBuilder<SongBloc, FetchState>(
              builder: (context, state){
                if(state is FetchEmpty){
                  songBloc.add("stuck with u");
                  return Center(child: CircularProgressIndicator());
                }else if(state is FetchSongLoaded){
                  return ListView.builder(
                    itemCount: state.searchResponse.listSong.length,
                    itemBuilder: (context, index){
                      SongEntity song = SongEntity(
                        idSong: state.searchResponse.listSong[index].id,
                        title: state.searchResponse.listSong[index].title,
                        artist: state.searchResponse.listSong[index].artist.nameArtist,
                        bigPictureAlbum: state.searchResponse.listSong[index].album.bigPictureAlbum,
                        previewSongFromURL: state.searchResponse.listSong[index].songPreviewUrl,
                        indexSong: index,
                      );
                      return GestureDetector(
                        onTap: ()async{
                          statusPlayBloc.add("play");
                          playBloc.add(song);
                          try{
                            await AssetsAudioPlayer.withId("ID_ONLY_ONE").open(
                              Audio.network("${state.searchResponse.listSong[index].songPreviewUrl}"),
                            );
                          }catch(e){
                            print("SALHAHHHHHHHHH ${e.toString()}");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("${state.searchResponse.listSong[index].album.bigPictureAlbum}"),
                                    fit: BoxFit.contain
                                  )
                                ),
                              ),
                              Expanded(child: BlocBuilder<PlayBloc, PlaySongState>(
                                builder:(context, playState){
                                  if(playState is PlaySongLoaded){
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${state.searchResponse.listSong[index].title}", style: state.searchResponse.listSong[index].id.toString()==playState.songEntity.idSong? TextStyle(color: Colors.green, fontWeight: FontWeight.bold) : TextStyle(color: Colors.white),),
                                        Text("${state.searchResponse.listSong[index].artist.nameArtist}", style: TextStyle(color: Colors.grey),)
                                      ],
                                    );
                                  }else{
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${state.searchResponse.listSong[index].title}", style: TextStyle(color: Colors.white),),
                                        Text("${state.searchResponse.listSong[index].artist.nameArtist}", style: TextStyle(color: Colors.grey),)
                                      ],
                                    );
                                  }
                                }
                              )),
                              IconButton(icon: Icon(Icons.more_vert), onPressed: (){}, color: Colors.white,),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      )
    );
  }
}
