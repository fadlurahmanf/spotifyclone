import 'package:equatable/equatable.dart';
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