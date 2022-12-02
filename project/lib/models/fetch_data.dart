import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/classes/movie.dart';
import '../classes/movie_cast.dart';
import '../classes/trending.dart';

class Fetch{
  // Stores movies from My List after the initial load to prevent unnecessary API calls
  static Map<int, Movie> cachedMovies = {};
  // Stores all trending movies after the initial load to prevent unnecessary API calls
  static List<Trending<Movie>> cachedTrendingMovies = [];
  // The timestamp of when the cachedTrendingMovies map was last updated
  static DateTime cachedTrendingMoviesLastUpdated = DateTime(0);

  Future<List<Trending<Movie>>> fetchTrendingMovies() async {
    // If the last time the trending movies were updated was below a threshold,
    // return the cached version
    DateTime now = DateTime.now();
    if (now.difference(cachedTrendingMoviesLastUpdated).inMinutes < 10) {
      return cachedTrendingMovies;
    }

    // Enough time has passed, so refresh trending movies from the API
    cachedTrendingMoviesLastUpdated = now;
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=3504ebf3ee269a0d7dbc3e0e586c0768')
    );
    if (response.statusCode == 200) {
      List userMap = jsonDecode(response.body)['results'];
      List<Trending<Movie>> trending = [];
      for (var item in userMap){
        Movie movie = Movie.fromMap(item);
        double rating = (item['vote_average'] / 2);
        Trending<Movie> t = Trending<Movie>(base: movie, rating: rating);
        trending.add(t);
      }
      cachedTrendingMovies = trending;
      return trending;
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  /*Future<List<Trending<Book>>> fetchTrendingBooks() async {

  }*/

  Future<Movie> fetchMovieDetails(int? id) async {
    if (cachedMovies.containsKey(id!)) {
      return cachedMovies[id]!;
    }

    String getId = id.toString();
    print('https://api.themoviedb.org/3/movie/$getId?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US');
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$getId?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US')
    );
    if (response.statusCode == 200) {
      var userMap =  jsonDecode(response.body);
      Movie movie = Movie.fromMap(userMap);
      cachedMovies[id] = movie;
      return movie;
    }else {
      throw Exception('Failed to load trending movies');
    }
  }
  //
  // Future<MovieCast> fetchMovieCast(int? id) async {
  //   String getId = id.toString();
  //   print('https://api.themoviedb.org/3/movie/$getId/credits?api_key=<<api_key>>&language=en-US');
  //   var response = await http
  //       .get(Uri.parse('https://api.themoviedb.org/3/movie/$getId/credits?api_key=<<api_key>>&language=en-US')
  //   );
  //   if (response.statusCode == 200) {
  //     List userMap =  jsonDecode(response.body)['cast'];
  //     List<MovieCast> cast = [];
  //     for (var item in userMap){
  //       trending.add(Cast.fromMap(item));
  //     }
  //     return trending;
  //   }else {
  //     throw Exception('Failed to load trending movies');
  //   }
  // }

}