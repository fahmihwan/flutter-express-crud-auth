import 'package:fe_flutter/models/book.dart';
import 'package:fe_flutter/services/book_service.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  // state untuk text nya
  final TextEditingController _titleController = TextEditingController();

  void _submit() {
    final title = _titleController.text;

    if (title.isNotEmpty) {
      BookService().createBook(title);

      Navigator.pushNamed(
        context,
        '/home',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // kembali ke halaman sebelumnya
            },
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              border: Border.all(
                width: 1.0,
                color: const Color.fromARGB(255, 187, 187, 187),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "ADD BOOK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: _submit, child: Text("Submit"))
                // Text(_titleController)
              ],
            ),
          ),
        ));
  }
}
