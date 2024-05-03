import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/note.dart';
import 'package:flutter_note_app/models/note_database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  final textController = TextEditingController();

  //show every start up so it won't disappear
  @override
  void initState() {
    super.initState();
    // whenever start up fetch existing notes
    readNotes();
  }

  //create note
  void createNote(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add Note"),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              //add to db
                onPressed: (){
                  context.read<NoteDatabase>().addNotes(textController.text);

                  //clear content after done add notes
                  textController.clear();

                  Navigator.pop(context);
                },
              child: const Text("Add"),
            ),
          ],
        ),
    );
  }

  //read note
  void readNotes(){
    //read method is part of Provider package, work with initState
    context.read<NoteDatabase>().fetchNotes();
  }

  //update note
  void updateNote(Note note){
    // display the content we added before
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context)=>  AlertDialog(
      title: Text("Edit"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            //edit notes and save to db
            onPressed: (){
              context.read<NoteDatabase>().updateNote(note.id, textController.text);

              //clear content after done edit notes
              textController.clear();

              Navigator.pop(context);
            },
            child: const Text("Edit"),
          ),
        ],
    ),
    );
  }

  //delete note
void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
}

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(title: Text("Notes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
          itemBuilder: (context, index){
            //get notes
            final note = currentNotes[index];

            //make UI of return a list of note
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                ),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (ctx){
                            updateNote(note);
                          },
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: "Edit",
                      ),

                      SlidableAction(
                        onPressed: (ctx){
                        deleteNote(note.id);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: "Delete",
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(note.text),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
