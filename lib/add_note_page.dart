import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;

  const AddNotePage({
    super.key,
    this.note,
  });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  Note? editedNote;

  @override
  void initState() {
    super.initState();

    editedNote = widget.note;
    if (editedNote != null) {
      titleController.text = editedNote!.title;
      textController.text = editedNote!.text;
      tagsController.text = editedNote!.tags.join(" ");
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Text'),
              maxLines: 4,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: tagsController,
              decoration: const InputDecoration(
                  labelText: 'Tags (separated by spaces)'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                var note = Note(
                    title: titleController.text,
                    text: textController.text,
                    tags: tagsController.text.split(" "),
                    modificationDate: DateTime.now());
                if (editedNote?.title == note.title ||
                    !appState.notesBox.containsKey(titleController.text)) {
                  if (editedNote?.title != null) {
                    appState.removeNote(editedNote!.title);
                  }
                  appState.addNote(note);
                  Navigator.pop(context);
                } else {
                  //logic to say that the note already exists
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
