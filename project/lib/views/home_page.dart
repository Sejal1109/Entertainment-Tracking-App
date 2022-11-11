import 'package:flutter/material.dart';
import 'movies_view.dart';
import 'books_view.dart';
import '../views/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Final Project"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.movie)),
              Tab(icon: Icon(Icons.book)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            MoviesView(),
            BooksView(),
          ],

        ),


      ),
    );
  }
}
