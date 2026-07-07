import 'package:flutter/material.dart';
import '../models/note.dart';
import '../database/database_helper.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void updateNote() async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title cannot be empty"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updatedNote = Note(
      id: widget.note.id,
      title: titleController.text,
      content: contentController.text,
    );

    await DatabaseHelper.instance.update(updatedNote);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Note updated successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  void deleteNote() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.delete(widget.note.id!);

              Navigator.pop(context); // close dialog
              Navigator.pop(context, true); // back home

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Note deleted"),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: updateNote,
                child: const Text("Save Changes"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: deleteNote,
                child: const Text("Delete"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}