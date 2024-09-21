import 'package:flutter/material.dart';
import 'package:flutter_note_app/components/drawer.dart';
import 'package:flutter_note_app/components/note_tile.dart';
import 'package:flutter_note_app/models/note.dart';
import 'package:flutter_note_app/models/note_database.dart';
import 'package:google_fonts/google_fonts.dart';
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
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text("Add Note"),
          content: TextField(
            // enable break lines function to user
            maxLines: null,
            controller: textController,
            cursorColor: Colors.orange,
            decoration: const InputDecoration(
              hintText: "Write your notes here",
            ),
          ),
          actions: [
            // add a cancel button to user
            MaterialButton(onPressed: (){
              textController.clear();
              Navigator.pop(context);
            },
              child: const Text("Cancel"),
            ),

            MaterialButton(
              //add to db
                onPressed: (){
                  // add condition if user leave the field blank
                  if(textController.text.isNotEmpty){
                    context.read<NoteDatabase>().addNotes(textController.text);
                    //clear content after done add notes
                    textController.clear();
                    Navigator.pop(context);
                  }
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
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Edit Note"),
        content: TextField(
          // enable break line function to user
          maxLines: null,
          controller: textController,
          cursorColor: Colors.orange,
        ),
        actions: [
          // add a cancel button to user
          MaterialButton(onPressed: (){
            textController.clear();
            Navigator.pop(context);
          },
            child: const Text("Cancel"),
          ),

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
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text("Delete Note"),
          content: const Text("Confirm to Delete?"),
          actions: [
            // add a cancel button to user
            MaterialButton(onPressed: (){
              Navigator.pop(context);
            },
              child: const Text("No"),
            ),

            //User confirm delete
            MaterialButton(onPressed: (){
              context.read<NoteDatabase>().deleteNote(id);
              Navigator.pop(context);
            },
              child: const Text("Yes"),
            ),

          ],
        ),
    );
}

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: createNote,
        child:  Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Make Heading 2
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary
              ),
            ),
          ),

          // List of Notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
                itemBuilder: (context, index){
                  //get notes
                  final note = currentNotes[index];

            //make UI of return a list of note
            return NoteTile(
                text: note.text,
                onEditPressed: ()=> updateNote(note),
                onDeletePressed: ()=>deleteNote(note.id),
            );
                }
            ),
          ),
        ],
      ),
    );
  }
}
