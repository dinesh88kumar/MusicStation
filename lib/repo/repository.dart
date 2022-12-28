import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:musicstation/models/model_class.dart';

class Repo {
  final _firebase = FirebaseFirestore.instance.collection("Songs");

  Future<void> create(
      {required String songname,
      required String authorname,
      required bool favourite}) async {
    try {
      await _firebase.add({
        "songname": songname,
        "authorname": authorname,
        "favourite": favourite
      });
    }
    //
    catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteall() async {
    try {
      var snapshots =
          await FirebaseFirestore.instance.collection("Songs").get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> update(
      {required String songname,
      required String authorname,
      required bool favourite,
      required String id}) async {
    try {
      await _firebase.doc(id).set({
        "songname": songname,
        "authorname": authorname,
        "favourite": favourite
      }, SetOptions(merge: true));
    }
    //
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Song>> get() async {
    List<Song> songList = [];
    try {
      final pro = await FirebaseFirestore.instance.collection("Songs").get();
      pro.docs.forEach((element) {
        return songList.add(Song(
            songname: element.get("songname"),
            authorname: element.get("authorname"),
            favourite: element.get("favourite"),
            id: element.id));
      });
      return songList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with '${e.code}':${e.message}");
      }
      return songList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Song>> getfav() async {
    List<Song> songList = [];
    try {
      final pro = await FirebaseFirestore.instance
          .collection("Songs")
          .where("favourite", isEqualTo: true)
          .get();
      pro.docs.forEach((element) {
        return songList.add(Song(
            songname: element.get("songname"),
            authorname: element.get("authorname"),
            favourite: element.get("favourite"),
            id: element.id));
      });
      return songList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with '${e.code}':${e.message}");
      }
      return songList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
