import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String songname;
  final String authorname;
  final bool favourite;
  final String id;
  Song(
      {required this.songname,
      required this.authorname,
      required this.favourite,
      required this.id});

  // factory Song.fromJson(String id,Map<String, dynamic> json) {
  //   return Song(
  //       id: ,
  //       songname: json['songname'],
  //       authorname: json['authorname'],
  //       favourite: json['favourite']);
  // }
}
