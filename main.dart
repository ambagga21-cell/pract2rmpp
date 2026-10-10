import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    ));

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final ctrl = TextEditingController();
  final List<String> notes = [];

  void add() {
    if (ctrl.text.trim().isEmpty) return;
    setState(() {
      notes.add(ctrl.text.trim());
      ctrl.clear();
    });
  }

  void remove(int i) => setState(() => notes.removeAt(i));

  void edit(int i) {
    final e = TextEditingController(text: notes[i]);
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        content: TextField(controller: e),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Отмена')),
          TextButton(
            onPressed: () {
              if (e.text.trim().isNotEmpty) setState(() => notes[i] = e.text.trim());
              Navigator.pop(c);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Заметки')),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(controller: ctrl)),
                IconButton(onPressed: add, icon: const Icon(Icons.add)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (c, i) => ListTile(
                  title: Text(notes[i]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => edit(i),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => remove(i),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}