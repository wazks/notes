import 'package:flutter/material.dart';

import 'package:notes/note_list.dart';
import 'package:notes/add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('My Notes'),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // ),
      body: const NoteList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotePage()),
          );
        },
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
