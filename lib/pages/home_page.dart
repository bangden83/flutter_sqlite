import 'package:flutter/material.dart';
import 'package:flutter_notes_app/models/note.dart';
import 'package:flutter_notes_app/pages/detail_page.dart';
import 'package:flutter_notes_app/pages/form_page.dart';
import 'package:flutter_notes_app/utils/notes_database.dart';
import 'package:flutter_notes_app/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
        id: 1,
        title: 'Bensin',
        description: 'ke Lembang habis 1 Juta',
        time: DateTime.now()),
    Note(
        id: 2,
        title: 'Bensin',
        description: 'ke Surabaya habis 5 Juta',
        time: DateTime.now()),
    Note(
        id: 3,
        title: 'Makan',
        description: 'Sama gebetan habis 8 juta',
        time: DateTime.now()),
  ];

  bool isLoading = false;

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DetailPage(note: notes[index]);
                      }));
                    },
                    child: CardWidget(
                      index: index,
                      note: notes[index],
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),

      // Floating button untuk tambah data
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const FormPage();
          }));
          refreshNotes();
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
