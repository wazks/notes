import 'package:flutter/material.dart';
import 'package:notes/note_list.dart';
import 'package:notes/note_page.dart';

class QuickNotesPage extends StatefulWidget {
  const QuickNotesPage({super.key});

  @override
  State<QuickNotesPage> createState() => _QuickNotesPageState();
}

class _QuickNotesPageState extends State<QuickNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const NoteList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotePage()),
          );
        },
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
