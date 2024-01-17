import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

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
              decoration: const InputDecoration(labelText: 'Tags'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                var note = Note(
                    title: titleController.text,
                    text: textController.text,
                    tags: tagsController.text.split(" "),
                    modificationDate: DateTime.now());
                appState.addNote(note);
                Navigator.pop(context);
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
