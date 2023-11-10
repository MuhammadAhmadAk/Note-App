import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Utils/Constants/end_point.dart';
import "package:http/http.dart" as httpClient;

class NoteRepository {
  Dio dio = Dio();

  Future<List<NoteModel>> getNotes(NoteModel notes) async {
    var url = "$baseUrl$getAllNotesEndPoint?uid=${notes.creatorId}";
    List<NoteModel> note;
    try {
      var response = await dio.get(url,
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        List<dynamic> noteList = response.data['data'];
        note = noteList.map((json) => NoteModel.fromJson(json)).toList();
        return note;
      } else {
        throw Exception("there was issue fetching data from server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<NoteModel> addNote(NoteModel notes) async {
    var url = baseUrl + addNotesEndPoint;
    try {
      var response = await dio.post(url,
          data: notes,
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        return NoteModel.fromJson(response.data["data"]);
      } else {
        throw Exception("Error Adding notes");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteNoteById(String noteId) async {
    var url = baseUrl + deleteNoteEndPoint;
    try {
      var response = await dio.delete(
        url,
        data: {"noteId": noteId},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error Deleting note");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    final encodedParams = json.encode(note.toJson());

    try {
      final response = await httpClient.delete(
          Uri.parse(baseUrl + updateNoteEndPoint),
          body: encodedParams,
          headers: {});

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception(json.decode(response.body)['response']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNote(NoteModel note) async {
    print("Note id +${note.id}");
    final encodedParams = json.encode(note.toJson());
     print(encodedParams);
    try {
      final response = await httpClient.put(
          Uri.parse(baseUrl + updateNoteEndPoint),
          body: encodedParams,
          headers: {"Content-Type": "application/json; charset=utf-8"});
      print(response.statusCode);
      print(" res Note id : ${note.id}");
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception(json.decode(response.body)['response']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
