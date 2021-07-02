import 'package:bloc/bloc.dart';
import 'package:spotifyclone/bloc/BlocEvent.dart';
import 'package:spotifyclone/bloc/FetchState.dart';
import 'package:spotifyclone/services/Response.dart';

class SongBloc extends Bloc<String, FetchState>{
  SongBloc() : super(FetchEmpty());

  @override
  Stream<FetchState> mapEventToState(String event) async*{
    if(event.isNotEmpty){
      SearchResponse search = await ConnectToAPIsong().getSearchBasedQuery("${event}");
      yield FetchSongLoaded(searchResponse: search);
    }else{
      yield FetchEmpty();
    }
  }

}