import 'package:flutter/foundation.dart';
import 'package:flutter_note_app/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  //Operation perform
  static late Isar isar;

  // I  N I T I A L I Z E --  D A T A B A S E
static Future<void> initialize() async{
  final dir = await getApplicationCacheDirectory();
   isar = await Isar.open(
      [NoteSchema],
      directory: dir.path
  );
}

// we need a list to hold notes, referring to note.dart
final List<Note> currentNotes = [];


  //C R E A T E
Future<void> addNotes(String textFromUser) async{

  final newNote = Note()..text = textFromUser;

  //save to db
  await isar.writeTxn(() =>  isar.notes.put(newNote));

  //re-read the db
 fetchNotes();
}

  //R E A D
Future<void> fetchNotes() async{
List<Note> fetchNotes = await isar.notes.where().findAll();
currentNotes.clear();
currentNotes.addAll(fetchNotes);
notifyListeners();
}


  //U P D A T E
Future<void> updateNote(int id, String newText) async{
  final existingNotes = await isar.notes.get(id);
  if(existingNotes != null){
    existingNotes.text = newText;
    await isar.writeTxn(() => isar.notes.put(existingNotes));
    await fetchNotes();
  }
}

  //D E L E T E
Future<void> deleteNote(int id) async{
await isar.writeTxn(() => isar.notes.delete(id));
await fetchNotes();
}

}