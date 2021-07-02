import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResponse{
  List<Song> listSong;
  SearchResponse({this.listSong});
  factory SearchResponse.fromJson(Map<String, dynamic> object){
    var list = object["data"] as List;
    List<Song> songList = list.map((e) => Song.fromJson(e)).toList();
    return SearchResponse(
      listSong: songList
    );
  }
}

class Song{
  String id;
  String title;
  String songPreviewUrl;
  Artist artist;
  Album album;
  Song({this.id, this.title, this.songPreviewUrl, this.artist, this.album});
  factory Song.fromJson(Map<String, dynamic> object){
    return Song(
      id: object["id"].toString(),
      title: object["title"],
      songPreviewUrl: object["preview"],
      artist: Artist.fromJson(object["artist"]),
      album: Album.fromJson(object["album"])
    );
  }
}

class Artist{
  String idArtist;
  String nameArtist;
  Artist({this.idArtist, this.nameArtist});
  factory Artist.fromJson(Map<String,dynamic>object){
    return Artist(
      idArtist: object["id"].toString(),
      nameArtist: object["name"],
    );
  }
}

class Album{
  String idAlbum;
  String smallPictureAlbum;
  String mediumPictureAlbum;
  String bigPictureAlbum;
  Album({this.idAlbum, this.smallPictureAlbum, this.mediumPictureAlbum, this.bigPictureAlbum});
  factory Album.fromJson(Map<String,dynamic>object){
    return Album(
      idAlbum: object["id"].toString(),
      smallPictureAlbum: object["cover_small"],
      mediumPictureAlbum: object["cover_medium"],
      bigPictureAlbum: object["cover_big"]
    );
  }
}

class ConnectToAPIsong{
  Future<SearchResponse> getSearchBasedQuery(String _searchText)async{
    final finalURL = Uri.parse("https://deezerdevs-deezer.p.rapidapi.com/search?q=${_searchText}");
    var result = await http.get(
      finalURL,
      headers: {
        "x-rapidapi-key":"",
        "x-rapidapi-host":"deezerdevs-deezer.p.rapidapi.com",
      }
    );
    var jsonResult = json.decode(result.body);
    return SearchResponse.fromJson(jsonResult);
  }
}