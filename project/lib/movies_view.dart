import 'package:flutter/material.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
            children:[

              Text("Movies Search"),
                 TextFormField(
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     labelText: 'Movie Title',
                   )
                 ),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Year of Movie',
                  )
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Actor',
                  )
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Director',
                  )
              )
        ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>{
            showSnackBarMovie(context),
          },
          child: const Icon(Icons.search)



      ),
    );

    }
  void showSnackBarMovie(BuildContext context){
    var snackBar = SnackBar(
        content: Text("Searching for movie..."),
        action: SnackBarAction(
          label: "OK",
          onPressed:() {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

