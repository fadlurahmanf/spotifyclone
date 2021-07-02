import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyclone/bloc/PlayBloc.dart';
import 'package:spotifyclone/bloc/SongBloc.dart';
import 'package:spotifyclone/home/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SongBloc>(create: (context)=>SongBloc(),),
        BlocProvider<PlayBloc>(create: (context)=>PlayBloc(),),
        BlocProvider<StatusPlayBloc>(create: (context)=>StatusPlayBloc(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: HomePage(),
      ),
    );
  }
}
