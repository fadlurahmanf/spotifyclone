import 'package:bloc/bloc.dart';
import 'package:spotifyclone/bloc/FetchState.dart';
import 'package:spotifyclone/entity/SongEntity.dart';

class PlayBloc extends Bloc<Map<String, SongEntity>, PlaySongState>{
  PlayBloc() : super(PlaySongEmpty());

  @override
  Stream<PlaySongState> mapEventToState(Map<String, SongEntity> event) async*{
    var song = event["SONG"];
    if(song!=null){
      if(song.isPlay=="play"){
        yield PlaySongLoaded(songEntity: song);
      }else if(song.isPlay=="pause"){
        yield PlaySongPause(songEntity: song);
      }else{
        yield PlaySongEmpty();
      }
    }else{
      yield PlaySongEmpty();
    }
  }

}

class StatusPlayBloc extends Bloc<String, String>{
  StatusPlayBloc() : super("pause");

  @override
  Stream<String> mapEventToState(String event) async*{
    if(event=="play"){
      yield event;
    }else{
      yield event;
    }
  }

}