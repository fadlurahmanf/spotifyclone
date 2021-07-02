import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyclone/bloc/FetchState.dart';
import 'package:spotifyclone/bloc/PlayBloc.dart';
import 'package:spotifyclone/bloc/SongBloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  TextEditingController _searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SongBloc songBloc = BlocProvider.of<SongBloc>(context);
    PlayBloc playBloc = BlocProvider.of<PlayBloc>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
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

          SizedBox(height: 50,),

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
                      return GestureDetector(
                        onTap: ()async{
                          playBloc.add(state.searchResponse.listSong[index].id.toString());
                          try{
                            await assetsAudioPlayer.open(
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
                              Expanded(child: BlocBuilder<PlayBloc, String>(
                                builder:(context, id)=> Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${state.searchResponse.listSong[index].title}", style: state.searchResponse.listSong[index].id.toString()==id? TextStyle(color: Colors.green, fontWeight: FontWeight.bold) : TextStyle(color: Colors.white),),
                                    Text("${state.searchResponse.listSong[index].artist.nameArtist}", style: TextStyle(color: Colors.grey),)
                                  ],
                                ),
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
