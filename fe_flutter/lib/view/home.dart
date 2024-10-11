import 'package:fe_flutter/models/book.dart';
import 'package:fe_flutter/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BookService bookService = BookService();
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    fetchBook();
  }

  void fetchBook() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString('auth_token');
    // print('cekk $accessToken');
    await bookService.fetchBook().then((value) {
      // showToast("Dsdsd");
      setState(() {
        books = value;
      });

      // Fluttertoast.showToast(
      //   msg: "wlsdkskdksdk",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      // );
    }).catchError((e) {
      print('Error: $e');
    });
  }

  void deleteBook(int id) async {
    final books = await bookService.deleteBook(id);
    fetchBook();
  }

  void _adddData() {
    Navigator.pushNamed(
      context,
      '/tambah-data',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return _CardImage(
                    item: books[index],
                    deleteBook: () => deleteBook(books[index].id));
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _adddData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _CardImage extends StatelessWidget {
  final Book item;
  final VoidCallback deleteBook;
  const _CardImage({required this.item, required this.deleteBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.title),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit-data',
                          arguments: item.id);
                    },
                    child: const Text("Edit")),
              ),
              ElevatedButton(onPressed: deleteBook, child: const Text("Delete"))
            ],
          ),
        ],
      ),
    );
  }
}
