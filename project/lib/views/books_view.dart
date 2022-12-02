import 'package:flutter/material.dart';
import '../classes/book.dart';
import '../components/drawer.dart';
import 'add_book_form.dart';
import '../models/book_model.dart';
import 'package:project/models/fetch_data_books.dart';

class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);
  @override
  State<BooksView> createState() => _BooksViewState();

}

class _BooksViewState extends State<BooksView> {
  final _fetch = FetchBooks().fetchTrendingBooks();
  var _model = BookModel();
  List<Book> books = [];

  @override
  void initstate(){
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedBookID;
    String? selectedBookName;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Book List")
      ),
      drawer: NavDrawer(),
      body: Center(
          child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${books[index].title}"),
                  subtitle: Text(
                      "Author: ${"${books[index].author}"} Rating: ${books[index].rating}"),
                );
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Book? book = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const addBook()));
          if (book == null) {
            return;
          }
          await _model.insertBook(book);
          setState(() {
            _getData();
          });
        },
      )
    );

  }
  _getData() async{
    books.clear();
    List result = await _model.getAllBooks();
    setState(() {
      for(Book i in result){
        books.add(Book(title: i.title, author: i.author, rating: i.rating));
      }
    });

  }
}