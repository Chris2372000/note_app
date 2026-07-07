import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/note.dart';
import 'add_note_screen.dart';
import 'edit_note_screen.dart';
import 'search_notes.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    setState(() => isLoading = true);

    final data = await DatabaseHelper.instance.getNotes();

    setState(() {
      notes = data;
      isLoading = false;
    });
  }

  Future<void> refreshAfterAction() async {
    await loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes (${notes.length})"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NotesSearch(notes),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddNoteScreen(),
            ),
          );

          if (result == true) {
            await refreshAfterAction();
          }
        },
        child: const Icon(Icons.add),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notes.isEmpty
              ? const EmptyState(
                  message: "No notes yet\nTap + to create your first note ✨",
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        tileColor: Colors.blue.withOpacity(0.05),

                        title: Text(
                          note.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          note.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditNoteScreen(note: note),
                            ),
                          );

                          if (result == true) {
                            await refreshAfterAction();
                          }
                        },

                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await DatabaseHelper.instance.delete(note.id!);
                            await refreshAfterAction();

                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Note deleted"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}