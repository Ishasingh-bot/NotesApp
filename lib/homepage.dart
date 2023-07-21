import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/models/note_data.dart';
import 'package:provider/provider.dart';

import 'editing_note_page.dart';
import 'note.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void createNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(id: id, text: '');

    //go to note page
    gotoNotePage(newNote, true);
  }

  // go to note editing page
  void gotoNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingNotePage(
            note: note,
            isNewNote: false,
          ),
        ));
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNode(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          child: Icon(Icons.add),
        ),
        // appBar:AppBar(
        //   //elevation: 0,
        //   backgroundColor: Color.fromARGB(255, 153, 186, 243),
        // ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 75),
            child: Text(
              'Notes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          CupertinoListSection.insetGrouped(
              children: List.generate(
            value.getAllNotes().length,
            (index) =>
                CupertinoListTile(title: Text(value.getAllNotes()[index].text)),
          ))
        ]),
      ),
    );
  }
}
