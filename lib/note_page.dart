import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/main.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final Note? note;
  final Box<Note>? box;
  const NotePage({Key? key, this.note, Box<Note>? box})
      : box =
            box ?? _initializeBox(), // Initialize 'box' using a private method
        super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late MyAppState appState;

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
    appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            border: Border.all(
                color: Colors
                    .purple.shade200), // Add a border to the title container
            borderRadius:
                BorderRadius.circular(32.0), // Optional: Add rounded corners
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 24),
          child: TextField(
            textAlign: TextAlign.left,
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Content
            Expanded(
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your note here',
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Tags and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tags
                Flexible(
                  child: TextField(
                    controller: tagsController,
                    decoration: const InputDecoration(
                        labelText: 'Tags (separated by spaces)'),
                  ),
                ),

                const SizedBox(width: 16.0),

                // Date
                Text(
                  editedNote != null
                      ? 'Last Edit: ${editedNote!.modificationDate}'
                      : '',
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Save Button
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
                    appState.removeNote(editedNote!.title, appState.notesBox);
                  }
                  appState.addNote(note, appState.notesBox);
                  Navigator.pop(context);
                } else {
                  // Logic to handle the case where the note already exists
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }

  Box<Note> initializeBox() {
    return appState.notesBox;
  }
}
