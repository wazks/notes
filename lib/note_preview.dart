import 'package:flutter/material.dart';
import 'package:notes/note_page.dart';
import 'package:notes/main.dart';
import 'package:provider/provider.dart';

class NotePreview extends StatelessWidget {
  const NotePreview({
    Key? key,
    required this.cardWidth,
    required this.note,
  }) : super(key: key);

  static const double radius = 10.0;

  final double cardWidth;
  final Note note;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(
        width: cardWidth,
        height: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    note.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.black54,
                    iconSize: 28,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotePage(note: note, box: appState.notesBox)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            // TEXT
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                note.text,
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const Spacer(),
            // FOOTER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      note.tags.join(" "),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  iconSize: 28,
                  onPressed: () =>
                      appState.removeNote(note.title, appState.notesBox),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
