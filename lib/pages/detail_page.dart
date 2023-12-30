import 'package:flutter/material.dart';
import 'package:flutter_notes_app/models/note.dart';

class DetailPage extends StatefulWidget {
  final Note note;
  const DetailPage({super.key, required this.note});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
        actions: const [
          Icon(Icons.edit_note),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.delete,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListView(
          children: [
            Text(
              widget.note.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.note.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
