import 'package:flutter/material.dart';
import 'package:notes/interactive_calendar_widget.dart';
import 'package:notes/main.dart';
import 'package:notes/note_page.dart';
import 'package:provider/provider.dart';

class DreamJournalPage extends StatefulWidget {
  const DreamJournalPage({super.key});

  @override
  State<DreamJournalPage> createState() => _DreamJournalPageState();
}

class _DreamJournalPageState extends State<DreamJournalPage> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();

    return Scaffold(
      body: InteractiveCalendar(boxType: appState.dreamJournalBox),
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
