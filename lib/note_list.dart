import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import 'package:notes/note_preview.dart';
import 'package:provider/provider.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final notes = appState.notes;
    notes.sort((a, b) => (b.modificationDate).compareTo((a.modificationDate)));
    return LayoutBuilder(
      builder: (context, constraints) {
        const cardWidth = 300.0;
        const minSpaceBetween = 16.0;
        const containerMargin = 20.0;

        final availableWidth = constraints.maxWidth;
        final maxCardsPerRow = max(
            ((availableWidth -
                        (2 * containerMargin) -
                        (containerMargin - minSpaceBetween)) /
                    (cardWidth + minSpaceBetween))
                .floor(),
            1);

        return ListView.builder(
          itemCount: (notes.length / maxCardsPerRow).ceil(),
          itemBuilder: (context, rowIndex) {
            final startIndex = rowIndex * maxCardsPerRow;
            final endIndex = (rowIndex + 1) * maxCardsPerRow;
            final rowNotes =
                notes.sublist(startIndex, endIndex.clamp(0, notes.length));
            return Container(
              margin: const EdgeInsets.all(containerMargin),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(rowNotes.length, (index) {
                  final Note note = rowNotes[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: minSpaceBetween),
                    child: NotePreview(cardWidth: cardWidth, note: note),
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
