import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/home_page.dart';
import 'package:provider/provider.dart';

part 'main.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String text;

  @HiveField(2)
  List<String> tags;

  @HiveField(3)
  DateTime modificationDate;

  Note({
    required this.title,
    this.text = "",
    List<String>? tags,
    required this.modificationDate,
  }) : tags = tags ?? [];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: "Notes",
          theme: ThemeData(primarySwatch: Colors.orange),
          home: const HomePage(),
        ));
  }
}

class MyAppState extends ChangeNotifier {
  late List<Note> notes;
  Box<Note> notesBox = Hive.box('notesBox');

  MyAppState() {
    getNotes();
  }
  void addNote(Note note) {
    notesBox.put(note.title, note);
    getNotes();
    notifyListeners();
  }

  void removeNote(String title) {
    notesBox.delete(title);
    getNotes();
    notifyListeners();
  }

  void getNotes() async {
    notes = notesBox.values.cast<Note>().toList();
  }
}
