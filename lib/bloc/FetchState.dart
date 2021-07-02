import 'package:equatable/equatable.dart';
import 'package:spotifyclone/entity/SongEntity.dart';
import 'package:spotifyclone/services/Response.dart';

abstract class FetchState extends Equatable{
  const FetchState();

  @override
  List<Object> get props => [];

}

class FetchEmpty extends FetchState{}

class FetchSongLoaded extends FetchState{
  final SearchResponse searchResponse;
  const FetchSongLoaded({this.searchResponse}):assert(searchResponse!=null);
  @override
  List<Object> get props => [searchResponse];
}

abstract class PlaySongState extends Equatable{
  const PlaySongState();
  @override
  List<Object> get props => [];
}

class PlaySongEmpty extends PlaySongState{}

class PlaySongLoaded extends PlaySongState{
  final SongEntity songEntity;
  const PlaySongLoaded({this.songEntity}):assert(songEntity!=null);
  @override
  List<Object> get props => [songEntity];
}

class PlaySongPause extends PlaySongState{
  final SongEntity songEntity;
  const PlaySongPause({this.songEntity}):assert(songEntity!=null);
  @override
  List<Object> get props => [songEntity];
}

