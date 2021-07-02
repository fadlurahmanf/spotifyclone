import 'package:bloc/bloc.dart';

class PlayBloc extends Bloc<String, String>{
  PlayBloc() : super("");

  @override
  Stream<String> mapEventToState(String event) async*{
    if(event.isNotEmpty){
      yield event;
    }
  }

}